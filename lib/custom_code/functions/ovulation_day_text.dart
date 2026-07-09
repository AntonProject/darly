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

String ovulationDayText(
  List<MonthCycleStruct>? monthCycle,
  DateTime selectedDate,
) {
  if (monthCycle == null || monthCycle.isEmpty) return 'Не указано';

  final today =
      DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

  final List<DateTime> allOvulDays = [];
  final Set<DateTime> mensSet = {};
  int cycleDuration = 28;

  for (final cycle in monthCycle) {
    for (final d in cycle.ovulationDays) {
      allOvulDays.add(DateTime(d.year, d.month, d.day));
    }
    for (final d in cycle.menstruationDays) {
      mensSet.add(DateTime(d.year, d.month, d.day));
    }
    if ((cycle.cycleDuration ?? 0) >= 15) {
      cycleDuration = cycle.cycleDuration!;
    }
  }

  // Находим старты циклов
  final sortedMens = mensSet.toList()..sort();
  final List<DateTime> cycleStarts = [];
  for (final d in sortedMens) {
    if (!mensSet.contains(d.subtract(const Duration(days: 1)))) {
      cycleStarts.add(d);
    }
  }
  cycleStarts.sort();

  // Границы текущего цикла
  DateTime? cycleStart;
  DateTime? nextCycleStart;

  for (int i = cycleStarts.length - 1; i >= 0; i--) {
    if (!cycleStarts[i].isAfter(today)) {
      cycleStart = cycleStarts[i];
      if (i + 1 < cycleStarts.length) {
        nextCycleStart = cycleStarts[i + 1];
      }
      break;
    }
  }

  if (cycleStart == null && cycleStarts.isNotEmpty) {
    cycleStart = cycleStarts.first;
    while (cycleStart!.isAfter(today)) {
      cycleStart = cycleStart.subtract(Duration(days: cycleDuration));
    }
  }

  if (cycleStart == null) return 'Не указано';

  nextCycleStart ??= cycleStart.add(Duration(days: cycleDuration));

  // Овуляция внутри ЭТОГО цикла
  allOvulDays.sort();
  final cycleOvulDays = allOvulDays
      .where((d) => !d.isBefore(cycleStart!) && d.isBefore(nextCycleStart!))
      .toList();

  if (cycleOvulDays.isNotEmpty) {
    if (cycleOvulDays.contains(today)) return 'Идёт';

    final groupStart = cycleOvulDays.first;
    final groupEnd = cycleOvulDays.last;

    final startStr =
        '${groupStart.day}.${groupStart.month.toString().padLeft(2, '0')}';
    final endStr =
        '${groupEnd.day}.${groupEnd.month.toString().padLeft(2, '0')}';

    if (groupStart == groupEnd) return startStr;
    return '$startStr-$endStr';
  }

  // Нет данных — рассчитываем
  final ovulCenter = cycleStart.add(Duration(days: cycleDuration - 14 - 1));
  final groupStart = ovulCenter.subtract(const Duration(days: 4));
  final groupEnd = ovulCenter.add(const Duration(days: 2));

  final startStr =
      '${groupStart.day}.${groupStart.month.toString().padLeft(2, '0')}';
  final endStr = '${groupEnd.day}.${groupEnd.month.toString().padLeft(2, '0')}';

  if (groupStart == groupEnd) return startStr;
  return '$startStr-$endStr';
}
