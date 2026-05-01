// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<AudioRecord> audioRef(String audioId) async {
  try {
    if (audioId.isEmpty) {
      throw Exception('Audio ID is empty');
    }

    // Get document reference from collection by ID
    final docRef = AudioRecord.collection.doc(audioId);

    // Get document once
    final audioRecord = await AudioRecord.getDocumentOnce(docRef);

    return audioRecord;
  } catch (e) {
    print('Error getting audio document by ID: $e');
    rethrow;
  }
}
