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

List<MonthCycleStruct> addStartDayToMensCycle(
  List<MonthCycleStruct> monthCycleList,
  DateTime day,
  int? cycleDuration,
  int? menstruationDuration,
) {
  DateTime normalizeDate(DateTime d) {
    return DateTime(d.year, d.month, d.day);
  }

  int effectiveCycleDuration(int? paramValue, int? structValue) {
    if (paramValue != null && paramValue > 0) return paramValue;
    if (structValue != null && structValue > 0) return structValue;
    return 28;
  }

  int effectiveMensDuration(int? paramValue, int? structValue) {
    if (paramValue != null && paramValue > 0) return paramValue;
    if (structValue != null && structValue > 0) return structValue;
    return 5;
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

  List<DateTime> daysInMonth(List<DateTime> source, DateTime month) {
    final monthStart = DateTime(month.year, month.month, 1);
    final monthEnd = DateTime(month.year, month.month + 1, 1);
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

  if (monthCycleList.isEmpty) return monthCycleList;

  final updatedList = List<MonthCycleStruct>.from(monthCycleList);
  final selectedMonthIndex = updatedList.indexWhere(
    (c) =>
        c.month != null &&
        c.month!.year == day.year &&
        c.month!.month == day.month,
  );
  if (selectedMonthIndex == -1) return updatedList;

  final current = updatedList[selectedMonthIndex];
  final effectiveCycle = effectiveCycleDuration(
    cycleDuration,
    current.cycleDuration,
  );
  final effectiveMens = effectiveMensDuration(
    menstruationDuration,
    current.menstruationDuration,
  );
  final effectiveStart = normalizeDate(day);

  final fullMens = buildMenstruationDays(effectiveStart, effectiveMens);

  // 1) Set the current month's menstruation from the new start.
  updatedList[selectedMonthIndex] = MonthCycleStruct(
    month: current.month,
    menstruationDays: daysInMonth(fullMens, current.month!),
    ovulationDays: const [],
    menstruationDuration: effectiveMens,
    cycleDuration: effectiveCycle,
  );

  // 2) Spill menstruation into the next month if the run crosses the boundary.
  if (selectedMonthIndex + 1 < updatedList.length) {
    final next = updatedList[selectedMonthIndex + 1];
    final spilloverMens = daysInMonth(fullMens, next.month!);
    if (spilloverMens.isNotEmpty) {
      final mergedMens = {
        ...next.menstruationDays.map(normalizeDate),
        ...spilloverMens,
      }.toList()
        ..sort();
      updatedList[selectedMonthIndex + 1] = MonthCycleStruct(
        month: next.month,
        menstruationDays: mergedMens,
        ovulationDays: const [],
        menstruationDuration: next.menstruationDuration > 0
            ? next.menstruationDuration
            : effectiveMens,
        cycleDuration:
            next.cycleDuration > 0 ? next.cycleDuration : effectiveCycle,
      );
    }
  }

  // 3) GLOBAL OVULATION REBUILD — rebuild every 7-day window from the real
  // menstruation starts across ALL months, so a window spanning a month
  // boundary is never truncated or overwritten.
  int cycleDurForStart(DateTime start) {
    for (final c in updatedList) {
      if (c.month != null &&
          c.month!.year == start.year &&
          c.month!.month == start.month &&
          c.cycleDuration > 0) {
        return c.cycleDuration;
      }
    }
    return effectiveCycle > 0 ? effectiveCycle : 28;
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
          : effectiveCycle,
    );
  }

  return updatedList;
}
