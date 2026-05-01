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
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'meta_card_page_model.dart';
export 'meta_card_page_model.dart';

class MetaCardPageWidget extends StatefulWidget {
  const MetaCardPageWidget({
    super.key,
    required this.metaCard,
  });

  final MetaCardsRecord? metaCard;

  static String routeName = 'MetaCardPage';
  static String routePath = '/metaCardPage';

  @override
  State<MetaCardPageWidget> createState() => _MetaCardPageWidgetState();
}

class _MetaCardPageWidgetState extends State<MetaCardPageWidget>
    with TickerProviderStateMixin {
  late MetaCardPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MetaCardPageModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'MetaCardPage'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('META_CARD_MetaCardPage_ON_INIT_STATE');
      logFirebaseEvent('MetaCardPage_custom_action');
      unawaited(
        () async {
          await actions.setStatusBarColor();
        }(),
      );
      logFirebaseEvent('MetaCardPage_custom_action');
      unawaited(
        () async {
          await actions.lockLandscapeMode();
        }(),
      );
    });

    animationsMap.addAll({
      'imageOnActionTriggerAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          TiltEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 800.0.ms,
            begin: Offset(0, 0),
            end: Offset(0, 1.571),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 600.0.ms,
            duration: 600.0.ms,
            begin: 1.0,
            end: 0.0,
          ),
        ],
      ),
      'textOnActionTriggerAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          BlurEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 800.0.ms,
            begin: Offset(4.0, 4.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'textOnActionTriggerAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          BlurEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 800.0.ms,
            begin: Offset(4.0, 4.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'imageOnActionTriggerAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 800.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'columnOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1200.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

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
        title: 'MetaCardPage',
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
                  fit: BoxFit.fill,
                  image: Image.asset(
                    'assets/images/Background.webp',
                  ).image,
                ),
              ),
              child: Align(
                alignment: AlignmentDirectional(0.0, -1.0),
                child: Container(
                  height: double.infinity,
                  constraints: BoxConstraints(
                    maxWidth: 600.0,
                  ),
                  decoration: BoxDecoration(),
                  child: Stack(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1.0, 0.0),
                        child: Builder(
                          builder: (context) {
                            if (_model.step == 1) {
                              return Align(
                                alignment: AlignmentDirectional(0.0, -1.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 0.0, 20.0, 0.0),
                                      child: Text(
                                        'ЗАДАЙ КАРТЕ СВОЙ ВОПРОС',
                                        maxLines: 1,
                                        style: FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineMediumFamily,
                                              fontSize: 20.0,
                                              letterSpacing: 0.0,
                                              lineHeight: 1.4,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .headlineMediumIsCustom,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 0.0, 20.0, 20.0),
                                      child: Text(
                                        'И нажми на нее, чтобы перевернуть',
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .labelLargeFamily,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .labelLargeIsCustom,
                                            ),
                                      ),
                                    ),
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'META_CARD_Image_2z98ln2b_ON_TAP');
                                        logFirebaseEvent(
                                            'Image_update_page_state');
                                        _model.step = 2;
                                        safeSetState(() {});
                                        logFirebaseEvent(
                                            'Image_widget_animation');
                                        if (animationsMap[
                                                'imageOnActionTriggerAnimation1'] !=
                                            null) {
                                          await animationsMap[
                                                  'imageOnActionTriggerAnimation1']!
                                              .controller
                                              .forward(from: 0.0);
                                        }
                                        await Future.wait([
                                          Future(() async {
                                            logFirebaseEvent(
                                                'Image_widget_animation');
                                            if (animationsMap[
                                                    'textOnActionTriggerAnimation1'] !=
                                                null) {
                                              await animationsMap[
                                                      'textOnActionTriggerAnimation1']!
                                                  .controller
                                                  .forward(from: 0.0);
                                            }
                                          }),
                                          Future(() async {
                                            logFirebaseEvent(
                                                'Image_widget_animation');
                                            if (animationsMap[
                                                    'textOnActionTriggerAnimation2'] !=
                                                null) {
                                              await animationsMap[
                                                      'textOnActionTriggerAnimation2']!
                                                  .controller
                                                  .forward(from: 0.0);
                                            }
                                          }),
                                          Future(() async {
                                            logFirebaseEvent(
                                                'Image_widget_animation');
                                            if (animationsMap[
                                                    'imageOnActionTriggerAnimation2'] !=
                                                null) {
                                              await animationsMap[
                                                      'imageOnActionTriggerAnimation2']!
                                                  .controller
                                                  .forward(from: 0.0);
                                            }
                                          }),
                                        ]);
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Image.asset(
                                          'assets/images/cardFront.webp',
                                          width: 270.0,
                                          height: 440.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ).animateOnActionTrigger(
                                      animationsMap[
                                          'imageOnActionTriggerAnimation1']!,
                                    ),
                                  ].addToStart(SizedBox(height: 120.0)),
                                ),
                              );
                            } else if (_model.step == 2) {
                              return Align(
                                alignment: AlignmentDirectional(0.0, -1.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 0.0, 20.0, 0.0),
                                      child: Text(
                                        'ПОСМОТРИ НА КАРТУ',
                                        maxLines: 1,
                                        style: FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineMediumFamily,
                                              fontSize: 20.0,
                                              letterSpacing: 0.0,
                                              lineHeight: 1.4,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .headlineMediumIsCustom,
                                            ),
                                      ).animateOnActionTrigger(
                                        animationsMap[
                                            'textOnActionTriggerAnimation1']!,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 0.0, 20.0, 0.0),
                                      child: Text(
                                        'Что ты чувствуешь прямо сейчас?',
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .labelLargeFamily,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .labelLargeIsCustom,
                                            ),
                                      ).animateOnActionTrigger(
                                        animationsMap[
                                            'textOnActionTriggerAnimation2']!,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 20.0, 0.0, 0.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Image.network(
                                          getCORSProxyUrl(
                                            valueOrDefault<String>(
                                              widget!.metaCard?.image,
                                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/woman-103qa6/assets/cgfk1hn466i4/cardBack.webp',
                                            ),
                                          ),
                                          width: 270.0,
                                          height: 440.0,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Image.asset(
                                            'assets/images/error_image.jpg',
                                            width: 270.0,
                                            height: 440.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ).animateOnActionTrigger(
                                        animationsMap[
                                            'imageOnActionTriggerAnimation2']!,
                                      ),
                                    ),
                                  ].addToStart(SizedBox(height: 120.0)),
                                ),
                              );
                            } else {
                              return Container(
                                width: double.infinity,
                                height: MediaQuery.sizeOf(context).height * 1.0,
                                constraints: BoxConstraints(
                                  minHeight: 200.0,
                                ),
                                decoration: BoxDecoration(),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: CachedNetworkImage(
                                          fadeInDuration:
                                              Duration(milliseconds: 1100),
                                          fadeOutDuration:
                                              Duration(milliseconds: 1100),
                                          imageUrl: getCORSProxyUrl(
                                            valueOrDefault<String>(
                                              widget!.metaCard?.image,
                                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/woman-103qa6/assets/cgfk1hn466i4/cardBack.webp',
                                            ),
                                          ),
                                          width: 180.0,
                                          fit: BoxFit.cover,
                                          errorWidget:
                                              (context, error, stackTrace) =>
                                                  Image.asset(
                                            'assets/images/error_image.jpg',
                                            width: 180.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 24.0, 0.0, 0.0),
                                        child: Text(
                                          valueOrDefault<String>(
                                            widget!.metaCard!.title
                                                .toUpperCase(),
                                            'СОВЕТНИК',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .headlineMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineMediumFamily,
                                                letterSpacing: 0.0,
                                                lineHeight: 1.2,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .headlineMediumIsCustom,
                                              ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 16.0, 20.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Описание',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .titleMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleMediumFamily,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      fontSize: 17.0,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .titleMediumIsCustom,
                                                    ),
                                              ),
                                              Text(
                                                valueOrDefault<String>(
                                                  widget!.metaCard?.description,
                                                  '-',
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleMediumFamily,
                                                          fontSize: 17.0,
                                                          letterSpacing: 0.0,
                                                          lineHeight: 1.4,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleMediumIsCustom,
                                                        ),
                                              ),
                                            ].divide(SizedBox(height: 4.0)),
                                          ),
                                        ),
                                      ),
                                    ]
                                        .addToStart(SizedBox(height: 90.0))
                                        .addToEnd(SizedBox(height: 150.0)),
                                  ),
                                ).animateOnPageLoad(animationsMap[
                                    'columnOnPageLoadAnimation']!),
                              );
                            }
                          },
                        ),
                      ),
                      if (_model.step == 2)
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 16.0, 20.0, 48.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(56.0),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 2.0,
                                sigmaY: 2.0,
                              ),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  logFirebaseEvent(
                                      'META_CARD_PAGE_PAGE_cancelButton_ON_TAP');
                                  logFirebaseEvent(
                                      'cancelButton_update_page_state');
                                  unawaited(
                                    () async {
                                      _model.step = 3;
                                      safeSetState(() {});
                                    }(),
                                  );
                                },
                                text: 'ОТКРЫТЬ ОПИСАНИЕ',
                                icon: Icon(
                                  FFIcons.klock2,
                                  size: 24.0,
                                ),
                                options: FFButtonOptions(
                                  width: 264.0,
                                  height: 56.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  color: FlutterFlowTheme.of(context).white12,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .titleSmallFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 17.0,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .titleSmallIsCustom,
                                      ),
                                  elevation: 0.0,
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).white12,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(56.0),
                                ),
                                showLoadingIndicator: false,
                              ),
                            ),
                          ),
                        ),
                      Align(
                        alignment: AlignmentDirectional(0.0, -1.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(0.0),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 0.0,
                              sigmaY: 0.0,
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 54.0, 0.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  wrapWithModel(
                                    model: _model.backButtonModel1,
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
                                            'META_CARD_Container_r9s1v6iq_CALLBACK');
                                        logFirebaseEvent(
                                            'backButton_navigate_back');
                                        context.safePop();
                                      },
                                    ),
                                  ),
                                  if (_model.step != 1)
                                    Builder(
                                      builder: (context) => Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 12.0, 0.0),
                                        child: wrapWithModel(
                                          model: _model.backButtonModel2,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: BackButtonWidget(
                                            icon: Icon(
                                              FFIcons.kshare2,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 24.0,
                                            ),
                                            action: () async {
                                              logFirebaseEvent(
                                                  'META_CARD_Container_bxs1ub2k_CALLBACK');
                                              logFirebaseEvent(
                                                  'backButton_share');
                                              unawaited(
                                                () async {
                                                  await Share.share(
                                                    'woman://com.appfyl.woman${GoRouterState.of(context).uri.toString()}',
                                                    sharePositionOrigin:
                                                        getWidgetBoundingBox(
                                                            context),
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
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
