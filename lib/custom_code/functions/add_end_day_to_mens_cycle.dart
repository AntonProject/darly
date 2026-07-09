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

List<MonthCycleStruct> addEndDayToMensCycle(
  List<MonthCycleStruct> monthCycleList,
  DateTime day,
) {
  DateTime normalizeDate(DateTime d) {
    return DateTime(d.year, d.month, d.day);
  }

  if (monthCycleList.isEmpty) return monthCycleList;

  final updatedList = List<MonthCycleStruct>.from(monthCycleList);
  final normalizedDay = normalizeDate(day);

  final selectedMonthIndex = updatedList.indexWhere(
    (c) =>
        c.month != null &&
        c.month!.year == normalizedDay.year &&
        c.month!.month == normalizedDay.month,
  );
  if (selectedMonthIndex == -1) return updatedList;

  final current = updatedList[selectedMonthIndex];
  final existingDays = current.menstruationDays.map(normalizeDate).toList()
    ..sort();

  if (existingDays.isEmpty) return updatedList;

  final firstDay = existingDays.first;
  final newMensDays = <DateTime>[];
  var cursor = firstDay;

  while (!cursor.isAfter(normalizedDay)) {
    newMensDays.add(normalizeDate(cursor));
    cursor = cursor.add(const Duration(days: 1));
  }

  updatedList[selectedMonthIndex] = MonthCycleStruct(
    month: current.month,
    menstruationDays: newMensDays,
    ovulationDays: const [],
    menstruationDuration: newMensDays.length,
    cycleDuration: current.cycleDuration,
  );

  // GLOBAL OVULATION REBUILD — rebuild every 7-day window from the real
  // menstruation starts across ALL months, so a window spanning a month
  // boundary is never truncated or overwritten.
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

  int cycleDurForStart(DateTime start) {
    for (final c in updatedList) {
      if (c.month != null &&
          c.month!.year == start.year &&
          c.month!.month == start.month &&
          c.cycleDuration > 0) {
        return c.cycleDuration;
      }
    }
    return 28;
  }

  final Set<DateTime> allMensSet = {};
  for (final c in updatedList) {
    for (final d in c.menstruationDays) {
      allMensSet.add(normalizeDate(d));
    }
  }
  final cycleStarts = allMensSet
      .where((d) => !allMensSet.contains(d.subtract(const Duration(days: 1))))
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
      cycleDuration: updatedList[i].cycleDuration,
    );
  }

  return updatedList;
}
