import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import '/flutter_flow/custom_functions.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

List<MonthCycleStruct> editDurationMonthCycle(
  int newCycleDuration,
  List<MonthCycleStruct> monthCycleList,
  DateTime? month,
  int newMenstruationDuration,
  DateTime? newStartDate,
) {
  DateTime normalizeDate(DateTime d) {
    return DateTime(d.year, d.month, d.day);
  }

  int effectiveMensDuration(int? paramValue, int? structValue) {
    if (paramValue != null && paramValue > 0) return paramValue;
    if (structValue != null && structValue > 0) return structValue;
    return 5;
  }

  DateTime? effectiveStartDate(DateTime? paramValue, List<DateTime> mensDays) {
    if (paramValue != null) return normalizeDate(paramValue);
    if (mensDays.isEmpty) return null;
    final normalized = mensDays.map(normalizeDate).toList()..sort();
    return normalized.first;
  }

  List<DateTime> buildMenstruationDays(DateTime start, int mensDur) {
    return List.generate(
      mensDur,
      (i) => normalizeDate(start.add(Duration(days: i))),
    )..sort();
  }

  List<DateTime> buildOvulationDays(DateTime start, int cycleDur) {
    final ovulationOffset = (cycleDur - 14) - 1;
    final central = start.add(Duration(days: ovulationOffset));
    return [
      for (int i = -4; i <= 2; i++)
        normalizeDate(central.add(Duration(days: i))),
    ]..sort();
  }

  List<DateTime> daysInMonth(List<DateTime> source, DateTime monthValue) {
    final monthStart = DateTime(monthValue.year, monthValue.month, 1);
    final monthEnd = DateTime(monthValue.year, monthValue.month + 1, 1);
    return source
        .map(normalizeDate)
        .where((d) => !d.isBefore(monthStart) && d.isBefore(monthEnd))
        .toList()
      ..sort();
  }

  List<DateTime> removeCollisions(
    List<DateTime> menstruationDays,
    List<DateTime> ovulationDays,
  ) {
    final ovulSet = ovulationDays.map(normalizeDate).toSet();
    return menstruationDays
        .map(normalizeDate)
        .where((d) => !ovulSet.contains(d))
        .toList()
      ..sort();
  }

  if (newStartDate != null) {
    return calendarMonths(
      [],
      newStartDate,
      newCycleDuration,
      newMenstruationDuration,
    );
  }

  if (monthCycleList.isEmpty || newCycleDuration <= 0) return monthCycleList;

  final updatedList = List<MonthCycleStruct>.from(monthCycleList)
    ..sort((a, b) => a.month!.compareTo(b.month!));

  final now = DateTime.now();
  final targetMonth = month != null
      ? DateTime(month.year, month.month, 1)
      : DateTime(now.year, now.month, 1);

  final targetIndex = updatedList.indexWhere(
    (cycle) =>
        cycle.month != null &&
        cycle.month!.year == targetMonth.year &&
        cycle.month!.month == targetMonth.month,
  );
  if (targetIndex == -1) return updatedList;

  final target = updatedList[targetIndex];
  final effectiveMens = effectiveMensDuration(
    newMenstruationDuration,
    target.menstruationDuration,
  );
  final effectiveStart = effectiveStartDate(
    newStartDate,
    target.menstruationDays,
  );
  if (effectiveStart == null) return updatedList;

  final fullMens = buildMenstruationDays(effectiveStart, effectiveMens);

  // 1) Update the target month's menstruation days from the new start/duration.
  updatedList[targetIndex] = MonthCycleStruct(
    month: target.month,
    menstruationDays: daysInMonth(fullMens, target.month!),
    ovulationDays: const [],
    menstruationDuration: effectiveMens,
    cycleDuration: newCycleDuration,
  );

  // 2) Spill the target cycle's menstruation into the next month if it crosses
  //    the month boundary (ovulation is rebuilt globally in step 3).
  if (targetIndex + 1 < updatedList.length) {
    final next = updatedList[targetIndex + 1];
    final spilloverMens = daysInMonth(fullMens, next.month!);
    if (spilloverMens.isNotEmpty) {
      final mergedMens = {
        ...next.menstruationDays.map(normalizeDate),
        ...spilloverMens,
      }.toList()
        ..sort();
      updatedList[targetIndex + 1] = MonthCycleStruct(
        month: next.month,
        menstruationDays: mergedMens,
        ovulationDays: const [],
        menstruationDuration: next.menstruationDuration > 0
            ? next.menstruationDuration
            : effectiveMens,
        cycleDuration:
            next.cycleDuration > 0 ? next.cycleDuration : newCycleDuration,
      );
    }
  }

  // 3) GLOBAL OVULATION REBUILD.
  int cycleDurForStart(DateTime start) {
    for (final c in updatedList) {
      if (c.month != null &&
          c.month!.year == start.year &&
          c.month!.month == start.month &&
          c.cycleDuration > 0) {
        return c.cycleDuration;
      }
    }
    return newCycleDuration > 0 ? newCycleDuration : 28;
  }

  final Set<DateTime> mensSet = {};
  for (final c in updatedList) {
    for (final d in c.menstruationDays) {
      mensSet.add(normalizeDate(d));
    }
  }
  final cycleStarts = mensSet
      .where((d) => !mensSet.contains(d.subtract(const Duration(days: 1))))
      .toList()
    ..sort();

  final Set<DateTime> ovulSet = {};
  for (final s in cycleStarts) {
    ovulSet.addAll(buildOvulationDays(s, cycleDurForStart(s)));
  }
  final allOvul = ovulSet.toList()..sort();

  for (int i = 0; i < updatedList.length; i++) {
    final m = updatedList[i].month!;
    final ovulInMonth = daysInMonth(allOvul, m);
    final mensInMonth =
        removeCollisions(updatedList[i].menstruationDays, ovulInMonth);
    updatedList[i] = MonthCycleStruct(
      month: updatedList[i].month,
      menstruationDays: mensInMonth,
      ovulationDays: ovulInMonth,
      menstruationDuration: updatedList[i].menstruationDuration,
      cycleDuration: updatedList[i].cycleDuration > 0
          ? updatedList[i].cycleDuration
          : newCycleDuration,
    );
  }

  return updatedList;
}
