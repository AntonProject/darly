import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'audio_day_home_widget.dart' show AudioDayHomeWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AudioDayHomeModel extends FlutterFlowModel<AudioDayHomeWidget> {
  ///  Local state fields for this component.

  AudioRecord? track;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in Container widget.
  AudioRecord? userDayPractic;
  // Stores action output result for [Custom Action - practicOfDayAudio] action in Container widget.
  AudioRecord? practicRandomAudio;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
