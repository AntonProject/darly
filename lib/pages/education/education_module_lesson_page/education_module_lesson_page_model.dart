import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/back_button/back_button_widget.dart';
import '/components/empty_list/empty_list_widget.dart';
import '/components/file_comp/file_comp_widget.dart';
import '/components/navbar/navbar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/audio/audio_education/audio_education_widget.dart';
import '/pages/education/education_lesson_note_dialog/education_lesson_note_dialog_widget.dart';
import '/pages/education/lesson_chapter/lesson_chapter_widget.dart';
import '/web/navbar_web/navbar_web_widget.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'education_module_lesson_page_widget.dart'
    show EducationModuleLessonPageWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class EducationModuleLessonPageModel
    extends FlutterFlowModel<EducationModuleLessonPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for navbarWeb component.
  late NavbarWebModel navbarWebModel;
  // Model for backButton component.
  late BackButtonModel backButtonModel1;
  // Model for backButton component.
  late BackButtonModel backButtonModel2;
  // Model for audioEducation component.
  late AudioEducationModel audioEducationModel;
  // State field(s) for messageField widget.
  FocusNode? messageFieldFocusNode;
  TextEditingController? messageFieldTextController;
  String? Function(BuildContext, String?)? messageFieldTextControllerValidator;
  // Model for navbar component.
  late NavbarModel navbarModel;

  @override
  void initState(BuildContext context) {
    navbarWebModel = createModel(context, () => NavbarWebModel());
    backButtonModel1 = createModel(context, () => BackButtonModel());
    backButtonModel2 = createModel(context, () => BackButtonModel());
    audioEducationModel = createModel(context, () => AudioEducationModel());
    navbarModel = createModel(context, () => NavbarModel());
  }

  @override
  void dispose() {
    navbarWebModel.dispose();
    backButtonModel1.dispose();
    backButtonModel2.dispose();
    audioEducationModel.dispose();
    messageFieldFocusNode?.dispose();
    messageFieldTextController?.dispose();

    navbarModel.dispose();
  }
}
