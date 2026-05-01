import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/back_button/back_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/payment/fail_payment/fail_payment_widget.dart';
import '/pages/payment/success_payment/success_payment_widget.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'cloud_payment_page_widget.dart' show CloudPaymentPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CloudPaymentPageModel extends FlutterFlowModel<CloudPaymentPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for backButton component.
  late BackButtonModel backButtonModel;
  // Model for successPayment component.
  late SuccessPaymentModel successPaymentModel;
  // Model for failPayment component.
  late FailPaymentModel failPaymentModel;

  @override
  void initState(BuildContext context) {
    backButtonModel = createModel(context, () => BackButtonModel());
    successPaymentModel = createModel(context, () => SuccessPaymentModel());
    failPaymentModel = createModel(context, () => FailPaymentModel());
  }

  @override
  void dispose() {
    backButtonModel.dispose();
    successPaymentModel.dispose();
    failPaymentModel.dispose();
  }
}
