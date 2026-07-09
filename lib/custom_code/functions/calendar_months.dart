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

List<MonthCycleStruct> calendarMonths(
  List<MonthCycleStruct>? monthCycle,
  DateTime? startDate,
  int? cycleDuration,
  int? menstruationDuration,
) {
  DateTime normalizeDate(DateTime d) {
    return DateTime(d.year, d.month, d.day);
  }

  DateTime normalizeMonth(DateTime d) {
    return DateTime(d.year, d.month, 1);
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

  final existing = monthCycle != null
      ? List<MonthCycleStruct>.from(monthCycle)
      : <MonthCycleStruct>[];

  existing.sort(
    (a, b) => (a.month ?? DateTime(0)).compareTo(b.month ?? DateTime(0)),
  );

  final now = DateTime.now();
  final currentMonth = DateTime(now.year, now.month, 1);
  final targetLastMonth = DateTime(now.year, now.month + 1, 1);

  MonthCycleStruct? lastWithData() {
    for (int i = existing.length - 1; i >= 0; i--) {
      if (existing[i].menstruationDays.isNotEmpty) return existing[i];
    }
    return existing.isNotEmpty ? existing.last : null;
  }

  final ref = lastWithData();
  final existingMensDays = existing
      .expand((cycle) => cycle.menstruationDays)
      .map(normalizeDate)
      .toList();

  final effectiveCycle = effectiveCycleDuration(
    cycleDuration,
    ref?.cycleDuration,
  );
  final effectiveMens = effectiveMensDuration(
    menstruationDuration,
    ref?.menstruationDuration,
  );
  // Prefer start derived from existing monthCycles data over startDate param,
  // because startDate (firsDate) can be stale while monthCycles was already
  // correctly regenerated. Only use startDate when existing data is empty.
  DateTime? _deriveStartFromExisting() {
    if (existingMensDays.isEmpty) return null;
    final sorted = existingMensDays.toList()..sort();
    for (final d in sorted) {
      if (!sorted.contains(d.subtract(const Duration(days: 1)))) return d;
    }
    return sorted.first;
  }

  final existingStart = _deriveStartFromExisting();
  final effectiveStart =
      existingStart ?? (startDate != null ? normalizeDate(startDate) : null);

  final existingMonths = existing
      .where((c) => c.month != null)
      .map((c) => normalizeMonth(c.month!))
      .toSet()
      .toList()
    ..sort();

  bool hasMonth(DateTime monthValue) {
    return existingMonths.any(
      (m) => m.year == monthValue.year && m.month == monthValue.month,
    );
  }

  MonthCycleStruct buildMonth(DateTime monthValue) {
    if (effectiveStart == null) {
      return MonthCycleStruct(
        month: monthValue,
        menstruationDays: [],
        ovulationDays: [],
        menstruationDuration: effectiveMens,
        cycleDuration: effectiveCycle,
      );
    }

    final fullMens = <DateTime>[];
    final fullOvul = <DateTime>[];

    var cycleStart = effectiveStart;

    while (cycleStart.isAfter(monthValue)) {
      cycleStart = cycleStart.subtract(Duration(days: effectiveCycle));
    }

    final monthEnd = DateTime(monthValue.year, monthValue.month + 1, 1);
    final searchEnd =
        monthEnd.add(Duration(days: effectiveCycle + effectiveMens));
    while (cycleStart.isBefore(searchEnd)) {
      fullMens.addAll(buildMenstruationDays(cycleStart, effectiveMens));
      fullOvul.addAll(buildOvulationDays(cycleStart, effectiveCycle));
      cycleStart = cycleStart.add(Duration(days: effectiveCycle));
    }

    final ovulInMonth = daysInMonth(fullOvul, monthValue);
    final mensInMonth =
        removeCollisions(daysInMonth(fullMens, monthValue), ovulInMonth);

    return MonthCycleStruct(
      month: monthValue,
      menstruationDays: mensInMonth,
      ovulationDays: ovulInMonth,
      menstruationDuration: effectiveMens,
      cycleDuration: effectiveCycle,
    );
  }

  DateTime maxMonth(DateTime a, DateTime b) {
    return a.isAfter(b) ? a : b;
  }

  final rangeStartMonth = effectiveStart != null
      ? normalizeMonth(effectiveStart)
      : existingMonths.isNotEmpty
          ? existingMonths.first
          : currentMonth;

  var rangeEndMonth = targetLastMonth;
  if (existingMonths.isNotEmpty) {
    rangeEndMonth = maxMonth(rangeEndMonth, existingMonths.last);
  }
  rangeEndMonth = maxMonth(rangeEndMonth, rangeStartMonth);

  final generated = <MonthCycleStruct>[];
  var cursor = rangeStartMonth;
  while (!cursor.isAfter(rangeEndMonth)) {
    generated.add(buildMonth(cursor));
    cursor = DateTime(cursor.year, cursor.month + 1, 1);
  }

  bool existingContainsEffectiveStart() {
    if (effectiveStart == null) return true;
    return existingMensDays.any((d) => d.isAtSameMomentAs(effectiveStart));
  }

  bool existingDurationsMatch() {
    for (final cycle in existing) {
      if (cycle.month == null) continue;
      final monthValue = normalizeMonth(cycle.month!);
      if (monthValue.isBefore(rangeStartMonth) ||
          monthValue.isAfter(rangeEndMonth)) {
        continue;
      }
      if (cycle.cycleDuration > 0 && cycle.cycleDuration != effectiveCycle) {
        return false;
      }
      if (cycle.menstruationDuration > 0 &&
          cycle.menstruationDuration != effectiveMens) {
        return false;
      }
    }
    return true;
  }

  bool missingGeneratedMonth() {
    for (final generatedCycle in generated) {
      final monthValue = generatedCycle.month;
      if (monthValue == null || !hasMonth(monthValue)) return true;
    }
    return false;
  }

  final shouldRebuildExisting = existing.isEmpty ||
      !existingContainsEffectiveStart() ||
      !existingDurationsMatch();

  final result = shouldRebuildExisting
      ? generated
      : [
          ...existing,
          if (missingGeneratedMonth())
            ...generated.where((generatedCycle) {
              final monthValue = generatedCycle.month;
              return monthValue != null && !hasMonth(monthValue);
            }),
        ];

  result.sort(
    (a, b) => (a.month ?? DateTime(0)).compareTo(b.month ?? DateTime(0)),
  );
  return result;
}
