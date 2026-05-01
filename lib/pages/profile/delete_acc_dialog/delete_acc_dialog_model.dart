import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'delete_acc_dialog_widget.dart' show DeleteAccDialogWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DeleteAccDialogModel extends FlutterFlowModel<DeleteAccDialogWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  // State field(s) for reason widget.
  FocusNode? reasonFocusNode1;
  TextEditingController? reasonTextController1;
  String? Function(BuildContext, String?)? reasonTextController1Validator;
  String? _reasonTextController1Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Напишите причину is required';
    }

    if (val.length < 1) {
      return 'Минимум 1 символ';
    }
    if (val.length > 400) {
      return 'Максимум 400 символов';
    }

    return null;
  }

  // State field(s) for reason widget.
  FocusNode? reasonFocusNode2;
  TextEditingController? reasonTextController2;
  String? Function(BuildContext, String?)? reasonTextController2Validator;
  String? _reasonTextController2Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Напишите причину is required';
    }

    if (val.length < 1) {
      return 'Минимум 1 символ';
    }
    if (val.length > 400) {
      return 'Максимум 400 символов';
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    reasonTextController1Validator = _reasonTextController1Validator;
    reasonTextController2Validator = _reasonTextController2Validator;
  }

  @override
  void dispose() {
    reasonFocusNode1?.dispose();
    reasonTextController1?.dispose();

    reasonFocusNode2?.dispose();
    reasonTextController2?.dispose();
  }
}
