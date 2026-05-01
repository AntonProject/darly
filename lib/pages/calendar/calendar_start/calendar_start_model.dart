import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/back_button/back_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/calendar/days_dropdown_dialog/days_dropdown_dialog_widget.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'calendar_start_widget.dart' show CalendarStartWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class CalendarStartModel extends FlutterFlowModel<CalendarStartWidget> {
  ///  Local state fields for this page.

  DateTime? date;

  int? duration = 0;

  int? lengthCycle = 0;

  ///  State fields for stateful widgets in this page.

  // Model for backButton component.
  late BackButtonModel backButtonModel;
  DateTime? datePicked;

  @override
  void initState(BuildContext context) {
    backButtonModel = createModel(context, () => BackButtonModel());
  }

  @override
  void dispose() {
    backButtonModel.dispose();
  }
}
