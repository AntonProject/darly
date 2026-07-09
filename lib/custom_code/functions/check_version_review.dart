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

bool checkVersionReview(
  String appVersion,
  String reviewVersion,
) {
  // Функция для извлечения версии и номера билда из строки
  Map<String, dynamic> extractVersionInfo(String versionString) {
    // Регулярное выражение для выделения версии и номера билда
    RegExp regex = RegExp(r'(\d+\.\d+\.\d+)[^\d]*\((\d+)\)');
    Match? match = regex.firstMatch(versionString);

    if (match != null && match.groupCount >= 2) {
      String version = match.group(1) ?? "0.0.0";
      int buildNumber = int.tryParse(match.group(2) ?? "0") ?? 0;

      // Разбиваем версию на числовые компоненты
      List<int> versionParts =
          version.split('.').map((part) => int.tryParse(part) ?? 0).toList();

      return {'versionParts': versionParts, 'buildNumber': buildNumber};
    }

    // Если формат не соответствует ожидаемому, возвращаем нулевую версию
    return {
      'versionParts': [0, 0, 0],
      'buildNumber': 0
    };
  }

  // Извлекаем информацию о версиях
  var appInfo = extractVersionInfo(appVersion);
  var reviewInfo = extractVersionInfo(reviewVersion);

  List<int> appVersionParts = appInfo['versionParts'];
  int appBuildNumber = appInfo['buildNumber'];

  List<int> reviewVersionParts = reviewInfo['versionParts'];
  int reviewBuildNumber = reviewInfo['buildNumber'];

  // Проверяем равенство всех компонентов версии (major.minor.patch)
  for (int i = 0; i < 3; i++) {
    if (appVersionParts[i] != reviewVersionParts[i]) {
      return false; // Если любой компонент отличается, возвращаем false
    }
  }

  // Если все компоненты версии одинаковые, проверяем равенство номеров билдов
  return appBuildNumber == reviewBuildNumber;
}
