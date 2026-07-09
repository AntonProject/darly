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

String urlToVideoPath(String url) {
  if (url.isEmpty) return '';

  Uri uri = Uri.parse(url);

  // Handle youtube.com URLs
  if (uri.host.contains('youtube.com')) {
    String? videoId = uri.queryParameters['v'];
    return videoId ?? url;
  }

  // Handle youtu.be URLs
  if (uri.host.contains('youtu.be')) {
    String path = uri.path;
    if (path.startsWith('/')) {
      path = path.substring(1);
    }
    int queryIndex = path.indexOf('?');
    if (queryIndex != -1) {
      path = path.substring(0, queryIndex);
    }
    return path;
  }

  // Return original URL if not YouTube
  return url;
}
