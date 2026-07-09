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

import 'index.dart'; // Imports other custom actions

import 'package:firebase_storage/firebase_storage.dart';

Future<FileDTStruct> getFileMetadataFromStorage(String storageUrl) async {
  try {
    if (storageUrl.isEmpty) {
      throw Exception('Storage URL is empty');
    }

    // Create reference from URL
    final storageRef = FirebaseStorage.instance.refFromURL(storageUrl);

    // Get metadata from storage
    final metadata = await storageRef.getMetadata();

    // Extract file name from metadata or URL
    String fileName = metadata.name;

    // Try to get original file name from custom metadata if available
    if (metadata.customMetadata != null &&
        metadata.customMetadata!.containsKey('originalFileName')) {
      fileName = metadata.customMetadata!['originalFileName'] ?? fileName;
    }

    // Get file size in bytes and convert to MB
    int sizeBytes = metadata.size ?? 0;
    double sizeMB = sizeBytes / (1024 * 1024);

    // Get content type and extract file extension/type
    String contentType = metadata.contentType ?? 'application/octet-stream';
    String fileType = _getFileTypeFromContentType(contentType, fileName);

    // Get updated time
    DateTime? updatedTime = metadata.updated;

    // Create and return FileDTStruct
    return FileDTStruct(
      name: fileName,
      sizeMB: double.parse(sizeMB.toStringAsFixed(1)),
      type: fileType,
      path: storageUrl,
      updated: updatedTime ?? DateTime.now(),
    );
  } catch (e) {
    print('Error getting file metadata from storage: $e');
    // Return default struct in case of error
    return FileDTStruct(
      name: 'unknown',
      sizeMB: 0.0,
      type: 'unknown',
      path: storageUrl,
      updated: DateTime.now(),
    );
  }
}

// Helper function to get file type from content type or file extension
String _getFileTypeFromContentType(String contentType, String fileName) {
  // First try to get from content type
  if (contentType.contains('pdf')) {
    return 'PDF';
  } else if (contentType.contains('msword') ||
      contentType.contains('wordprocessingml')) {
    return 'DOC';
  } else if (contentType.contains('spreadsheetml') ||
      contentType.contains('ms-excel')) {
    return 'XLS';
  } else if (contentType.contains('jpeg') || contentType.contains('jpg')) {
    return 'JPG';
  } else if (contentType.contains('png')) {
    return 'PNG';
  } else if (contentType.contains('gif')) {
    return 'GIF';
  } else if (contentType.contains('plain')) {
    return 'TXT';
  } else if (contentType.contains('zip')) {
    return 'ZIP';
  } else if (contentType.contains('rar')) {
    return 'RAR';
  } else if (contentType.contains('mpeg') || contentType.contains('mp3')) {
    return 'MP3';
  } else if (contentType.contains('mp4') || contentType.contains('m4a')) {
    return 'M4A';
  } else if (contentType.contains('wav')) {
    return 'WAV';
  } else if (contentType.contains('ogg')) {
    return 'OGG';
  } else if (contentType.contains('flac')) {
    return 'FLAC';
  }

  // If content type doesn't match, try to get from file extension
  if (fileName.contains('.')) {
    String extension = fileName.split('.').last.toLowerCase();
    return _formatFileType(extension);
  }

  return 'UNKNOWN';
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
    case 'mp3':
      return 'MP3';
    case 'm4a':
      return 'M4A';
    case 'wav':
      return 'WAV';
    case 'ogg':
      return 'OGG';
    case 'flac':
      return 'FLAC';
    default:
      return extension.toUpperCase();
  }
}
