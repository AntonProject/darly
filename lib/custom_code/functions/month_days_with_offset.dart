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

List<DateTime> monthDaysWithOffset(DateTime? month) {
  final target = month ?? DateTime.now();
  final firstDay = DateTime(target.year, target.month, 1);
  final lastDay = DateTime(target.year, target.month + 1, 0).day;

  // Offset from Monday (0=Mon, 6=Sun)
  final offset = firstDay.weekday - 1;

  final List<DateTime> days = [];

  // Add days from previous month as offset
  for (int i = offset; i > 0; i--) {
    days.add(firstDay.subtract(Duration(days: i)));
  }

  // Add days of current month
  for (int i = 1; i <= lastDay; i++) {
    days.add(DateTime(target.year, target.month, i));
  }

  return days;
}
