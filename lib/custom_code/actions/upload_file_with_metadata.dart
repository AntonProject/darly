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

import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<FileDTStruct> uploadFileWithMetadata() async {
  try {
    // Pick file using file_picker with document restrictions
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'xls', 'xlsx'],
      withData: true,
    );

    if (result == null || result.files.isEmpty) {
      throw Exception('No file selected');
    }

    final file = result.files.first;
    if (file.bytes == null) {
      throw Exception('File is empty');
    }

    // Get current user ID
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw Exception('User not authenticated');
    }

    // Use original file name from file_picker
    String originalFileName = file.name;

    // Create storage path with timestamp to avoid conflicts
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String storagePath = 'users/${currentUser.uid}/uploads/$timestamp';

    // Create reference in Firebase Storage
    final storageRef = FirebaseStorage.instance.ref().child(storagePath);

    // Prepare metadata
    final metadata = SettableMetadata(
      contentType: _getContentType(originalFileName),
      customMetadata: {
        'originalFileName': originalFileName,
      },
    );

    // Upload file with metadata
    final uploadTask = await storageRef.putData(
      file.bytes!,
      metadata,
    );

    // Get download URL
    final downloadURL = await uploadTask.ref.getDownloadURL();

    // Get file size in MB
    double sizeMB = file.bytes!.length / (1024 * 1024);

    // Get file extension and format it with capital letter
    String extension = originalFileName.contains('.')
        ? originalFileName.split('.').last.toLowerCase()
        : 'unknown';

    // Format extension with capital letter
    String formattedType = _formatFileType(extension);

    // Get current timestamp
    DateTime updatedTime = DateTime.now();

    // Create and return FileDTStruct
    return FileDTStruct(
      name: originalFileName,
      sizeMB: double.parse(sizeMB.toStringAsFixed(1)),
      type: formattedType,
      path: downloadURL,
      updated: updatedTime,
    );
  } catch (e) {
    print('Error uploading file: $e');
    // Return default struct in case of error
    return FileDTStruct(
      name: 'unknown',
      sizeMB: 0.0,
      type: 'unknown',
      path: '',
      updated: DateTime.now(),
    );
  }
}

// Helper function to determine content type
String _getContentType(String fileName) {
  String extension = fileName.split('.').last.toLowerCase();

  switch (extension) {
    case 'pdf':
      return 'application/pdf';
    case 'xlsx':
      return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
    case 'xls':
      return 'application/vnd.ms-excel';
    case 'doc':
      return 'application/msword';
    case 'docx':
      return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
    case 'jpg':
    case 'jpeg':
      return 'image/jpeg';
    case 'png':
      return 'image/png';
    case 'gif':
      return 'image/gif';
    case 'txt':
      return 'text/plain';
    case 'zip':
      return 'application/zip';
    case 'rar':
      return 'application/x-rar-compressed';
    default:
      return 'application/octet-stream';
  }
}

// Helper function to format file type with capital letter
String _formatFileType(String extension) {
  switch (extension.toLowerCase()) {
    case 'pdf':
      return 'PDF';
    case 'doc':
    case 'docx':
      return 'DOC';
    case 'xls':
    case 'xlsx':
      return 'XLS';
    case 'jpg':
    case 'jpeg':
      return 'JPG';
    case 'png':
      return 'PNG';
    case 'gif':
      return 'GIF';
    case 'txt':
      return 'TXT';
    case 'zip':
      return 'ZIP';
    case 'rar':
      return 'RAR';
    default:
      return extension.toUpperCase();
  }
}
