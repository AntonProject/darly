import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'education_note_dialog_widget.dart' show EducationNoteDialogWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EducationNoteDialogModel
    extends FlutterFlowModel<EducationNoteDialogWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for messageField widget.
  FocusNode? messageFieldFocusNode1;
  TextEditingController? messageFieldTextController1;
  String? Function(BuildContext, String?)? messageFieldTextController1Validator;
  // State field(s) for messageField widget.
  FocusNode? messageFieldFocusNode2;
  TextEditingController? messageFieldTextController2;
  String? Function(BuildContext, String?)? messageFieldTextController2Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    messageFieldFocusNode1?.dispose();
    messageFieldTextController1?.dispose();

    messageFieldFocusNode2?.dispose();
    messageFieldTextController2?.dispose();
  }
}
