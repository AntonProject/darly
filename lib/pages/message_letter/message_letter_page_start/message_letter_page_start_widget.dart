import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'message_letter_page_start_model.dart';
export 'message_letter_page_start_model.dart';

class MessageLetterPageStartWidget extends StatefulWidget {
  const MessageLetterPageStartWidget({super.key});

  static String routeName = 'MessageLetterPageStart';
  static String routePath = '/messageLetterPageStart';

  @override
  State<MessageLetterPageStartWidget> createState() =>
      _MessageLetterPageStartWidgetState();
}

class _MessageLetterPageStartWidgetState
    extends State<MessageLetterPageStartWidget> {
  late MessageLetterPageStartModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MessageLetterPageStartModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'MessageLetterPageStart'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('MESSAGE_LETTER_START_MessageLetterPageSt');
      logFirebaseEvent('MessageLetterPageStart_custom_action');
      _model.messageDoc = await actions.messageLetterQuery(
        currentUserUid,
        (currentUserDocument?.messageShown?.toList() ?? []).toList(),
      );
      logFirebaseEvent('MessageLetterPageStart_update_page_state');
      _model.mess = _model.messageDoc?.text;
      _model.img = _model.messageDoc?.image;
      logFirebaseEvent('MessageLetterPageStart_custom_action');
      unawaited(
        () async {
          await actions.setStatusBarColor();
        }(),
      );
      logFirebaseEvent('MessageLetterPageStart_custom_action');
      unawaited(
        () async {
          await actions.lockLandscapeMode();
        }(),
      );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
        title: 'MessageLetterPageStart',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Container(
              width: double.infinity,
              height: double.infinity,
              child: custom_widgets.FullScreenVideo(
                width: double.infinity,
                height: double.infinity,
                videoUrl:
                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/woman-103qa6/assets/vlft9wj8hzkc/2506ef4c89aa2a25bc33f24ad3bf2f5c_82d9a274_27bc_4472_af10_9a02aca4c5c2-ezgif.com-crop-video.mp4',
                looping: false,
                autoPlay: true,
                radius: 0.0,
                onVideoEnd: () async {
                  logFirebaseEvent('MESSAGE_LETTER_START_Container_uw23lz9k_');
                  logFirebaseEvent('FullScreenVideo_navigate_to');
                  if (Navigator.of(context).canPop()) {
                    context.pop();
                  }
                  context.pushNamed(
                    MessageLetterPageWidget.routeName,
                    queryParameters: {
                      'message': serializeParam(
                        _model.mess,
                        ParamType.String,
                      ),
                      'messageImg': serializeParam(
                        _model.img,
                        ParamType.String,
                      ),
                    }.withoutNulls,
                    extra: <String, dynamic>{
                      '__transition_info__': TransitionInfo(
                        hasTransition: true,
                        transitionType: PageTransitionType.fade,
                      ),
                    },
                  );
                },
              ),
            ),
          ),
        ));
  }
}
