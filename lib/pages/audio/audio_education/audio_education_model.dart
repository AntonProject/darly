import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'audio_education_widget.dart' show AudioEducationWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AudioEducationModel extends FlutterFlowModel<AudioEducationWidget> {
  ///  Local state fields for this component.

  AudioRecord? audioDoc;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - audioRef] action in audioEducation widget.
  AudioRecord? audioQuery;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
