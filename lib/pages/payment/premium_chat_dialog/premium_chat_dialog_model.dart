import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/back_button/back_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'premium_chat_dialog_widget.dart' show PremiumChatDialogWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PremiumChatDialogModel extends FlutterFlowModel<PremiumChatDialogWidget> {
  ///  Local state fields for this component.

  int? period = 12;

  double? price = 12000.0;

  ///  State fields for stateful widgets in this component.

  // Model for backButton component.
  late BackButtonModel backButtonModel;
  // Stores action output result for [Backend Call - Create Document] action in Container widget.
  OrderRecord? newOrder;

  @override
  void initState(BuildContext context) {
    backButtonModel = createModel(context, () => BackButtonModel());
  }

  @override
  void dispose() {
    backButtonModel.dispose();
  }
}
