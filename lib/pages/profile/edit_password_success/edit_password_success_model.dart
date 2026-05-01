import '/components/support_button/support_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/web/navbar_web/navbar_web_widget.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'edit_password_success_widget.dart' show EditPasswordSuccessWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditPasswordSuccessModel
    extends FlutterFlowModel<EditPasswordSuccessWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for navbarWeb component.
  late NavbarWebModel navbarWebModel;
  // Model for supportButton component.
  late SupportButtonModel supportButtonModel;

  @override
  void initState(BuildContext context) {
    navbarWebModel = createModel(context, () => NavbarWebModel());
    supportButtonModel = createModel(context, () => SupportButtonModel());
  }

  @override
  void dispose() {
    navbarWebModel.dispose();
    supportButtonModel.dispose();
  }
}
