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

String nameLettters(
  String? name,
  String? surname,
) {
  // Trim and check if values exist
  String? trimmedName = name?.trim();
  String? trimmedSurname = surname?.trim();

  bool hasName = trimmedName != null && trimmedName.isNotEmpty;
  bool hasSurname = trimmedSurname != null && trimmedSurname.isNotEmpty;

  // If both name and surname exist
  if (hasName && hasSurname) {
    String nameInitial = trimmedName![0].toUpperCase();
    String surnameInitial = trimmedSurname![0].toUpperCase();
    return '$nameInitial$surnameInitial';
  }

  // If only name exists, check if it has multiple words
  if (hasName) {
    List<String> nameParts =
        trimmedName!.split(' ').where((part) => part.isNotEmpty).toList();

    if (nameParts.length >= 2) {
      // Name has 2+ words: take first letter of first two words
      String firstInitial = nameParts[0][0].toUpperCase();
      String secondInitial = nameParts[1][0].toUpperCase();
      return '$firstInitial$secondInitial';
    } else {
      // Single word name: repeat first two letters or first letter twice
      if (trimmedName.length >= 2) {
        return trimmedName.substring(0, 2).toUpperCase();
      } else {
        // Single letter name
        String letter = trimmedName[0].toUpperCase();
        return '$letter$letter';
      }
    }
  }

  // If only surname exists
  if (hasSurname) {
    // Take first two letters of surname or repeat first letter
    if (trimmedSurname!.length >= 2) {
      return trimmedSurname.substring(0, 2).toUpperCase();
    } else {
      String letter = trimmedSurname[0].toUpperCase();
      return '$letter$letter';
    }
  }

  // Default: if both are empty
  return 'WN';
}
