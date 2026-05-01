import '/components/back_button/back_button_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/web/navbar_web/navbar_web_widget.dart';
import 'dart:async';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'about_app_page_widget.dart' show AboutAppPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AboutAppPageModel extends FlutterFlowModel<AboutAppPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - pakageInfo] action in aboutAppPage widget.
  String? version;
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
