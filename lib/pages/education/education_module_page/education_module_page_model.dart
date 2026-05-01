import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/back_button/back_button_widget.dart';
import '/components/empty_list/empty_list_widget.dart';
import '/components/navbar/navbar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/education/education_module_lesson_comp/education_module_lesson_comp_widget.dart';
import '/web/navbar_web/navbar_web_widget.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'education_module_page_widget.dart' show EducationModulePageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EducationModulePageModel
    extends FlutterFlowModel<EducationModulePageWidget> {
  ///  Local state fields for this page.

  int? countLessons = 0;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in EducationModulePage widget.
  int? countQuery;
  // Model for navbarWeb component.
  late NavbarWebModel navbarWebModel;
  // Model for backButton component.
  late BackButtonModel backButtonModel;
  // Model for navbar component.
  late NavbarModel navbarModel;

  @override
  void initState(BuildContext context) {
    navbarWebModel = createModel(context, () => NavbarWebModel());
    backButtonModel = createModel(context, () => BackButtonModel());
    navbarModel = createModel(context, () => NavbarModel());
  }

  @override
  void dispose() {
    navbarWebModel.dispose();
    backButtonModel.dispose();
    navbarModel.dispose();
  }
}
