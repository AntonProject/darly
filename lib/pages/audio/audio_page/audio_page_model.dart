import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_list/empty_list_widget.dart';
import '/components/navbar/navbar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/audio/audio_category/audio_category_widget.dart';
import '/pages/audio/audio_home_comp/audio_home_comp_widget.dart';
import '/pages/payment/premium/premium_widget.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'audio_page_widget.dart' show AudioPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AudioPageModel extends FlutterFlowModel<AudioPageWidget> {
  ///  Local state fields for this page.

  String? selectedItem = 'Новое';

  ///  State fields for stateful widgets in this page.

  // Model for premium component.
  late PremiumModel premiumModel;
  // Model for navbar component.
  late NavbarModel navbarModel;

  @override
  void initState(BuildContext context) {
    premiumModel = createModel(context, () => PremiumModel());
    navbarModel = createModel(context, () => NavbarModel());
  }

  @override
  void dispose() {
    premiumModel.dispose();
    navbarModel.dispose();
  }
}
