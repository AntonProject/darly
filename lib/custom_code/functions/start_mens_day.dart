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

DateTime startMensDay(
  List<MonthCycleStruct> monthCycle,
  DateTime currentMonth,
) {
  final selectedDay =
      DateTime(currentMonth.year, currentMonth.month, currentMonth.day);

  if (monthCycle.isEmpty) return selectedDay;

  // Resolve the cycle duration from the stored cycles (used to project the
  // menstruation start for days that fall outside the stored menstruation
  // runs, e.g. ovulation days).
  int cycleDuration = 28;
  for (final c in monthCycle) {
    if (c.cycleDuration >= 15) {
      cycleDuration = c.cycleDuration;
      break;
    }
  }

  final Set<DateTime> mensSet = {};
  for (final cycle in monthCycle) {
    for (final d in cycle.menstruationDays) {
      mensSet.add(DateTime(d.year, d.month, d.day));
    }
  }

  if (mensSet.isEmpty) return selectedDay;

  // If the selected day is itself a menstruation day, walk back to the start
  // of its contiguous run.
  if (mensSet.contains(selectedDay)) {
    DateTime d = selectedDay;
    while (mensSet.contains(d.subtract(const Duration(days: 1)))) {
      d = d.subtract(const Duration(days: 1));
    }
    return d;
  }

  // Otherwise ALWAYS return the menstruation start of the cycle that CONTAINS
  // the selected day (never an ovulation start, never the next cycle). This is
  // the most recent menstruation start on/before the day, projected by
  // cycleDuration when the day lies outside the stored runs.
  final cycleStarts = mensSet
      .where((d) => !mensSet.contains(d.subtract(const Duration(days: 1))))
      .toList()
    ..sort();
  if (cycleStarts.isEmpty) return selectedDay;

  DateTime cycleStart = cycleStarts.lastWhere(
    (d) => !d.isAfter(selectedDay),
    orElse: () => cycleStarts.first,
  );

  if (cycleStart.isAfter(selectedDay)) {
    while (cycleStart.isAfter(selectedDay)) {
      cycleStart = cycleStart.subtract(Duration(days: cycleDuration));
    }
  } else {
    while (true) {
      final next = cycleStart.add(Duration(days: cycleDuration));
      if (next.isAfter(selectedDay)) break;
      cycleStart = next;
    }
  }

  return cycleStart;
}
