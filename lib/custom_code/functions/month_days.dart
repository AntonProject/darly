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

List<DateTime> monthDays(List<MonthCycleStruct>? cycles) {
  DateTime normalizeMonth(DateTime d) {
    return DateTime(d.year, d.month, 1);
  }

  List<DateTime> daysForMonth(DateTime month) {
    final lastDay = DateTime(month.year, month.month + 1, 0).day;
    return List.generate(
      lastDay,
      (i) => DateTime(month.year, month.month, i + 1),
    );
  }

  final now = DateTime.now();
  final currentMonth = DateTime(now.year, now.month, 1);
  final targetLastMonth = DateTime(now.year, now.month + 1, 1);

  final cycleMonths = (cycles ?? [])
      .where((c) => c.month != null)
      .map((c) => normalizeMonth(c.month!))
      .toSet()
      .toList()
    ..sort();

  final monthsToShow = <DateTime>[];

  if (cycleMonths.isEmpty) {
    monthsToShow.add(currentMonth);
    monthsToShow.add(targetLastMonth);
  } else {
    monthsToShow.addAll(cycleMonths);

    var lastMonth = monthsToShow.last;
    while (lastMonth.isBefore(targetLastMonth)) {
      final nextMonth = DateTime(lastMonth.year, lastMonth.month + 1, 1);
      if (!monthsToShow.contains(nextMonth)) {
        monthsToShow.add(nextMonth);
      }
      lastMonth = nextMonth;
    }
  }

  final result = <DateTime>[];
  for (final month in monthsToShow) {
    result.addAll(daysForMonth(month));
  }

  return result;
}
