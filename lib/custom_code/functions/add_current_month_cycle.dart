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

List<MonthCycleStruct> addCurrentMonthCycle(
  DateTime firstDay,
  int cycleDuration,
  int mensDuration,
) {
  DateTime normalizeDate(DateTime d) {
    return DateTime(d.year, d.month, d.day);
  }

  int effectiveCycleDuration(int value) {
    return value > 0 ? value : 28;
  }

  int effectiveMensDuration(int value) {
    return value > 0 ? value : 5;
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

  final normalizedFirstDay = normalizeDate(firstDay);
  final effectiveCycle = effectiveCycleDuration(cycleDuration);
  final effectiveMens = effectiveMensDuration(mensDuration);

  final now = DateTime.now();
  final startMonth = DateTime(
    normalizedFirstDay.year,
    normalizedFirstDay.month,
    1,
  );
  final endMonth = DateTime(now.year, 12, 1);

  MonthCycleStruct generateMonthCycle(DateTime monthStart) {
    final menstruationDays = <DateTime>[];
    final ovulationDays = <DateTime>[];

    var cycleStart = normalizedFirstDay;

    while (cycleStart.isAfter(monthStart)) {
      cycleStart = cycleStart.subtract(Duration(days: effectiveCycle));
    }

    final endSearch = DateTime(monthStart.year, monthStart.month + 1, 1)
        .add(Duration(days: effectiveCycle));

    while (cycleStart.isBefore(endSearch)) {
      for (int i = 0; i < effectiveMens; i++) {
        final mensDay = normalizeDate(cycleStart.add(Duration(days: i)));
        if (mensDay.year == monthStart.year &&
            mensDay.month == monthStart.month) {
          menstruationDays.add(mensDay);
        }
      }

      final ovulationOffset = (effectiveCycle - 14) - 1;
      for (int i = -4; i <= 2; i++) {
        final ovulationDay = normalizeDate(
          cycleStart.add(Duration(days: ovulationOffset + i)),
        );
        if (ovulationDay.year == monthStart.year &&
            ovulationDay.month == monthStart.month) {
          ovulationDays.add(ovulationDay);
        }
      }

      cycleStart = cycleStart.add(Duration(days: effectiveCycle));
    }

    final sortedOvulationDays = ovulationDays.toSet().toList()..sort();
    final cleanedMens = removeCollisions(
      menstruationDays,
      sortedOvulationDays,
    );

    return MonthCycleStruct(
      month: monthStart,
      menstruationDays: cleanedMens,
      ovulationDays: sortedOvulationDays,
      menstruationDuration: effectiveMens,
      cycleDuration: effectiveCycle,
    );
  }

  final monthCycleList = <MonthCycleStruct>[];
  var currentMonth = startMonth;

  while (!currentMonth.isAfter(endMonth)) {
    monthCycleList.add(generateMonthCycle(currentMonth));
    currentMonth = DateTime(currentMonth.year, currentMonth.month + 1, 1);
  }

  return monthCycleList;
}
