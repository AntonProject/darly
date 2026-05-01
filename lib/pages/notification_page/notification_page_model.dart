import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/back_button/back_button_widget.dart';
import '/components/notif_comp/notif_comp_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'notification_page_widget.dart' show NotificationPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NotificationPageModel extends FlutterFlowModel<NotificationPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for backButton component.
  late BackButtonModel backButtonModel;

  @override
  void initState(BuildContext context) {
    backButtonModel = createModel(context, () => BackButtonModel());
  }

  @override
  void dispose() {
    backButtonModel.dispose();
  }
}
