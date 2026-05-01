import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/back_button/back_button_widget.dart';
import '/components/calendar_day_comp/calendar_day_comp_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/calendar/add_end_date_dialog/add_end_date_dialog_widget.dart';
import '/pages/calendar/add_start_date_dialog/add_start_date_dialog_widget.dart';
import '/pages/calendar/edit_cycle_length/edit_cycle_length_widget.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'calendar_page_widget.dart' show CalendarPageWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class CalendarPageModel extends FlutterFlowModel<CalendarPageWidget> {
  ///  Local state fields for this page.

  DateTime? selectedDate;

  ///  State fields for stateful widgets in this page.

  // Model for backButton component.
  late BackButtonModel backButtonModel1;
  // Model for backButton component.
  late BackButtonModel backButtonModel2;

  @override
  void initState(BuildContext context) {
    backButtonModel1 = createModel(context, () => BackButtonModel());
    backButtonModel2 = createModel(context, () => BackButtonModel());
  }

  @override
  void dispose() {
    backButtonModel1.dispose();
    backButtonModel2.dispose();
  }
}
