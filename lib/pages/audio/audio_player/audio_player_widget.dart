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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'audio_player_model.dart';
export 'audio_player_model.dart';

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget({
    super.key,
    String? title,
    this.currentTrack,
    this.audioFiles,
  }) : this.title = title ?? 'Подкасты';

  final String title;
  final AudioRecord? currentTrack;
  final List<AudioRecord>? audioFiles;

  static String routeName = 'AudioPlayer';
  static String routePath = '/audioPlayer/:title/:currentTrack/:audioFiles';

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayerModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AudioPlayerModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'AudioPlayer'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('AUDIO_PLAYER_AudioPlayer_ON_INIT_STATE');
      logFirebaseEvent('AudioPlayer_custom_action');
      unawaited(
        () async {
          await actions.setStatusBarColor();
        }(),
      );
      logFirebaseEvent('AudioPlayer_custom_action');
      unawaited(
        () async {
          await actions.lockLandscapeMode();
        }(),
      );
      logFirebaseEvent('AudioPlayer_backend_call');
      unawaited(
        () async {
          await currentUserReference!.update(createUsersRecordData(
            lastListenedAt: getCurrentTimestamp,
          ));
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
        title: 'AudioPlayer',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Align(
              alignment: AlignmentDirectional(0.0, -1.0),
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  maxWidth: double.infinity,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.asset(
                      'assets/images/Page-Podcasts-1.webp',
                    ).image,
                  ),
                ),
                child: Align(
                  alignment: AlignmentDirectional(0.0, -1.0),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: 600.0,
                    ),
                    decoration: BoxDecoration(),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 54.0, 0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 4.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                  child: wrapWithModel(
                                    model: _model.backButtonModel,
                                    updateCallback: () => safeSetState(() {}),
                                    child: BackButtonWidget(
                                      icon: Icon(
                                        FFIcons.kleftIcon3,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 24.0,
                                      ),
                                      action: () async {
                                        logFirebaseEvent(
                                            'AUDIO_PLAYER_Container_qza8q1a1_CALLBACK');
                                        logFirebaseEvent(
                                            'backButton_navigate_back');
                                        context.safePop();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 16.0, 0.0, 0.0),
                              child: wrapWithModel(
                                model: _model.audioPlayerCompModel,
                                updateCallback: () => safeSetState(() {}),
                                updateOnChange: true,
                                child: AudioPlayerCompWidget(
                                  currentTrack: widget!.currentTrack,
                                  trackList: widget!.audioFiles!,
                                  link:
                                      'woman://com.appfyl.woman${GoRouterState.of(context).uri.toString()}',
                                ),
                              ),
                            ),
                          ),
                        ].addToEnd(SizedBox(height: 48.0)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
