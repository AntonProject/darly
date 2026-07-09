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

String? periodFormat(int period) {
  // Handle special case for year
  if (period == 12) {
    return 'год';
  }

  // Handle special case for 1 month
  if (period == 1) {
    return 'месяц';
  }

  // For other months, determine the correct form based on the number
  int lastDigit = period % 10;
  int lastTwoDigits = period % 100;

  // Handle exceptions for 11-14 (they use "месяцев")
  if (lastTwoDigits >= 11 && lastTwoDigits <= 14) {
    return '$period месяцев';
  }

  // Determine the form based on the last digit
  if (lastDigit == 1) {
    return '$period месяц';
  } else if (lastDigit >= 2 && lastDigit <= 4) {
    return '$period месяца';
  } else {
    return '$period месяцев';
  }
}
