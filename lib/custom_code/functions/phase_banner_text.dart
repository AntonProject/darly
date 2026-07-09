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

String phaseBannerText(String? phase) {
  switch (phase) {
    case 'Менструация':
      return 'Сегодня ты можешь чувствовать меньше энергии и потребность в отдыхе. Узнай больше из нашего обзора.';
    case 'Фолликулярная':
      return 'Сегодня может быть легче собраться и сосредоточиться. Узнай больше из нашего обзора.';
    case 'Овуляция':
      return 'Сегодня ты можешь чувствовать подъем энергии и уверенности. Узнай больше из нашего обзора.';
    case 'Лютеиновая':
      return 'Сегодня ты можешь быть более чувствительной. Узнай больше из нашего обзора.';
    default:
      return 'Узнай больше из нашего обзора.';
  }
}
