import '/auth/firebase_auth/auth_util.dart';
import '/components/back_button/back_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/web/navbar_web/navbar_web_widget.dart';
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
import 'edit_password_model.dart';
export 'edit_password_model.dart';

class EditPasswordWidget extends StatefulWidget {
  const EditPasswordWidget({super.key});

  static String routeName = 'editPassword';
  static String routePath = '/editPassword';

  @override
  State<EditPasswordWidget> createState() => _EditPasswordWidgetState();
}

class _EditPasswordWidgetState extends State<EditPasswordWidget> {
  late EditPasswordModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditPasswordModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'editPassword'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('EDIT_PASSWORD_editPassword_ON_INIT_STATE');
      logFirebaseEvent('editPassword_custom_action');
      unawaited(
        () async {
          await actions.setStatusBarColor();
        }(),
      );
    });

    _model.passwordTextController ??= TextEditingController();
    _model.passwordFocusNode ??= FocusNode();
    _model.passwordFocusNode!.addListener(() => safeSetState(() {}));
    _model.passwordConfirmTextController ??= TextEditingController();
    _model.passwordConfirmFocusNode ??= FocusNode();
    _model.passwordConfirmFocusNode!.addListener(() => safeSetState(() {}));
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
        title: 'editPassword',
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
                          EdgeInsetsDirectional.fromSTEB(0.0, 54.0, 0.0, 0.0),
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
                                      'EDIT_PASSWORD_Container_feqdd8ym_CALLBAC');
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
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 16.0, 0.0, 16.0),
                                          child: Text(
                                            'ИЗМЕНИТЬ ПАРОЛЬ',
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
                                      Form(
                                        key: _model.formKey,
                                        autovalidateMode:
                                            AutovalidateMode.disabled,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 8.0, 0.0, 8.0),
                                              child: Container(
                                                constraints: BoxConstraints(
                                                  minHeight: 56.0,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .white12,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                  border: Border.all(
                                                    color:
                                                        valueOrDefault<Color>(
                                                      (_model.passwordFocusNode
                                                                  ?.hasFocus ??
                                                              false)
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .border
                                                          : Colors.transparent,
                                                      Colors.transparent,
                                                    ),
                                                  ),
                                                ),
                                                child: Container(
                                                  width: double.infinity,
                                                  child: TextFormField(
                                                    controller: _model
                                                        .passwordTextController,
                                                    focusNode: _model
                                                        .passwordFocusNode,
                                                    onChanged: (_) =>
                                                        EasyDebounce.debounce(
                                                      '_model.passwordTextController',
                                                      Duration(
                                                          milliseconds: 50),
                                                      () => safeSetState(() {}),
                                                    ),
                                                    autofocus: false,
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    obscureText: !_model
                                                        .passwordVisibility,
                                                    decoration: InputDecoration(
                                                      isDense: false,
                                                      labelText: 'Новый пароль',
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelLarge
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLargeFamily,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelLargeIsCustom,
                                                              ),
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      focusedErrorBorder:
                                                          InputBorder.none,
                                                      contentPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  16.0,
                                                                  12.0,
                                                                  16.0,
                                                                  8.0),
                                                      suffixIcon: InkWell(
                                                        onTap: () async {
                                                          safeSetState(() => _model
                                                                  .passwordVisibility =
                                                              !_model
                                                                  .passwordVisibility);
                                                        },
                                                        focusNode: FocusNode(
                                                            skipTraversal:
                                                                true),
                                                        child: Icon(
                                                          _model.passwordVisibility
                                                              ? Icons
                                                                  .visibility_outlined
                                                              : Icons
                                                                  .visibility_off_outlined,
                                                          color: Colors
                                                              .transparent,
                                                          size: 22,
                                                        ),
                                                      ),
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelLarge
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLargeFamily,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelLargeIsCustom,
                                                        ),
                                                    maxLength: 50,
                                                    maxLengthEnforcement:
                                                        MaxLengthEnforcement
                                                            .none,
                                                    buildCounter: (context,
                                                            {required currentLength,
                                                            required isFocused,
                                                            maxLength}) =>
                                                        null,
                                                    keyboardType: TextInputType
                                                        .visiblePassword,
                                                    cursorColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                    enableInteractiveSelection:
                                                        true,
                                                    validator: _model
                                                        .passwordTextControllerValidator
                                                        .asValidator(context),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 8.0, 0.0, 8.0),
                                              child: Container(
                                                constraints: BoxConstraints(
                                                  minHeight: 56.0,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .white12,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                  border: Border.all(
                                                    color:
                                                        valueOrDefault<Color>(
                                                      (_model.passwordConfirmFocusNode
                                                                  ?.hasFocus ??
                                                              false)
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .border
                                                          : Colors.transparent,
                                                      Colors.transparent,
                                                    ),
                                                  ),
                                                ),
                                                child: Container(
                                                  width: double.infinity,
                                                  child: TextFormField(
                                                    controller: _model
                                                        .passwordConfirmTextController,
                                                    focusNode: _model
                                                        .passwordConfirmFocusNode,
                                                    onChanged: (_) =>
                                                        EasyDebounce.debounce(
                                                      '_model.passwordConfirmTextController',
                                                      Duration(
                                                          milliseconds: 50),
                                                      () => safeSetState(() {}),
                                                    ),
                                                    autofocus: false,
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    obscureText: !_model
                                                        .passwordConfirmVisibility,
                                                    decoration: InputDecoration(
                                                      isDense: false,
                                                      labelText:
                                                          'Повторите новый пароль',
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelLarge
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLargeFamily,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelLargeIsCustom,
                                                              ),
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      focusedErrorBorder:
                                                          InputBorder.none,
                                                      contentPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  16.0,
                                                                  12.0,
                                                                  16.0,
                                                                  8.0),
                                                      suffixIcon: InkWell(
                                                        onTap: () async {
                                                          safeSetState(() => _model
                                                                  .passwordConfirmVisibility =
                                                              !_model
                                                                  .passwordConfirmVisibility);
                                                        },
                                                        focusNode: FocusNode(
                                                            skipTraversal:
                                                                true),
                                                        child: Icon(
                                                          _model.passwordConfirmVisibility
                                                              ? Icons
                                                                  .visibility_outlined
                                                              : Icons
                                                                  .visibility_off_outlined,
                                                          color: Colors
                                                              .transparent,
                                                          size: 22,
                                                        ),
                                                      ),
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelLarge
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLargeFamily,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelLargeIsCustom,
                                                        ),
                                                    maxLength: 50,
                                                    maxLengthEnforcement:
                                                        MaxLengthEnforcement
                                                            .none,
                                                    buildCounter: (context,
                                                            {required currentLength,
                                                            required isFocused,
                                                            maxLength}) =>
                                                        null,
                                                    keyboardType: TextInputType
                                                        .visiblePassword,
                                                    cursorColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                    enableInteractiveSelection:
                                                        true,
                                                    validator: _model
                                                        .passwordConfirmTextControllerValidator
                                                        .asValidator(context),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 12.0, 0.0, 12.0),
                                        child: FFButtonWidget(
                                          onPressed: ((_model
                                                              .passwordTextController
                                                              .text ==
                                                          null ||
                                                      _model.passwordTextController
                                                              .text ==
                                                          '') ||
                                                  (_model.passwordConfirmTextController
                                                              .text ==
                                                          null ||
                                                      _model.passwordConfirmTextController
                                                              .text ==
                                                          '') ||
                                                  (_model.passwordTextController
                                                          .text !=
                                                      _model
                                                          .passwordConfirmTextController
                                                          .text))
                                              ? null
                                              : () async {
                                                  logFirebaseEvent(
                                                      'EDIT_PASSWORD_PAGE___BTN_ON_TAP');
                                                  logFirebaseEvent(
                                                      'Button_haptic_feedback');
                                                  HapticFeedback.mediumImpact();
                                                  logFirebaseEvent(
                                                      'Button_validate_form');
                                                  if (_model.formKey
                                                              .currentState ==
                                                          null ||
                                                      !_model
                                                          .formKey.currentState!
                                                          .validate()) {
                                                    return;
                                                  }
                                                  logFirebaseEvent(
                                                      'Button_auth');
                                                  await authManager
                                                      .updatePassword(
                                                    newPassword: _model
                                                        .passwordTextController
                                                        .text,
                                                    context: context,
                                                  );
                                                  safeSetState(() {});

                                                  if (isWeb) {
                                                    logFirebaseEvent(
                                                        'Button_navigate_to');
                                                    if (Navigator.of(context)
                                                        .canPop()) {
                                                      context.pop();
                                                    }
                                                    context.pushNamedAuth(
                                                      EditPasswordSuccessWidget
                                                          .routeName,
                                                      context.mounted,
                                                      extra: <String, dynamic>{
                                                        '__transition_info__':
                                                            TransitionInfo(
                                                          hasTransition: true,
                                                          transitionType:
                                                              PageTransitionType
                                                                  .fade,
                                                          duration: Duration(
                                                              milliseconds: 0),
                                                        ),
                                                      },
                                                    );
                                                  } else {
                                                    logFirebaseEvent(
                                                        'Button_navigate_to');
                                                    if (Navigator.of(context)
                                                        .canPop()) {
                                                      context.pop();
                                                    }
                                                    context.pushNamedAuth(
                                                        EditPasswordSuccessWidget
                                                            .routeName,
                                                        context.mounted);
                                                  }
                                                },
                                          text: 'ИЗМЕНИТЬ ПАРОЛЬ',
                                          options: FFButtonOptions(
                                            width: double.infinity,
                                            height: 56.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmallFamily,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      fontSize: 17.0,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmallIsCustom,
                                                    ),
                                            elevation: 0.0,
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(56.0),
                                            disabledColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryBG40,
                                            disabledTextColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryText,
                                          ),
                                          showLoadingIndicator: false,
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
                ],
              ),
            ),
          ),
        ));
  }
}
