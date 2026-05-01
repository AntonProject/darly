import '/components/nav_tab/nav_tab_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'navbar_model.dart';
export 'navbar_model.dart';

class NavbarWidget extends StatefulWidget {
  const NavbarWidget({
    super.key,
    double? pageNum,
  }) : this.pageNum = pageNum ?? 1.0;

  final double pageNum;

  @override
  State<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {
  late NavbarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NavbarModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
          16.0,
          0.0,
          16.0,
          valueOrDefault<double>(
            isAndroid ? 54.0 : 34.0,
            34.0,
          )),
      child: Container(
        width: double.infinity,
        height: 64.0,
        child: custom_widgets.LiquidGlassNavBar(
          width: double.infinity,
          height: 64.0,
          pageNum: widget!.pageNum,
          onHomeTabTap: () async {
            logFirebaseEvent('NAVBAR_COMP_Container_gmgc9nhn_CALLBACK');
            logFirebaseEvent('LiquidGlassNavBar_haptic_feedback');
            HapticFeedback.mediumImpact();
            if (widget!.pageNum != 1.0) {
              logFirebaseEvent('LiquidGlassNavBar_navigate_to');

              context.pushNamed(
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
            logFirebaseEvent('LiquidGlassNavBar_custom_action');
            unawaited(
              () async {
                await actions.closeKeyboard(
                  context,
                );
              }(),
            );
          },
          onEducationTabTap: () async {
            logFirebaseEvent('NAVBAR_COMP_Container_gmgc9nhn_CALLBACK');
            logFirebaseEvent('LiquidGlassNavBar_haptic_feedback');
            HapticFeedback.mediumImpact();
            if (widget!.pageNum != 2.0) {
              logFirebaseEvent('LiquidGlassNavBar_navigate_to');

              context.pushNamed(
                EducationPageWidget.routeName,
                extra: <String, dynamic>{
                  '__transition_info__': TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.fade,
                    duration: Duration(milliseconds: 0),
                  ),
                },
              );
            }
            logFirebaseEvent('LiquidGlassNavBar_custom_action');
            unawaited(
              () async {
                await actions.closeKeyboard(
                  context,
                );
              }(),
            );
          },
          onChatTabTap: () async {
            logFirebaseEvent('NAVBAR_COMP_Container_gmgc9nhn_CALLBACK');
            logFirebaseEvent('LiquidGlassNavBar_haptic_feedback');
            HapticFeedback.mediumImpact();
            if (widget!.pageNum != 3.0) {
              logFirebaseEvent('LiquidGlassNavBar_update_app_state');
              FFAppState().chatRef = null;
              _model.updatePage(() {});
              logFirebaseEvent('LiquidGlassNavBar_navigate_to');

              context.pushNamed(
                ChatPageWidget.routeName,
                queryParameters: {
                  'chat': serializeParam(
                    FFAppState().chatRef,
                    ParamType.DocumentReference,
                  ),
                }.withoutNulls,
                extra: <String, dynamic>{
                  '__transition_info__': TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.fade,
                    duration: Duration(milliseconds: 0),
                  ),
                },
              );
            }
            logFirebaseEvent('LiquidGlassNavBar_custom_action');
            unawaited(
              () async {
                await actions.closeKeyboard(
                  context,
                );
              }(),
            );
          },
          onAudioTabTap: () async {
            logFirebaseEvent('NAVBAR_COMP_Container_gmgc9nhn_CALLBACK');
            logFirebaseEvent('LiquidGlassNavBar_haptic_feedback');
            HapticFeedback.mediumImpact();
            if (widget!.pageNum != 4.0) {
              logFirebaseEvent('LiquidGlassNavBar_navigate_to');

              context.pushNamed(
                AudioPageWidget.routeName,
                extra: <String, dynamic>{
                  '__transition_info__': TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.fade,
                    duration: Duration(milliseconds: 0),
                  ),
                },
              );
            }
          },
          onProfileTabTap: () async {
            logFirebaseEvent('NAVBAR_COMP_Container_gmgc9nhn_CALLBACK');
            logFirebaseEvent('LiquidGlassNavBar_haptic_feedback');
            HapticFeedback.mediumImpact();
            if (widget!.pageNum != 5.0) {
              logFirebaseEvent('LiquidGlassNavBar_navigate_to');

              context.pushNamed(
                ProfilePageWidget.routeName,
                extra: <String, dynamic>{
                  '__transition_info__': TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.fade,
                    duration: Duration(milliseconds: 0),
                  ),
                },
              );
            }
            logFirebaseEvent('LiquidGlassNavBar_custom_action');
            unawaited(
              () async {
                await actions.closeKeyboard(
                  context,
                );
              }(),
            );
          },
          homeTab: () => NavTabWidget(
            tab: widget!.pageNum,
            icon: Icon(
              FFIcons.khomeOn,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 28.0,
            ),
            text: 'Главная',
          ),
          educationTab: () => NavTabWidget(
            tab: widget!.pageNum,
            icon: Icon(
              FFIcons.klessonOn,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 28.0,
            ),
            text: 'Обучение',
          ),
          chatTab: () => NavTabWidget(
            tab: widget!.pageNum,
            icon: Icon(
              FFIcons.kchatIcon,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 28.0,
            ),
            text: 'Чат',
          ),
          audioTab: () => NavTabWidget(
            tab: widget!.pageNum,
            icon: Icon(
              FFIcons.kheadphonesOn,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 28.0,
            ),
            text: 'Слушать',
          ),
          profileTab: () => NavTabWidget(
            tab: widget!.pageNum,
            icon: Icon(
              FFIcons.kuserOn,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 28.0,
            ),
            text: 'Профиль',
          ),
        ),
      ),
    );
  }
}
