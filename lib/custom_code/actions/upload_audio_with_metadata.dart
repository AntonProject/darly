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

import 'index.dart'; // Imports other custom actions

import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<AudioFileStruct> uploadAudioWithMetadata() async {
  AudioPlayer? player;
  File? tempFile;

  try {
    // Pick audio file using file_picker
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'm4a', 'aac', 'wav', 'ogg', 'flac'],
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

    // Get file extension and format it
    String extension = originalFileName.contains('.')
        ? originalFileName.split('.').last.toLowerCase()
        : 'unknown';

    // Create temporary file to get audio metadata
    final tempDir = await getTemporaryDirectory();
    tempFile = File('${tempDir.path}/$originalFileName');
    await tempFile.writeAsBytes(file.bytes!);

    // Initialize audio player to get duration
    player = AudioPlayer();
    Duration? audioDuration;

    try {
      // Load audio file to get duration
      await player.setFilePath(tempFile.path);

      // Wait for duration to be available
      audioDuration = await player.durationStream
          .where((d) => d != null && d.inMilliseconds > 0)
          .cast<Duration>()
          .first
          .timeout(
            Duration(seconds: 10),
            onTimeout: () => Duration.zero,
          );

      // If duration is still null or zero, try getting it directly
      if (audioDuration == null || audioDuration.inMilliseconds == 0) {
        await Future.delayed(Duration(milliseconds: 500));
        audioDuration = player.duration;
      }

      // If still no duration, wait a bit more and try again
      if (audioDuration == null || audioDuration.inMilliseconds == 0) {
        await Future.delayed(Duration(milliseconds: 1000));
        audioDuration = player.duration ?? Duration.zero;
      }
    } catch (e) {
      print('Error getting audio duration: $e');
      audioDuration = Duration.zero;
    } finally {
      // Dispose player
      await player.dispose();
      player = null;
    }

    // Format duration as HH:mm:ss or MM:SS
    String formattedDuration = _formatDuration(audioDuration ?? Duration.zero);

    // Create storage path with timestamp to avoid conflicts
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String storagePath = 'users/${currentUser.uid}/audio/$timestamp';

    // Create reference in Firebase Storage
    final storageRef = FirebaseStorage.instance.ref().child(storagePath);

    // Prepare metadata
    final metadata = SettableMetadata(
      contentType: _getContentType(extension),
      customMetadata: {
        'originalFileName': originalFileName,
      },
    );

    // Upload audio file with metadata
    final uploadTask = await storageRef.putData(
      file.bytes!,
      metadata,
    );

    // Get download URL
    final downloadURL = await uploadTask.ref.getDownloadURL();

    // Note: Cover image extraction from audio metadata is complex and may not work
    // for all audio formats. User can upload cover image separately if needed.
    String? imageUrl = null;

    // Extract title from filename (without extension)
    String title = originalFileName.contains('.')
        ? originalFileName.substring(0, originalFileName.lastIndexOf('.'))
        : originalFileName;

    // Create and return AudioFileStruct
    return AudioFileStruct(
      audioPath: downloadURL,
      image: imageUrl,
      title: title,
      author: '',
      index: 0,
      duration: formattedDuration,
    );
  } catch (e) {
    print('Error uploading audio: $e');
    // Return default struct in case of error
    return AudioFileStruct(
      audioPath: '',
      image: '',
      title: 'unknown',
      author: '',
      index: 0,
      duration: '00:00',
    );
  } finally {
    // Cleanup
    if (player != null) {
      await player.dispose();
    }
    if (tempFile != null && await tempFile.exists()) {
      try {
        await tempFile.delete();
      } catch (e) {
        print('Error deleting temp file: $e');
      }
    }
  }
}

// Helper function to format duration as HH:mm:ss or MM:SS
String _formatDuration(Duration duration) {
  int totalSeconds = duration.inSeconds;

  if (totalSeconds < 0) {
    return '00:00';
  }

  int hours = totalSeconds ~/ 3600;
  int minutes = (totalSeconds % 3600) ~/ 60;
  int seconds = totalSeconds % 60;

  if (hours > 0) {
    // Format: HH:mm:ss
    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  } else {
    // Format: MM:SS
    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }
}

// Helper function to determine content type
String _getContentType(String extension) {
  switch (extension.toLowerCase()) {
    case 'mp3':
      return 'audio/mpeg';
    case 'm4a':
      return 'audio/mp4';
    case 'aac':
      return 'audio/aac';
    case 'wav':
      return 'audio/wav';
    case 'ogg':
      return 'audio/ogg';
    case 'flac':
      return 'audio/flac';
    default:
      return 'audio/mpeg';
  }
}
