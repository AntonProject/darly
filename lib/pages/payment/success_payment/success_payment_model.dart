import '/components/support_button/support_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'success_payment_widget.dart' show SuccessPaymentWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SuccessPaymentModel extends FlutterFlowModel<SuccessPaymentWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for supportButton component.
  late SupportButtonModel supportButtonModel;

  @override
  void initState(BuildContext context) {
    supportButtonModel = createModel(context, () => SupportButtonModel());
  }

  @override
  void dispose() {
    supportButtonModel.dispose();
  }
}
