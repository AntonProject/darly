import '/auth/firebase_auth/auth_util.dart';
import '/components/back_button/back_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'reset_password_model.dart';
export 'reset_password_model.dart';

class ResetPasswordWidget extends StatefulWidget {
  const ResetPasswordWidget({super.key});

  static String routeName = 'ResetPassword';
  static String routePath = '/resetPassword';

  @override
  State<ResetPasswordWidget> createState() => _ResetPasswordWidgetState();
}

class _ResetPasswordWidgetState extends State<ResetPasswordWidget> {
  late ResetPasswordModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ResetPasswordModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'ResetPassword'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('RESET_PASSWORD_ResetPassword_ON_INIT_STA');
      logFirebaseEvent('ResetPassword_custom_action');
      unawaited(
        () async {
          await actions.setStatusBarColor();
        }(),
      );
    });

    _model.emailTextController ??= TextEditingController();
    _model.emailFocusNode ??= FocusNode();
    _model.emailFocusNode!.addListener(() => safeSetState(() {}));
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
        title: 'ResetPassword',
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
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 54.0, 0.0, 0.0),
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
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                          action: () async {
                            logFirebaseEvent(
                                'RESET_PASSWORD_Container_vx40jnxm_CALLBA');
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
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 16.0, 0.0, 0.0),
                                    child: Text(
                                      'ВОССТАНОВИТЬ ПАРОЛЬ',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .headlineMediumFamily,
                                            letterSpacing: 0.0,
                                            lineHeight: 1.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .headlineMediumIsCustom,
                                          ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 8.0, 0.0, 16.0),
                                  child: Text(
                                    'Перейди по ссылке в письме и введи новый пароль',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .labelLargeFamily,
                                          letterSpacing: 0.0,
                                          lineHeight: 1.4,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .labelLargeIsCustom,
                                        ),
                                  ),
                                ),
                                Form(
                                  key: _model.formKey,
                                  autovalidateMode: AutovalidateMode.disabled,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 8.0, 0.0, 8.0),
                                    child: Container(
                                      constraints: BoxConstraints(
                                        minHeight: 56.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .white12,
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        border: Border.all(
                                          color: valueOrDefault<Color>(
                                            (_model.emailFocusNode?.hasFocus ??
                                                    false)
                                                ? FlutterFlowTheme.of(context)
                                                    .border
                                                : Colors.transparent,
                                            Colors.transparent,
                                          ),
                                        ),
                                      ),
                                      child: Stack(
                                        alignment:
                                            AlignmentDirectional(1.0, 0.0),
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                              controller:
                                                  _model.emailTextController,
                                              focusNode: _model.emailFocusNode,
                                              onChanged: (_) =>
                                                  EasyDebounce.debounce(
                                                '_model.emailTextController',
                                                Duration(milliseconds: 50),
                                                () => safeSetState(() {}),
                                              ),
                                              autofocus: false,
                                              textInputAction:
                                                  TextInputAction.done,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                isDense: false,
                                                labelText: 'Email',
                                                labelStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLargeFamily,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelLargeIsCustom,
                                                        ),
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                focusedErrorBorder:
                                                    InputBorder.none,
                                                contentPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(16.0, 12.0,
                                                            40.0, 8.0),
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelLarge
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelLargeFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .labelLargeIsCustom,
                                                  ),
                                              maxLength: 50,
                                              maxLengthEnforcement:
                                                  MaxLengthEnforcement.none,
                                              buildCounter: (context,
                                                      {required currentLength,
                                                      required isFocused,
                                                      maxLength}) =>
                                                  null,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              cursorColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              enableInteractiveSelection: true,
                                              validator: _model
                                                  .emailTextControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                          if (_model.emailTextController.text !=
                                                  null &&
                                              _model.emailTextController.text !=
                                                  '')
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 16.0, 0.0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  logFirebaseEvent(
                                                      'RESET_PASSWORD_PAGE_Icon_rvxfsimz_ON_TAP');
                                                  logFirebaseEvent(
                                                      'Icon_clear_text_fields_pin_codes');
                                                  safeSetState(() {
                                                    _model.emailTextController
                                                        ?.clear();
                                                  });
                                                },
                                                child: Icon(
                                                  FFIcons.kcloseIcon,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  size: 24.0,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 12.0, 0.0, 12.0),
                                  child: FFButtonWidget(
                                    onPressed: (_model
                                                    .emailTextController.text ==
                                                null ||
                                            _model.emailTextController.text ==
                                                '')
                                        ? null
                                        : () async {
                                            logFirebaseEvent(
                                                'RESET_PASSWORD_PAGE__BTN_ON_TAP');
                                            logFirebaseEvent(
                                                'Button_haptic_feedback');
                                            HapticFeedback.mediumImpact();
                                            logFirebaseEvent(
                                                'Button_validate_form');
                                            if (_model.formKey.currentState ==
                                                    null ||
                                                !_model.formKey.currentState!
                                                    .validate()) {
                                              return;
                                            }
                                            logFirebaseEvent('Button_auth');
                                            if (_model.emailTextController.text
                                                .isEmpty) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Требуется адрес электронной почты!',
                                                  ),
                                                ),
                                              );
                                              return;
                                            }
                                            await authManager.resetPassword(
                                              email: _model
                                                  .emailTextController.text,
                                              context: context,
                                            );
                                            logFirebaseEvent(
                                                'Button_navigate_to');
                                            if (Navigator.of(context)
                                                .canPop()) {
                                              context.pop();
                                            }
                                            context.pushNamed(
                                              ResetPasswordEmailSentWidget
                                                  .routeName,
                                              queryParameters: {
                                                'email': serializeParam(
                                                  _model
                                                      .emailTextController.text,
                                                  ParamType.String,
                                                ),
                                              }.withoutNulls,
                                            );
                                          },
                                    text: 'ОТПРАВИТЬ',
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 56.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
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
                                        color: FlutterFlowTheme.of(context)
                                            .white12,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(56.0),
                                      disabledColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBG40,
                                      disabledTextColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryText,
                                    ),
                                  ),
                                ),
                              ].addToEnd(SizedBox(height: 34.0)),
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
        ));
  }
}
