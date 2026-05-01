import '/backend/backend.dart';
import '/components/back_button/back_button_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'meta_card_page_widget.dart' show MetaCardPageWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class MetaCardPageModel extends FlutterFlowModel<MetaCardPageWidget> {
  ///  Local state fields for this page.

  int? step = 1;

  ///  State fields for stateful widgets in this page.

  // Model for backButton component.
  late BackButtonModel backButtonModel1;
  // Model for backButton component.
  late BackButtonModel backButtonModel2;

  @override
  void initState(BuildContext context) {
    backButtonModel1 = createModel(context, () => BackButtonModel());
    backButtonModel2 = createModel(context, () => BackButtonModel());
  }

  @override
  void dispose() {
    backButtonModel1.dispose();
    backButtonModel2.dispose();
  }
}
