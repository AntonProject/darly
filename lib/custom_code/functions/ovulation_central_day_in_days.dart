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

bool ovulationCentralDayInDays(
  DateTime day,
  List<MonthCycleStruct> monthCycle,
) {
  final dayOnly = DateTime(day.year, day.month, day.day);

  // Collect ALL menstruation start dates across all months.
  // A "cycle start" is the first day of a contiguous menstruation run.
  // Using all months allows correct handling when ovulation window is split
  // across month boundaries (saved partially in two months).
  final List<DateTime> allMensDays = [];
  for (final cycle in monthCycle) {
    for (final d in cycle.menstruationDays) {
      allMensDays.add(DateTime(d.year, d.month, d.day));
    }
  }
  allMensDays.sort();

  // Identify cycle start days = first day of each contiguous menstruation run.
  // Any mens day without a previous day immediately before it is a cycle start.
  final Set<DateTime> mensSet = allMensDays.toSet();
  final List<DateTime> cycleStarts = [];
  for (final d in allMensDays) {
    final prev = DateTime(d.year, d.month, d.day - 1);
    if (!mensSet.contains(prev)) {
      cycleStarts.add(d);
    }
  }

  // The 7-day ovulation window is built as [-4..+2] around the medical
  // ovulation day (cycleStart + cycleDuration - 15), i.e. the peak sits in the
  // MIDDLE as the 5th of 7 days (4 before + peak + 2 after). The "central"
  // marker (цветочек) is exactly that peak day:
  //   centralMarker = cycleStart + (cycleDuration - 15)
  // 28-day cycle → window days 10..16 → marker on day 14 (5th of 7)
  for (final start in cycleStarts) {
    // Find the cycleDuration associated with this start (from the month it belongs to)
    int cycleDur = 28; // fallback
    for (final cycle in monthCycle) {
      if (cycle.month != null &&
          cycle.month!.year == start.year &&
          cycle.month!.month == start.month &&
          cycle.cycleDuration > 0) {
        cycleDur = cycle.cycleDuration;
        break;
      }
    }

    final int offset = (cycleDur - 14) - 1;
    final central = start.add(Duration(days: offset));
    if (central.year == dayOnly.year &&
        central.month == dayOnly.month &&
        central.day == dayOnly.day) {
      return true;
    }
  }

  // Fallback for cases where menstruation data is missing but ovulation is predicted.
  // Standard fertile window is 7 days with the central ovulation day = 5th of 7
  // (4 days before + central + 2 days after). This fallback tries to recover
  // the central day when the window is fully stored in one cycle entry.
  if (cycleStarts.isEmpty) {
    for (final cycle in monthCycle) {
      if (cycle.ovulationDays.isEmpty) continue;
      final ovul = cycle.ovulationDays
          .map((d) => DateTime(d.year, d.month, d.day))
          .toList()
        ..sort();

      // Only trust this fallback for a single contiguous run (no gaps).
      // A gap > 1 day means there are probably multiple cycles in this entry.
      bool contiguous = true;
      for (int i = 1; i < ovul.length; i++) {
        if (ovul[i].difference(ovul[i - 1]).inDays != 1) {
          contiguous = false;
          break;
        }
      }
      if (!contiguous) continue;

      // If the full 7-day window is present — pick the 5th element (index 4).
      // For smaller fragments (e.g. window cropped by month boundary) we can
      // only guess, so skip to avoid false positives.
      if (ovul.length == 7) {
        final central = ovul[4]; // 5th of 7
        if (central.isAtSameMomentAs(dayOnly)) return true;
      }
    }
  }

  return false;
}
