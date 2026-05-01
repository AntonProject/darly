import '/components/back_button/back_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/web/navbar_web/navbar_web_widget.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'support_page_widget.dart' show SupportPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPageModel extends FlutterFlowModel<SupportPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for navbarWeb component.
  late NavbarWebModel navbarWebModel;
  // Model for backButton component.
  late BackButtonModel backButtonModel;

  @override
  void initState(BuildContext context) {
    navbarWebModel = createModel(context, () => NavbarWebModel());
    backButtonModel = createModel(context, () => BackButtonModel());
  }

  @override
  void dispose() {
    navbarWebModel.dispose();
    backButtonModel.dispose();
  }
}
