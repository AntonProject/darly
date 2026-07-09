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

import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore direct access

Future<MessageLetterRecord> messageLetterQuery(
  String userId,
  List<String>? listShown,
) async {
  final shown = listShown ?? [];

  // Get all documents from messageLetter collection
  final allSnap =
      await FirebaseFirestore.instance.collection('messageLetter').get();

  final allDocs = allSnap.docs;
  final totalCount = allDocs.length;

  List<QueryDocumentSnapshot> pool;

  // If shown list length equals total docs count — reset and use full list
  if (shown.length >= totalCount) {
    pool = allDocs;

    // Clear messageShown list in user document
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'messageShown': []});
  } else {
    // Use only docs whose ID is not in shown list
    pool = allDocs.where((d) => !shown.contains(d.id)).toList();
  }

  // Pick random doc from pool
  pool.shuffle();
  final picked = pool.first;

  // Cast data to Map to safely access fields
  final pickedData = picked.data() as Map<String, dynamic>;

  // Write picked image, today's date and doc ID to user document
  await FirebaseFirestore.instance.collection('users').doc(userId).update({
    'messageLetterDayImage': pickedData['image'] ?? '',
    'messageLetterDay': pickedData['text'] ?? '',
    'messageLetterDate': Timestamp.fromDate(DateTime.now()),
    'messageShown': FieldValue.arrayUnion([picked.id]),
  });

  // Return as FlutterFlow MessageLetterRecord
  return MessageLetterRecord.fromSnapshot(picked);
}
