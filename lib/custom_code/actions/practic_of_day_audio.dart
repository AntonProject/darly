// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<AudioRecord> practicOfDayAudio() async {
  // Fetch all visible audio documents from Firestore
  final snapshot = await FirebaseFirestore.instance
      .collection('audio')
      .where('hide', isEqualTo: false)
      .get();

  // Filter out documents where category is 'Подкасты' or 'Подкаст'
  final filtered = snapshot.docs.where((doc) {
    final data = doc.data();
    final category = data['category'] as String?;
    return category != 'Подкасты' && category != 'Подкаст';
  }).toList();

  // Return a random document from the filtered list
  final random = filtered[Random().nextInt(filtered.length)];
  return AudioRecord.fromSnapshot(random);
}
