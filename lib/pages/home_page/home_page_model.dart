import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/audio_day_home/audio_day_home_widget.dart';
import '/components/back_button/back_button_widget.dart';
import '/components/empty_list/empty_list_widget.dart';
import '/components/navbar/navbar_widget.dart';
import '/components/video_home_comp/video_home_comp_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/audio/rowtitle/rowtitle_widget.dart';
import '/pages/payment/premium/premium_widget.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for audioDayHome component.
  late AudioDayHomeModel audioDayHomeModel;
  // Stores action output result for [Custom Action - messageLetterQuery] action in CustomSlider widget.
  MessageLetterRecord? messageDoc;
  // Model for premium component.
  late PremiumModel premiumModel;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  CalendarRecord? newCalend;
  // Model for backButton component.
  late BackButtonModel backButtonModel;
  // Model for navbar component.
  late NavbarModel navbarModel;

  @override
  void initState(BuildContext context) {
    audioDayHomeModel = createModel(context, () => AudioDayHomeModel());
    premiumModel = createModel(context, () => PremiumModel());
    backButtonModel = createModel(context, () => BackButtonModel());
    navbarModel = createModel(context, () => NavbarModel());
  }

  @override
  void dispose() {
    audioDayHomeModel.dispose();
    premiumModel.dispose();
    backButtonModel.dispose();
    navbarModel.dispose();
  }
}
