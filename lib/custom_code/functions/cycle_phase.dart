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

String? cyclePhase(
  List<MonthCycleStruct>? monthCycle,
  DateTime? day,
) {
  if (monthCycle == null || monthCycle.isEmpty) return 'Лютеиновая';

  final target = day ?? DateTime.now();
  final dayOnly = DateTime(target.year, target.month, target.day);

  // DATE-BASED phases (per ТЗ "ЦИКЛ ПРОГНОЗ", Flo logic). Phases are computed
  // from the menstruation start and the cycle length — NOT from the stored
  // ovulation dots. The 7-day fertile window is only a visual overlay and may
  // overlap the luteal phase, so it must NOT drive the phase.
  //
  //   peak (ovulation day) = cycleStart + (cycleLength - 15) = nextPeriod - 15
  //   Menstruation : the stored menstruation days
  //   Follicular   : after menstruation .. peak - 1
  //   Ovulation    : exactly the peak day (1 day)
  //   Luteal       : peak + 1 .. next period - 1   (14 days by default)
  final List<DateTime> allMens = [];
  for (final c in monthCycle) {
    for (final d in c.menstruationDays) {
      allMens.add(DateTime(d.year, d.month, d.day));
    }
  }
  allMens.sort();
  if (allMens.isEmpty) return 'Лютеиновая';

  // 1. Explicit menstruation day — highest priority.
  if (allMens.any((d) => d.isAtSameMomentAs(dayOnly))) {
    return 'Менструация';
  }

  final mensSet = allMens.toSet();

  // Cycle starts = first day of each contiguous menstruation run.
  final cycleStarts = allMens
      .where((d) => !mensSet.contains(d.subtract(const Duration(days: 1))))
      .toList()
    ..sort();
  if (cycleStarts.isEmpty) return 'Лютеиновая';

  // Resolve the cycle duration for a given start (from its month entry).
  int cycleDurForStart(DateTime start) {
    for (final c in monthCycle) {
      if (c.month != null &&
          c.month!.year == start.year &&
          c.month!.month == start.month &&
          c.cycleDuration > 0) {
        return c.cycleDuration;
      }
    }
    for (final c in monthCycle) {
      if (c.cycleDuration > 0) return c.cycleDuration;
    }
    return 28;
  }

  // The cycle that CONTAINS the day = most recent start on/before it.
  DateTime? prevStart;
  for (final s in cycleStarts) {
    if (!s.isAfter(dayOnly)) {
      if (prevStart == null || s.isAfter(prevStart)) prevStart = s;
    }
  }

  // Before the very first tracked cycle → luteal tail of an untracked cycle.
  if (prevStart == null) {
    return 'Лютеиновая';
  }

  final int cycleLength = cycleDurForStart(prevStart);
  final DateTime peak = prevStart.add(Duration(days: cycleLength - 15));

  if (dayOnly.isAtSameMomentAs(peak)) {
    return 'Овуляция';
  }
  if (dayOnly.isAfter(peak)) {
    return 'Лютеиновая';
  }
  return 'Фолликулярная';
}
