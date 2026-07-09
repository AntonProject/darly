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

int ovulationDayInDaysNumber(
  DateTime day,
  List<MonthCycleStruct> monthCycle,
) {
  final dayOnly = DateTime(day.year, day.month, day.day);

  final List<DateTime> allOvulationDays = [];

  for (final cycle in monthCycle) {
    for (final d in cycle.ovulationDays) {
      allOvulationDays.add(DateTime(d.year, d.month, d.day));
    }
  }

  if (allOvulationDays.isEmpty) {
    return 0;
  }

  allOvulationDays.sort();

  final List<DateTime> uniqueOvulationDays = [];
  for (final d in allOvulationDays) {
    if (uniqueOvulationDays.isEmpty ||
        !uniqueOvulationDays.last.isAtSameMomentAs(d)) {
      uniqueOvulationDays.add(d);
    }
  }

  final List<List<DateTime>> ovulationWindows = [];
  List<DateTime> currentWindow = [];

  for (final d in uniqueOvulationDays) {
    if (currentWindow.isEmpty) {
      currentWindow.add(d);
      continue;
    }

    final prev = currentWindow.last;
    if (d.difference(prev).inDays == 1) {
      currentWindow.add(d);
    } else {
      ovulationWindows.add(currentWindow);
      currentWindow = [d];
    }
  }

  if (currentWindow.isNotEmpty) {
    ovulationWindows.add(currentWindow);
  }

  for (final window in ovulationWindows) {
    for (int i = 0; i < window.length; i++) {
      final ovulationDay = window[i];
      if (ovulationDay.year == dayOnly.year &&
          ovulationDay.month == dayOnly.month &&
          ovulationDay.day == dayOnly.day) {
        return i + 1;
      }
    }
  }

  return 0;
}
