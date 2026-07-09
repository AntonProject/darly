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

String? nameHome(
  String? name,
  String? surname,
) {
  bool hasName = name != null && name.trim().isNotEmpty;
  bool hasSurname = surname != null && surname.trim().isNotEmpty;

  if (!hasName && !hasSurname) return "МИЛАЯ";

  String capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + (text.length > 1 ? text.substring(1) : '');
  }

  if (hasName && hasSurname) {
    String surnameInitial = surname!.trim()[0].toUpperCase();
    String nameCapitalized = capitalizeFirst(name!.trim());
    return '$nameCapitalized $surnameInitial.'.toUpperCase();
  }

  if (hasName) return capitalizeFirst(name!.trim()).toUpperCase();
  if (hasSurname) return capitalizeFirst(surname!.trim()).toUpperCase();

  return "МИЛАЯ";
}
