import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/loader/loader_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'splash_page_model.dart';
export 'splash_page_model.dart';

class SplashPageWidget extends StatefulWidget {
  const SplashPageWidget({super.key});

  static String routeName = 'splashPage';
  static String routePath = '/splashPage';

  @override
  State<SplashPageWidget> createState() => _SplashPageWidgetState();
}

class _SplashPageWidgetState extends State<SplashPageWidget> {
  late SplashPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SplashPageModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'splashPage'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (RootPageContext.isInactiveRootPage(context)) {
        return;
      }
      logFirebaseEvent('SPLASH_splashPage_ON_INIT_STATE');
      if (isWeb) {
        logFirebaseEvent('splashPage_navigate_to');

        context.goNamed(
          EducationPageWidget.routeName,
          extra: <String, dynamic>{
            '__transition_info__': TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.fade,
              duration: Duration(milliseconds: 0),
            ),
          },
        );
      } else {
        logFirebaseEvent('splashPage_custom_action');
        unawaited(
          () async {
            await actions.setStatusBarColor();
          }(),
        );
        logFirebaseEvent('splashPage_custom_action');
        unawaited(
          () async {
            await actions.lockLandscapeMode();
          }(),
        );
        logFirebaseEvent('splashPage_custom_action');
        _model.versionInfo = await actions.pakageInfo();
        logFirebaseEvent('splashPage_update_app_state');
        FFAppState().version = _model.versionInfo!;
        FFAppState().refreshDate = getCurrentTimestamp;
        FFAppState().update(() {});
        logFirebaseEvent('splashPage_wait__delay');
        await Future.delayed(
          Duration(
            milliseconds: 1500,
          ),
        );
        logFirebaseEvent('splashPage_navigate_to');

        context.goNamed(
          HomePageWidget.routeName,
          extra: <String, dynamic>{
            '__transition_info__': TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.fade,
              duration: Duration(milliseconds: 0),
            ),
          },
        );
      }

      logFirebaseEvent('splashPage_clear_query_cache');
      FFAppState().clearNewsCache();
      logFirebaseEvent('splashPage_clear_query_cache');
      FFAppState().clearVideosCache();
      logFirebaseEvent('splashPage_custom_action');
      unawaited(
        () async {
          await actions.refreshFirebaseRemoteConfig();
        }(),
      );
      logFirebaseEvent('splashPage_backend_call');
      unawaited(
        () async {
          await currentUserReference!.update(createUsersRecordData(
            lastLoginAt: getCurrentTimestamp,
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
    context.watch<FFAppState>();

    return Title(
        title: 'splashPage',
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
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 1.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.asset(
                      'assets/images/Background.webp',
                    ).image,
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 48.0, 16.0, 34.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: 600.0,
                          ),
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                valueOrDefault<String>(
                                  functions.dateTextNow(),
                                  'ДОБРОЕ УТРО',
                                ).toUpperCase(),
                                style: FlutterFlowTheme.of(context)
                                    .headlineLarge
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .headlineLargeFamily,
                                      letterSpacing: 0.0,
                                      lineHeight: 1.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .headlineLargeIsCustom,
                                    ),
                              ),
                              Text(
                                'Счастливого пути домой, \nпрекрасная женщина',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyLargeFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 17.0,
                                      letterSpacing: 0.0,
                                      lineHeight: 1.4,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .bodyLargeIsCustom,
                                    ),
                              ),
                            ].divide(SizedBox(height: 8.0)),
                          ),
                        ),
                      ),
                      wrapWithModel(
                        model: _model.loaderModel,
                        updateCallback: () => safeSetState(() {}),
                        child: LoaderWidget(),
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
