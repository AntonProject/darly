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

String? monthsText(DateTime date) {
  final month = date.month;

  switch (month) {
    case 1:
      return 'ЯНВАРЕ';
    case 2:
      return 'ФЕВРАЛЕ';
    case 3:
      return 'МАРТЕ';
    case 4:
      return 'АПРЕЛЕ';
    case 5:
      return 'МАЕ';
    case 6:
      return 'ИЮНЕ';
    case 7:
      return 'ИЮЛЕ';
    case 8:
      return 'АВГУСТЕ';
    case 9:
      return 'СЕНТЯБРЕ';
    case 10:
      return 'ОКТЯБРЕ';
    case 11:
      return 'НОЯБРЕ';
    case 12:
      return 'ДЕКАБРЕ';
    default:
      return '';
  }
}
