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

String dateTextNow() {
  // Get current hour
  final int currentHour = DateTime.now().hour;

  // Return greeting with emoji based on time of day
  // Morning: 6:00 - 11:59 ☀️
  // Day: 12:00 - 17:59 🌤️
  // Evening: 18:00 - 22:59 🌙
  // Night: 23:00 - 5:59 🌃

  if (currentHour >= 6 && currentHour < 12) {
    return 'ДОБРОЕ УТРО! ☀️';
  } else if (currentHour >= 12 && currentHour < 18) {
    return 'ДОБРЫЙ ДЕНЬ! 🌤️';
  } else if (currentHour >= 18 && currentHour < 23) {
    return 'ДОБРЫЙ ВЕЧЕР! 🌙';
  } else {
    return 'ДОБРОЙ НОЧИ! 🌃';
  }
}
