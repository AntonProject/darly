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

List<AudioRecord>? audioList(List<AudioRecord>? list) {
  if (list == null || list.isEmpty) return list;

  // Check if all tracks have index field filled
  final allHaveIndex = list.every((track) => track.hasIndex());

  if (allHaveIndex) {
    // Create list with original positions to preserve order for same indices
    final indexedList = list.asMap().entries.toList();

    // Sort by document index, preserving original order for tracks with same index
    indexedList.sort((a, b) {
      final indexA = a.value.index;
      final indexB = b.value.index;

      // First compare by index
      if (indexA != indexB) {
        return indexA.compareTo(indexB);
      }

      // If indices are equal, preserve original order (stable sort)
      return a.key.compareTo(b.key);
    });

    // Return sorted list of AudioRecord
    return indexedList.map((entry) => entry.value).toList();
  }

  // If not all tracks have index, return original list
  return list;
}
