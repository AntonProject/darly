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

import 'package:just_audio_background/just_audio_background.dart';

Future justAudioBackground() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.appfyl.woman.audio',
    androidNotificationChannelName: 'DARLY Audio',
    androidNotificationOngoing: true,
    androidStopForegroundOnPause: true,
  );
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
