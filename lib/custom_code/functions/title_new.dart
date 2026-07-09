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

String? titleNew(String? title) {
  // Return null if title is null or empty
  if (title == null || title.isEmpty) {
    return title;
  }

  // Check if ends with "ии" -> replace with "ия"
  if (title.endsWith('ии')) {
    return title.substring(0, title.length - 2) + 'ия';
  }

  // Check if ends with "и" -> replace with "я"
  if (title.endsWith('и')) {
    return title.substring(0, title.length - 1) + 'я';
  }

  // Check if ends with "ы" -> remove it
  if (title.endsWith('ы')) {
    return title.substring(0, title.length - 1);
  }

  // If no match, return as is
  return title;
}
