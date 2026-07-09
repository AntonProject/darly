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

String mensDayText(
  List<MonthCycleStruct>? monthCycle,
  DateTime selectedDate,
) {
  if (monthCycle == null || monthCycle.isEmpty) return 'Не указано';

  final today =
      DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

  final List<DateTime> allMensDays = [];
  for (final cycle in monthCycle) {
    for (final d in cycle.menstruationDays) {
      allMensDays.add(DateTime(d.year, d.month, d.day));
    }
  }

  if (allMensDays.isEmpty) return 'Не указано';

  if (allMensDays.contains(today)) return 'Идут';

  allMensDays.sort();

  final upcoming = allMensDays.where((d) => d.isAfter(today)).toList();
  if (upcoming.isEmpty) return 'Не указано';

  DateTime? nextStart;
  for (int i = 0; i < upcoming.length; i++) {
    final d = upcoming[i];
    final prev = d.subtract(const Duration(days: 1));
    if (!allMensDays.contains(prev)) {
      nextStart = d;
      break;
    }
  }

  if (nextStart == null) return 'Не указано';

  final diff = nextStart.difference(today).inDays;
  if (diff == 0) return 'Идут';
  return 'через $diff д.';
}
