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

bool dayGreatherThanToday(DateTime? day) {
// Return false if day is null
  if (day == null) {
    return false;
  }

  // Get current date without time (only date part)
  DateTime now = DateTime.now();
  DateTime currentDay = DateTime(now.year, now.month, now.day);

  // Get the input day without time (only date part)
  DateTime inputDay = DateTime(day.year, day.month, day.day);

  // Return true if input day is after current day
  return inputDay.isAfter(currentDay);
}
