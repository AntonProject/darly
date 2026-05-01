import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/audio_player_comp/audio_player_comp_widget.dart';
import '/components/back_button/back_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'audio_player_widget.dart' show AudioPlayerWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AudioPlayerModel extends FlutterFlowModel<AudioPlayerWidget> {
  ///  Local state fields for this page.

  bool wish = false;

  ///  State fields for stateful widgets in this page.

  // Model for backButton component.
  late BackButtonModel backButtonModel;
  // Model for AudioPlayerComp component.
  late AudioPlayerCompModel audioPlayerCompModel;

  @override
  void initState(BuildContext context) {
    backButtonModel = createModel(context, () => BackButtonModel());
    audioPlayerCompModel = createModel(context, () => AudioPlayerCompModel());
  }

  @override
  void dispose() {
    backButtonModel.dispose();
    audioPlayerCompModel.dispose();
  }
}
