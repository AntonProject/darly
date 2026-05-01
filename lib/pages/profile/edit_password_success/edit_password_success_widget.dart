import '/components/support_button/support_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/web/navbar_web/navbar_web_widget.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'edit_password_success_model.dart';
export 'edit_password_success_model.dart';

class EditPasswordSuccessWidget extends StatefulWidget {
  const EditPasswordSuccessWidget({super.key});

  static String routeName = 'editPasswordSuccess';
  static String routePath = '/editPasswordSuccess';

  @override
  State<EditPasswordSuccessWidget> createState() =>
      _EditPasswordSuccessWidgetState();
}

class _EditPasswordSuccessWidgetState extends State<EditPasswordSuccessWidget> {
  late EditPasswordSuccessModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditPasswordSuccessModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'editPasswordSuccess'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('EDIT_PASSWORD_SUCCESS_editPasswordSucces');
      logFirebaseEvent('editPasswordSuccess_custom_action');
      unawaited(
        () async {
          await actions.setStatusBarColor();
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
        title: 'editPasswordSuccess',
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
                    child: Container(
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 54.0, 0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(1.0, 0.0),
                              child: wrapWithModel(
                                model: _model.supportButtonModel,
                                updateCallback: () => safeSetState(() {}),
                                child: SupportButtonWidget(),
                              ),
                            ),
                            Expanded(
                              child: Stack(
                                alignment: AlignmentDirectional(0.0, 1.0),
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/Frame_881234027.webp',
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.6,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 0.0, 20.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          'ПАРОЛЬ ОБНОВЛЕН!',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .headlineMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineMediumFamily,
                                                fontSize: 24.0,
                                                letterSpacing: 0.0,
                                                lineHeight: 1.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .headlineMediumIsCustom,
                                              ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 8.0, 0.0, 36.0),
                                          child: Text(
                                            'Теперь твой аккаунт защищен еще лучше',
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.of(context)
                                                .labelLarge
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLargeFamily,
                                                  letterSpacing: 0.0,
                                                  lineHeight: 1.4,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .labelLargeIsCustom,
                                                ),
                                          ),
                                        ),
                                      ].addToEnd(SizedBox(height: 40.0)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: 600.0,
                              ),
                              decoration: BoxDecoration(),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 12.0, 20.0, 12.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    logFirebaseEvent(
                                        'EDIT_PASSWORD_SUCCESS_PAGE__BTN_ON_TAP');
                                    logFirebaseEvent('Button_haptic_feedback');
                                    HapticFeedback.mediumImpact();
                                    logFirebaseEvent('Button_navigate_back');
                                    context.safePop();
                                  },
                                  text: 'ОТЛИЧНО',
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 56.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
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
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(56.0),
                                  ),
                                  showLoadingIndicator: false,
                                ),
                              ),
                            ),
                          ].addToEnd(SizedBox(height: 34.0)),
                        ),
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
