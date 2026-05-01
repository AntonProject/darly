import '/components/back_button/back_button_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/web/navbar_web/navbar_web_widget.dart';
import 'dart:async';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'about_app_page_model.dart';
export 'about_app_page_model.dart';

class AboutAppPageWidget extends StatefulWidget {
  const AboutAppPageWidget({super.key});

  static String routeName = 'aboutAppPage';
  static String routePath = '/aboutAppPage';

  @override
  State<AboutAppPageWidget> createState() => _AboutAppPageWidgetState();
}

class _AboutAppPageWidgetState extends State<AboutAppPageWidget>
    with TickerProviderStateMixin {
  late AboutAppPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AboutAppPageModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'aboutAppPage'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('ABOUT_APP_aboutAppPage_ON_INIT_STATE');
      logFirebaseEvent('aboutAppPage_custom_action');
      unawaited(
        () async {
          await actions.setStatusBarColor();
        }(),
      );
      logFirebaseEvent('aboutAppPage_custom_action');
      unawaited(
        () async {
          await actions.lockLandscapeMode();
        }(),
      );
      logFirebaseEvent('aboutAppPage_custom_action');
      _model.version = await actions.pakageInfo();
      logFirebaseEvent('aboutAppPage_update_app_state');
      FFAppState().version = _model.version!;
      safeSetState(() {});
    });

    animationsMap.addAll({
      'imageOnPageLoadAnimation': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 500.0.ms,
            duration: 800.0.ms,
            color: FlutterFlowTheme.of(context).info,
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
    context.watch<FFAppState>();

    return Title(
        title: 'aboutAppPage',
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
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (isWeb &&
                      responsiveVisibility(
                        context: context,
                        phone: false,
                        tablet: false,
                      ))
                    wrapWithModel(
                      model: _model.navbarWebModel,
                      updateCallback: () => safeSetState(() {}),
                      updateOnChange: true,
                      child: NavbarWebWidget(
                        pageNum: 0.0,
                      ),
                    ),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 54.0, 0.0, 48.0),
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
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                action: () async {
                                  logFirebaseEvent(
                                      'ABOUT_APP_Container_p692y4if_CALLBACK');
                                  logFirebaseEvent('backButton_navigate_back');
                                  context.safePop();
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: 600.0,
                              ),
                              decoration: BoxDecoration(),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 8.0, 20.0, 0.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 16.0, 0.0, 16.0),
                                          child: Text(
                                            'О ПРИЛОЖЕНИИ',
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.of(context)
                                                .headlineLarge
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineLargeFamily,
                                                  letterSpacing: 0.0,
                                                  lineHeight: 1.0,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .headlineLargeIsCustom,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 12.0, 0.0, 0.0),
                                        child: Text(
                                          'Версия',
                                          style: FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMediumFamily,
                                                letterSpacing: 0.0,
                                                lineHeight: 1.2,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .labelMediumIsCustom,
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 2.0, 0.0, 0.0),
                                        child: Text(
                                          valueOrDefault<String>(
                                            FFAppState().version,
                                            '1.0.1',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLargeFamily,
                                                fontSize: 17.0,
                                                letterSpacing: 0.0,
                                                lineHeight: 1.4,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyLargeIsCustom,
                                              ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 16.0, 0.0, 0.0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              logFirebaseEvent(
                                                  'ABOUT_APP_PAGE_PAGE_terms_ON_TAP');
                                              logFirebaseEvent(
                                                  'terms_haptic_feedback');
                                              HapticFeedback.lightImpact();
                                              logFirebaseEvent(
                                                  'terms_launch_u_r_l');
                                              unawaited(
                                                () async {
                                                  await launchURL(
                                                      getRemoteConfigString(
                                                          'terms'));
                                                }(),
                                              );
                                            },
                                            text:
                                                'Политика обработки персональных данных',
                                            options: FFButtonOptions(
                                              padding: EdgeInsets.all(0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color: Colors.transparent,
                                              textStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyLarge
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyLargeFamily,
                                                    fontSize: 17.0,
                                                    letterSpacing: 0.0,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    lineHeight: 1.2,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodyLargeIsCustom,
                                                  ),
                                              elevation: 0.0,
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(0.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 16.0, 0.0, 0.0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              logFirebaseEvent(
                                                  'ABOUT_APP_PAGE_PAGE_userAgreement_ON_TAP');
                                              logFirebaseEvent(
                                                  'userAgreement_haptic_feedback');
                                              HapticFeedback.lightImpact();
                                              logFirebaseEvent(
                                                  'userAgreement_launch_u_r_l');
                                              unawaited(
                                                () async {
                                                  await launchURL(
                                                      getRemoteConfigString(
                                                          'userAgreement'));
                                                }(),
                                              );
                                            },
                                            text: 'Пользовательское соглашение',
                                            options: FFButtonOptions(
                                              padding: EdgeInsets.all(0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color: Colors.transparent,
                                              textStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyLarge
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyLargeFamily,
                                                    fontSize: 17.0,
                                                    letterSpacing: 0.0,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    lineHeight: 1.2,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodyLargeIsCustom,
                                                  ),
                                              elevation: 0.0,
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(0.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ].addToEnd(SizedBox(height: 34.0)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 16.0, 0.0, 8.0),
                            child: Text(
                              'разработано в',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    color: FlutterFlowTheme.of(context)
                                        .customColor1,
                                    letterSpacing: 0.0,
                                    lineHeight: 1.25,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .bodyMediumIsCustom,
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
                                  'ABOUT_APP_Image_0vfejxu2_ON_TAP');
                              logFirebaseEvent('Image_haptic_feedback');
                              HapticFeedback.lightImpact();
                              logFirebaseEvent('Image_launch_u_r_l');
                              unawaited(
                                () async {
                                  await launchURL(FFAppConstants.appfyl);
                                }(),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0.0),
                              child: Image.asset(
                                'assets/images/Footer_Logo.png',
                                height: 24.0,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ).animateOnPageLoad(
                              animationsMap['imageOnPageLoadAnimation']!),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
