import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/audio/rowtitle/rowtitle_widget.dart';
import '/pages/chats/chat_message_start/chat_message_start_widget.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'empty_messages_model.dart';
export 'empty_messages_model.dart';

class EmptyMessagesWidget extends StatefulWidget {
  const EmptyMessagesWidget({
    super.key,
    bool? emptyField,
    this.setPresset,
    int? messageCount,
  })  : this.emptyField = emptyField ?? false,
        this.messageCount = messageCount ?? 0;

  final bool emptyField;
  final Future Function()? setPresset;
  final int messageCount;

  @override
  State<EmptyMessagesWidget> createState() => _EmptyMessagesWidgetState();
}

class _EmptyMessagesWidgetState extends State<EmptyMessagesWidget> {
  late EmptyMessagesModel _model;

  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmptyMessagesModel());

    if (!isWeb) {
      _keyboardVisibilitySubscription =
          KeyboardVisibilityController().onChange.listen((bool visible) {
        safeSetState(() {
          _isKeyboardVisible = visible;
        });
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    if (!isWeb) {
      _keyboardVisibilitySubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 1.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            wrapWithModel(
              model: _model.chatMessageStartModel,
              updateCallback: () => safeSetState(() {}),
              child: ChatMessageStartWidget(),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 1.0),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 800.0,
                ),
                decoration: BoxDecoration(),
                child: Container(
                  width: double.infinity,
                  height: null,
                  child: custom_widgets.DoubleRowList(
                    width: double.infinity,
                    height: null,
                    list: functions.pressets(),
                    offset: 60.0,
                    startEndSpacing: 20.0,
                    itemBuilder: (String item) => RowtitleWidget(
                      title: item,
                      select: (title) async {
                        logFirebaseEvent(
                            'EMPTY_MESSAGES_Container_48wj95ek_CALLBA');
                        logFirebaseEvent('DoubleRowList_haptic_feedback');
                        HapticFeedback.mediumImpact();
                        logFirebaseEvent('DoubleRowList_execute_callback');
                        await widget.setPresset?.call();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ].addToStart(SizedBox(height: 40.0)).addToEnd(SizedBox(
                  height: valueOrDefault<double>(
                (isWeb
                        ? MediaQuery.viewInsetsOf(context).bottom > 0
                        : _isKeyboardVisible)
                    ? 100.0
                    : 250.0,
                250.0,
              ))),
        ),
      ),
    );
  }
}
