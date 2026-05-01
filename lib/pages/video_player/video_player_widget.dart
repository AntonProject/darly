import '/components/back_button/back_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_youtube_player.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'video_player_model.dart';
export 'video_player_model.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    super.key,
    required this.urltoPath,
  });

  final String? urltoPath;

  static String routeName = 'videoPlayer';
  static String routePath = '/videoPlayer';

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VideoPlayerModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'videoPlayer'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('VIDEO_PLAYER_videoPlayer_ON_INIT_STATE');
      logFirebaseEvent('videoPlayer_custom_action');
      unawaited(
        () async {
          await actions.unlockLandscapeMode();
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
    return YoutubeFullScreenWrapper(
      child: Title(
          title: 'videoPlayer',
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
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.asset(
                      'assets/images/Background.webp',
                    ).image,
                  ),
                ),
                child: Align(
                  alignment: AlignmentDirectional(1.0, -1.0),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height * 1.0,
                    child: Stack(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      children: [
                        if (valueOrDefault<bool>(
                          widget!.urltoPath != null && widget!.urltoPath != '',
                          false,
                        ))
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: FlutterFlowYoutubePlayer(
                              url: widget!.urltoPath!,
                              width: double.infinity,
                              height: double.infinity,
                              autoPlay: false,
                              looping: true,
                              mute: false,
                              showControls: true,
                              showFullScreen: true,
                              strictRelatedVideos: false,
                            ),
                          ),
                        Align(
                          alignment: AlignmentDirectional(1.0, -1.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 54.0, 12.0, 0.0),
                            child: wrapWithModel(
                              model: _model.backButtonModel,
                              updateCallback: () => safeSetState(() {}),
                              child: BackButtonWidget(
                                icon: Icon(
                                  FFIcons.kcloseIcon,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 28.0,
                                ),
                                action: () async {
                                  logFirebaseEvent(
                                      'VIDEO_PLAYER_Container_jqw6dci1_CALLBACK');
                                  logFirebaseEvent(
                                      'backButton_haptic_feedback');
                                  HapticFeedback.mediumImpact();
                                  logFirebaseEvent('backButton_navigate_back');
                                  context.safePop();
                                  logFirebaseEvent('backButton_custom_action');
                                  unawaited(
                                    () async {
                                      await actions.lockLandscapeMode();
                                    }(),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
