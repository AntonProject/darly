import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/back_button/back_button_widget.dart';
import '/components/dialogs/country_dialog/country_dialog_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'about_you_widget.dart' show AboutYouWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class AboutYouModel extends FlutterFlowModel<AboutYouWidget> {
  ///  Local state fields for this page.

  String? countryState;

  DateTime? date;

  String? countryCodeState;

  ///  State fields for stateful widgets in this page.

  final formKey2 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  // Model for backButton component.
  late BackButtonModel backButtonModel;
  // State field(s) for Column widget.
  ScrollController? columnController;
  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  String? _nameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Введите от 1 до 50 символов';
    }

    if (val.length < 1) {
      return 'Минимум 1 символ';
    }
    if (val.length > 30) {
      return 'Максимум 50 символов';
    }

    return null;
  }

  // State field(s) for surname widget.
  FocusNode? surnameFocusNode;
  TextEditingController? surnameTextController;
  String? Function(BuildContext, String?)? surnameTextControllerValidator;
  String? _surnameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Введите от 1 до 50 символов';
    }

    if (val.length < 1) {
      return 'Минимум 1 символ';
    }
    if (val.length > 50) {
      return 'Максимум 50 символов';
    }

    return null;
  }

  DateTime? datePicked;

  @override
  void initState(BuildContext context) {
    backButtonModel = createModel(context, () => BackButtonModel());
    columnController = ScrollController();
    nameTextControllerValidator = _nameTextControllerValidator;
    surnameTextControllerValidator = _surnameTextControllerValidator;
  }

  @override
  void dispose() {
    backButtonModel.dispose();
    columnController?.dispose();
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    surnameFocusNode?.dispose();
    surnameTextController?.dispose();
  }
}
