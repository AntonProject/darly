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

bool search(
  String? text,
  String? searchText,
  String? searchText2,
) {
  // If text is null or empty, return false
  if (text == null || text.trim().isEmpty) {
    return false;
  }

  // If both search fields are empty, return true (show all)
  if ((searchText == null || searchText.trim().isEmpty) &&
      (searchText2 == null || searchText2.trim().isEmpty)) {
    return true;
  }

  String normalizedText = text.toLowerCase().trim();
  String normalizedSearch = searchText?.toLowerCase().trim() ?? '';
  String normalizedSearch2 = searchText2?.toLowerCase().trim() ?? '';

  // Check if text contains either search field (OR logic)
  return normalizedText.contains(normalizedSearch) ||
      normalizedText.contains(normalizedSearch2);
}
