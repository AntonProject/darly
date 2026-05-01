import '/components/support_button/support_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'reset_password_email_sent_widget.dart'
    show ResetPasswordEmailSentWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ResetPasswordEmailSentModel
    extends FlutterFlowModel<ResetPasswordEmailSentWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for supportButton component.
  late SupportButtonModel supportButtonModel;

  @override
  void initState(BuildContext context) {
    supportButtonModel = createModel(context, () => SupportButtonModel());
  }

  @override
  void dispose() {
    supportButtonModel.dispose();
  }
}
