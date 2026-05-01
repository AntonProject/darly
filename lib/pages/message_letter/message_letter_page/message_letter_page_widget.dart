import '/components/back_button/back_button_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'message_letter_page_model.dart';
export 'message_letter_page_model.dart';

class MessageLetterPageWidget extends StatefulWidget {
  const MessageLetterPageWidget({
    super.key,
    required this.message,
    required this.messageImg,
  });

  final String? message;
  final String? messageImg;

  static String routeName = 'MessageLetterPage';
  static String routePath = '/messageLetterPage';

  @override
  State<MessageLetterPageWidget> createState() =>
      _MessageLetterPageWidgetState();
}

class _MessageLetterPageWidgetState extends State<MessageLetterPageWidget>
    with TickerProviderStateMixin {
  late MessageLetterPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MessageLetterPageModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'MessageLetterPage'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('MESSAGE_LETTER_MessageLetterPage_ON_INIT');
      logFirebaseEvent('MessageLetterPage_custom_action');
      unawaited(
        () async {
          await actions.setStatusBarColor();
        }(),
      );
      logFirebaseEvent('MessageLetterPage_custom_action');
      unawaited(
        () async {
          await actions.lockLandscapeMode();
        }(),
      );
    });

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 2000.0.ms,
            duration: 1000.0.ms,
            color: Color(0x80FFFFFF),
            angle: 0.524,
          ),
        ],
      ),
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
        title: 'MessageLetterPage',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height * 1.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        getCORSProxyUrl(
                          valueOrDefault<String>(
                            widget!.messageImg,
                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/woman-103qa6/assets/4k9xamc0srkn/_01.webp',
                          ),
                        ),
                      ),
                    ),
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        valueOrDefault<String>(
                          widget!.message,
                          'Я притягиваю изобилие без усилий',
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 10,
                        style: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .override(
                              fontFamily: FlutterFlowTheme.of(context)
                                  .headlineMediumFamily,
                              color: FlutterFlowTheme.of(context).info,
                              fontSize: 24.0,
                              letterSpacing: 0.0,
                              lineHeight: 1.25,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .headlineMediumIsCustom,
                            ),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ).animateOnPageLoad(
                    animationsMap['containerOnPageLoadAnimation']!),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 54.0, 0.0, 4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      wrapWithModel(
                        model: _model.backButtonModel1,
                        updateCallback: () => safeSetState(() {}),
                        child: BackButtonWidget(
                          icon: Icon(
                            FFIcons.kleftIcon3,
                            color: FlutterFlowTheme.of(context).info,
                            size: 24.0,
                          ),
                          action: () async {
                            logFirebaseEvent(
                                'MESSAGE_LETTER_Container_s86k8vvv_CALLBA');
                            logFirebaseEvent('backButton_navigate_back');
                            context.safePop();
                          },
                        ),
                      ),
                      Text(
                        'Послание дня',
                        style:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .titleMediumFamily,
                                  color: FlutterFlowTheme.of(context).info,
                                  fontSize: 17.0,
                                  letterSpacing: 0.0,
                                  lineHeight: 1.2,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .titleMediumIsCustom,
                                ),
                      ),
                      Builder(
                        builder: (context) => Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 12.0, 0.0),
                          child: wrapWithModel(
                            model: _model.backButtonModel2,
                            updateCallback: () => safeSetState(() {}),
                            child: BackButtonWidget(
                              icon: Icon(
                                FFIcons.kshare2,
                                color: FlutterFlowTheme.of(context).info,
                                size: 24.0,
                              ),
                              action: () async {
                                logFirebaseEvent(
                                    'MESSAGE_LETTER_Container_t0379i2k_CALLBA');
                                logFirebaseEvent('backButton_share');
                                unawaited(
                                  () async {
                                    await Share.share(
                                      'woman://com.appfyl.woman${GoRouterState.of(context).uri.toString()}',
                                      sharePositionOrigin:
                                          getWidgetBoundingBox(context),
                                    );
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
                if (_model.video)
                  Container(
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
                        logFirebaseEvent(
                            'MESSAGE_LETTER_Container_rmg107px_CALLBA');
                        logFirebaseEvent('FullScreenVideo_update_page_state');
                        _model.video = false;
                        safeSetState(() {});
                      },
                    ),
                  ),
              ],
            ),
          ),
        ));
  }
}
