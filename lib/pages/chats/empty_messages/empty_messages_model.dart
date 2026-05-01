import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/audio/rowtitle/rowtitle_widget.dart';
import '/pages/chats/chat_message_start/chat_message_start_widget.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'empty_messages_widget.dart' show EmptyMessagesWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EmptyMessagesModel extends FlutterFlowModel<EmptyMessagesWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for chatMessageStart component.
  late ChatMessageStartModel chatMessageStartModel;

  @override
  void initState(BuildContext context) {
    chatMessageStartModel = createModel(context, () => ChatMessageStartModel());
  }

  @override
  void dispose() {
    chatMessageStartModel.dispose();
  }
}
