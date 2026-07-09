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

bool currentMonthInCalendarExist(List<MonthCycleStruct> monthCycleList) {
  // Получаем текущую дату
  DateTime now = DateTime.now();
  // Создаем DateTime для первого дня текущего месяца
  DateTime currentMonthStart = DateTime(now.year, now.month, 1);
  // Проверяем, существует ли цикл для текущего месяца и есть ли в нем дни менструации
  bool exists = monthCycleList.any((cycle) {
    // Проверяем, что месяц цикла не null и совпадает с текущим месяцем
    bool isCurrentMonth = cycle.month != null &&
        cycle.month!.year == currentMonthStart.year &&
        cycle.month!.month == currentMonthStart.month;

    // Проверяем, что в цикле есть дни менструации
    bool hasMenstruationDays =
        cycle.menstruationDays != null && cycle.menstruationDays!.isNotEmpty;

    // Возвращаем true, только если это текущий месяц и в нем есть дни менструации
    return isCurrentMonth && hasMenstruationDays;
  });
  return exists;
}
