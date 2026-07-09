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

int cycleDay(
  DateTime day,
  List<MonthCycleStruct> monthCycle,
) {
  final dayOnly = DateTime(day.year, day.month, day.day);
  if (monthCycle.isEmpty) return 0;

  final Set<DateTime> mensSet = {};
  int cycleDuration = 28;
  for (final cycle in monthCycle) {
    for (final d in cycle.menstruationDays) {
      mensSet.add(DateTime(d.year, d.month, d.day));
    }
    if ((cycle.cycleDuration ?? 0) >= 15) {
      cycleDuration = cycle.cycleDuration!;
    }
  }
  if (mensSet.isEmpty) return 0;

  // Находим все реальные старты менструации (первый день каждого подряд-блока)
  final sortedMens = mensSet.toList()..sort();
  final List<DateTime> cycleStarts = [];
  for (final d in sortedMens) {
    final prev = d.subtract(const Duration(days: 1));
    if (!mensSet.contains(prev)) {
      cycleStarts.add(d);
    }
  }
  cycleStarts.sort();
  if (cycleStarts.isEmpty) return 0;

  // Ищем последний старт цикла <= выбранного дня
  DateTime? cycleStart;
  for (int i = cycleStarts.length - 1; i >= 0; i--) {
    if (!cycleStarts[i].isAfter(dayOnly)) {
      cycleStart = cycleStarts[i];
      break;
    }
  }

  // День раньше первого известного цикла — экстраполируем назад
  if (cycleStart == null) {
    cycleStart = cycleStarts.first;
    while (cycleStart!.isAfter(dayOnly)) {
      cycleStart = cycleStart.subtract(Duration(days: cycleDuration));
    }
  }

  return dayOnly.difference(cycleStart).inDays + 1;
}
