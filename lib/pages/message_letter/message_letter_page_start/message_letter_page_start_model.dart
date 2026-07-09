import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'message_letter_page_start_widget.dart'
    show MessageLetterPageStartWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MessageLetterPageStartModel
    extends FlutterFlowModel<MessageLetterPageStartWidget> {
  ///  Local state fields for this page.

  String? mess;

  String? img;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - messageLetterQuery] action in MessageLetterPageStart widget.
  MessageLetterRecord? messageDoc;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
