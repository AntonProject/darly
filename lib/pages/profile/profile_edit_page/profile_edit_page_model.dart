import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/back_button/back_button_widget.dart';
import '/components/dialogs/country_dialog/country_dialog_widget.dart';
import '/components/dialogs/photo_upload_dialog/photo_upload_dialog_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/profile/delete_acc_dialog/delete_acc_dialog_widget.dart';
import '/pages/profile/logout_dialog/logout_dialog_widget.dart';
import '/web/navbar_web/navbar_web_widget.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'profile_edit_page_widget.dart' show ProfileEditPageWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class ProfileEditPageModel extends FlutterFlowModel<ProfileEditPageWidget> {
  ///  Local state fields for this page.

  String? photo;

  DateTime? date;

  String? countryState;

  String? countryCodeState;

  Color? dateBorder = Color(0);

  Color? countryBorder = Color(0);

  ///  State fields for stateful widgets in this page.

  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  // Model for navbarWeb component.
  late NavbarWebModel navbarWebModel;
  // Model for backButton component.
  late BackButtonModel backButtonModel1;
  // Model for backButton component.
  late BackButtonModel backButtonModel2;
  // State field(s) for Column widget.
  ScrollController? columnController;
  // State field(s) for email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
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
    if (val.length > 50) {
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
  // State field(s) for countryDD widget.
  String? countryDDValue;
  FormFieldController<String>? countryDDValueController;

  @override
  void initState(BuildContext context) {
    navbarWebModel = createModel(context, () => NavbarWebModel());
    backButtonModel1 = createModel(context, () => BackButtonModel());
    backButtonModel2 = createModel(context, () => BackButtonModel());
    columnController = ScrollController();
    nameTextControllerValidator = _nameTextControllerValidator;
    surnameTextControllerValidator = _surnameTextControllerValidator;
  }

  @override
  void dispose() {
    navbarWebModel.dispose();
    backButtonModel1.dispose();
    backButtonModel2.dispose();
    columnController?.dispose();
    emailFocusNode?.dispose();
    emailTextController?.dispose();

    nameFocusNode?.dispose();
    nameTextController?.dispose();

    surnameFocusNode?.dispose();
    surnameTextController?.dispose();
  }
}
