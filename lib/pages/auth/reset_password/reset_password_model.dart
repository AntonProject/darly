import '/auth/firebase_auth/auth_util.dart';
import '/components/back_button/back_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'reset_password_widget.dart' show ResetPasswordWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ResetPasswordModel extends FlutterFlowModel<ResetPasswordWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for backButton component.
  late BackButtonModel backButtonModel;
  // State field(s) for email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  String? _emailTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Укажите email';
    }

    if (val.length < 6) {
      return 'Минимум 6 символов';
    }
    if (val.length > 50) {
      return 'Максимум 50 символов';
    }
    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Неверный формал почты';
    }
    return null;
  }

  @override
  void initState(BuildContext context) {
    backButtonModel = createModel(context, () => BackButtonModel());
    emailTextControllerValidator = _emailTextControllerValidator;
  }

  @override
  void dispose() {
    backButtonModel.dispose();
    emailFocusNode?.dispose();
    emailTextController?.dispose();
  }
}
