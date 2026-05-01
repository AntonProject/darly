import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/back_button/back_button_widget.dart';
import '/components/dialogs/country_dialog/country_dialog_widget.dart';
import '/components/dialogs/photo_upload_dialog/photo_upload_dialog_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/profile/delete_acc_dialog/delete_acc_dialog_widget.dart';
import '/pages/profile/logout_dialog/logout_dialog_widget.dart';
import '/web/navbar_web/navbar_web_widget.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'profile_edit_page_model.dart';
export 'profile_edit_page_model.dart';

class ProfileEditPageWidget extends StatefulWidget {
  const ProfileEditPageWidget({super.key});

  static String routeName = 'ProfileEditPage';
  static String routePath = '/profileEditPage';

  @override
  State<ProfileEditPageWidget> createState() => _ProfileEditPageWidgetState();
}

class _ProfileEditPageWidgetState extends State<ProfileEditPageWidget> {
  late ProfileEditPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileEditPageModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'ProfileEditPage'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('PROFILE_EDIT_ProfileEditPage_ON_INIT_STA');
      await Future.wait([
        Future(() async {
          if (currentUserPhoto != null && currentUserPhoto != '') {
            logFirebaseEvent('ProfileEditPage_update_page_state');
            _model.photo = currentUserPhoto;
            safeSetState(() {});
          }
        }),
        Future(() async {
          if (currentUserDocument?.birthDay != null) {
            logFirebaseEvent('ProfileEditPage_update_page_state');
            _model.date = currentUserDocument?.birthDay;
            safeSetState(() {});
          }
        }),
        Future(() async {
          if (valueOrDefault(currentUserDocument?.country, '') != null &&
              valueOrDefault(currentUserDocument?.country, '') != '') {
            logFirebaseEvent('ProfileEditPage_update_page_state');
            _model.countryState =
                valueOrDefault(currentUserDocument?.country, '');
            _model.countryCodeState =
                valueOrDefault(currentUserDocument?.countryCode, '');
            safeSetState(() {});
          }
        }),
      ]);
      logFirebaseEvent('ProfileEditPage_custom_action');
      unawaited(
        () async {
          await actions.setStatusBarColor();
        }(),
      );
    });

    _model.emailTextController ??=
        TextEditingController(text: currentUserEmail);
    _model.emailFocusNode ??= FocusNode();

    _model.nameTextController ??=
        TextEditingController(text: currentUserDisplayName);
    _model.nameFocusNode ??= FocusNode();
    _model.nameFocusNode!.addListener(() => safeSetState(() {}));
    _model.surnameTextController ??= TextEditingController(
        text: valueOrDefault(currentUserDocument?.surname, ''));
    _model.surnameFocusNode ??= FocusNode();
    _model.surnameFocusNode!.addListener(() => safeSetState(() {}));
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
        title: 'ProfileEditPage',
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
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(-1.0, 0.0),
                                child: wrapWithModel(
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
                                          'PROFILE_EDIT_Container_5mm5qemv_CALLBACK');
                                      logFirebaseEvent(
                                          'backButton_navigate_back');
                                      context.safePop();
                                    },
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-1.0, 0.0),
                                child: Builder(
                                  builder: (context) => Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 12.0, 0.0),
                                    child: wrapWithModel(
                                      model: _model.backButtonModel2,
                                      updateCallback: () => safeSetState(() {}),
                                      child: BackButtonWidget(
                                        icon: Icon(
                                          FFIcons.klogout,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 24.0,
                                        ),
                                        action: () async {
                                          logFirebaseEvent(
                                              'PROFILE_EDIT_Container_7r9ct6p1_CALLBACK');
                                          logFirebaseEvent(
                                              'backButton_alert_dialog');
                                          await showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: AlignmentDirectional(
                                                        0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                                child: WebViewAware(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      FocusScope.of(
                                                              dialogContext)
                                                          .unfocus();
                                                      FocusManager
                                                          .instance.primaryFocus
                                                          ?.unfocus();
                                                    },
                                                    child: LogoutDialogWidget(),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: 600.0,
                              ),
                              decoration: BoxDecoration(),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 20.0, 0.0),
                                child: SingleChildScrollView(
                                  controller: _model.columnController,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 16.0, 0.0, 16.0),
                                          child: Text(
                                            'ИЗМЕНИТЬ ПРОФИЛЬ',
                                            maxLines: 1,
                                            style: FlutterFlowTheme.of(context)
                                                .headlineMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineMediumFamily,
                                                  letterSpacing: 0.0,
                                                  lineHeight: 1.0,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .headlineMediumIsCustom,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 16.0, 0.0, 16.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 120.0,
                                              height: 120.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .white12,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .white12,
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: Builder(
                                                builder: (context) {
                                                  if (_model.photo != null &&
                                                      _model.photo != '') {
                                                    return Container(
                                                      width: 120.0,
                                                      height: 120.0,
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.network(
                                                        getCORSProxyUrl(
                                                          _model.photo!,
                                                        ),
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (context,
                                                                error,
                                                                stackTrace) =>
                                                            Image.asset(
                                                          'assets/images/error_image.jpg',
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    return Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: Text(
                                                        valueOrDefault<String>(
                                                          functions.nameLettters(
                                                              _model
                                                                  .nameTextController
                                                                  .text,
                                                              _model
                                                                  .surnameTextController
                                                                  .text),
                                                          'WN',
                                                        ),
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .headlineLarge
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineLargeFamily,
                                                              letterSpacing:
                                                                  0.0,
                                                              lineHeight: 1.0,
                                                              useGoogleFonts:
                                                                  !FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineLargeIsCustom,
                                                            ),
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                FFButtonWidget(
                                                  onPressed: () async {
                                                    logFirebaseEvent(
                                                        'PROFILE_EDIT_PAGE_PAGE_editButton_ON_TAP');
                                                    logFirebaseEvent(
                                                        'editButton_bottom_sheet');
                                                    await showModalBottomSheet(
                                                      isScrollControlled: true,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      useSafeArea: true,
                                                      context: context,
                                                      builder: (context) {
                                                        return WebViewAware(
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              FocusScope.of(
                                                                      context)
                                                                  .unfocus();
                                                              FocusManager
                                                                  .instance
                                                                  .primaryFocus
                                                                  ?.unfocus();
                                                            },
                                                            child: Padding(
                                                              padding: MediaQuery
                                                                  .viewInsetsOf(
                                                                      context),
                                                              child:
                                                                  PhotoUploadDialogWidget(
                                                                uploadImage:
                                                                    (image) async {
                                                                  logFirebaseEvent(
                                                                      '_update_page_state');
                                                                  _model.photo =
                                                                      image;
                                                                  safeSetState(
                                                                      () {});
                                                                  logFirebaseEvent(
                                                                      '_backend_call');
                                                                  unawaited(
                                                                    () async {
                                                                      await currentUserReference!
                                                                          .update(
                                                                              createUsersRecordData(
                                                                        photoUrl:
                                                                            image,
                                                                      ));
                                                                    }(),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ).then((value) =>
                                                        safeSetState(() {}));
                                                  },
                                                  text: valueOrDefault<String>(
                                                    _model.photo != null &&
                                                            _model.photo != ''
                                                        ? 'Выбрать другое фото'
                                                        : 'Загрузить фото',
                                                    'Загрузить фото',
                                                  ),
                                                  options: FFButtonOptions(
                                                    padding:
                                                        EdgeInsets.all(0.0),
                                                    iconPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 0.0),
                                                    color: Colors.transparent,
                                                    textStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMedium
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMediumFamily,
                                                              letterSpacing:
                                                                  0.0,
                                                              useGoogleFonts:
                                                                  !FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMediumIsCustom,
                                                            ),
                                                    elevation: 0.0,
                                                    borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0.0),
                                                  ),
                                                ),
                                                FFButtonWidget(
                                                  onPressed: () async {
                                                    logFirebaseEvent(
                                                        'PROFILE_EDIT_deleteButton_ON_TAP');
                                                    logFirebaseEvent(
                                                        'deleteButton_update_page_state');
                                                    _model.photo = null;
                                                    safeSetState(() {});
                                                    logFirebaseEvent(
                                                        'deleteButton_delete_data');
                                                    await FirebaseStorage
                                                        .instance
                                                        .refFromURL(
                                                            _model.photo!)
                                                        .delete();
                                                  },
                                                  text: 'Удалить фото',
                                                  options: FFButtonOptions(
                                                    padding:
                                                        EdgeInsets.all(0.0),
                                                    iconPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 0.0),
                                                    color: Colors.transparent,
                                                    textStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMedium
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMediumFamily,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              letterSpacing:
                                                                  0.0,
                                                              useGoogleFonts:
                                                                  !FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMediumIsCustom,
                                                            ),
                                                    elevation: 0.0,
                                                    borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0.0),
                                                  ),
                                                ),
                                              ].divide(SizedBox(height: 4.0)),
                                            ),
                                          ].divide(SizedBox(width: 16.0)),
                                        ),
                                      ),
                                      Padding(
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
                                                (_model.emailFocusNode
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
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(1.0, 0.0),
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                child: TextFormField(
                                                  controller: _model
                                                      .emailTextController,
                                                  focusNode:
                                                      _model.emailFocusNode,
                                                  autofocus: false,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  readOnly: true,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    isDense: false,
                                                    labelText: 'Email',
                                                    labelStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelLarge
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLargeFamily,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secText80,
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
                                                                40.0,
                                                                8.0),
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelLarge
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLargeFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secText80,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .labelLargeIsCustom,
                                                      ),
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  cursorColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                  enableInteractiveSelection:
                                                      true,
                                                  validator: _model
                                                      .emailTextControllerValidator
                                                      .asValidator(context),
                                                ),
                                              ),
                                              if (_model.emailTextController
                                                          .text !=
                                                      null &&
                                                  _model.emailTextController
                                                          .text !=
                                                      '')
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 16.0, 0.0),
                                                  child: Icon(
                                                    FFIcons.klock2,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    size: 24.0,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
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
                                                /* NOT RECOMMENDED */ _model
                                                            .nameTextController
                                                            .text ==
                                                        'true'
                                                    ? FlutterFlowTheme.of(
                                                            context)
                                                        .border
                                                    : Colors.transparent,
                                                Colors.transparent,
                                              ),
                                            ),
                                          ),
                                          child: Form(
                                            key: _model.formKey1,
                                            autovalidateMode:
                                                AutovalidateMode.disabled,
                                            child: Stack(
                                              alignment: AlignmentDirectional(
                                                  1.0, 0.0),
                                              children: [
                                                AuthUserStreamWidget(
                                                  builder: (context) =>
                                                      Container(
                                                    width: double.infinity,
                                                    child: TextFormField(
                                                      controller: _model
                                                          .nameTextController,
                                                      focusNode:
                                                          _model.nameFocusNode,
                                                      onChanged: (_) =>
                                                          EasyDebounce.debounce(
                                                        '_model.nameTextController',
                                                        Duration(
                                                            milliseconds: 2000),
                                                        () async {
                                                          logFirebaseEvent(
                                                              'PROFILE_EDIT_name_ON_TEXTFIELD_CHANGE');
                                                          logFirebaseEvent(
                                                              'name_validate_form');
                                                          if (_model.formKey1
                                                                      .currentState ==
                                                                  null ||
                                                              !_model.formKey1
                                                                  .currentState!
                                                                  .validate()) {
                                                            return;
                                                          }
                                                          logFirebaseEvent(
                                                              'name_backend_call');
                                                          unawaited(
                                                            () async {
                                                              await currentUserReference!
                                                                  .update(
                                                                      createUsersRecordData(
                                                                displayName: _model
                                                                    .nameTextController
                                                                    .text,
                                                              ));
                                                            }(),
                                                          );
                                                        },
                                                      ),
                                                      onFieldSubmitted:
                                                          (_) async {
                                                        logFirebaseEvent(
                                                            'PROFILE_EDIT_name_ON_TEXTFIELD_SUBMIT');
                                                        logFirebaseEvent(
                                                            'name_validate_form');
                                                        if (_model.formKey1
                                                                    .currentState ==
                                                                null ||
                                                            !_model.formKey1
                                                                .currentState!
                                                                .validate()) {
                                                          return;
                                                        }
                                                        logFirebaseEvent(
                                                            'name_backend_call');
                                                        unawaited(
                                                          () async {
                                                            await currentUserReference!
                                                                .update(
                                                                    createUsersRecordData(
                                                              displayName: _model
                                                                  .nameTextController
                                                                  .text,
                                                            ));
                                                          }(),
                                                        );
                                                      },
                                                      autofocus: false,
                                                      textCapitalization:
                                                          TextCapitalization
                                                              .words,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: false,
                                                        labelText: 'Имя',
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
                                                                    40.0,
                                                                    8.0),
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelLarge
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLargeFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
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
                                                      keyboardType:
                                                          TextInputType.name,
                                                      cursorColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      enableInteractiveSelection:
                                                          true,
                                                      validator: _model
                                                          .nameTextControllerValidator
                                                          .asValidator(context),
                                                      inputFormatters: [
                                                        if (!isAndroid &&
                                                            !isiOS)
                                                          TextInputFormatter
                                                              .withFunction(
                                                                  (oldValue,
                                                                      newValue) {
                                                            return TextEditingValue(
                                                              selection: newValue
                                                                  .selection,
                                                              text: newValue
                                                                  .text
                                                                  .toCapitalization(
                                                                      TextCapitalization
                                                                          .words),
                                                            );
                                                          }),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                if (_model.nameTextController
                                                            .text !=
                                                        null &&
                                                    _model.nameTextController
                                                            .text !=
                                                        '')
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                16.0, 0.0),
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        logFirebaseEvent(
                                                            'PROFILE_EDIT_Icon_n1e9ykb8_ON_TAP');
                                                        logFirebaseEvent(
                                                            'Icon_clear_text_fields_pin_codes');
                                                        safeSetState(() {
                                                          _model
                                                              .nameTextController
                                                              ?.clear();
                                                        });
                                                      },
                                                      child: Icon(
                                                        FFIcons.kcloseIcon,
                                                        color:
                                                            FlutterFlowTheme.of(
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
                                                /* NOT RECOMMENDED */ _model
                                                            .surnameTextController
                                                            .text ==
                                                        'true'
                                                    ? FlutterFlowTheme.of(
                                                            context)
                                                        .border
                                                    : Colors.transparent,
                                                Colors.transparent,
                                              ),
                                            ),
                                          ),
                                          child: Form(
                                            key: _model.formKey2,
                                            autovalidateMode:
                                                AutovalidateMode.disabled,
                                            child: Stack(
                                              alignment: AlignmentDirectional(
                                                  1.0, 0.0),
                                              children: [
                                                AuthUserStreamWidget(
                                                  builder: (context) =>
                                                      Container(
                                                    width: double.infinity,
                                                    child: TextFormField(
                                                      controller: _model
                                                          .surnameTextController,
                                                      focusNode: _model
                                                          .surnameFocusNode,
                                                      onChanged: (_) =>
                                                          EasyDebounce.debounce(
                                                        '_model.surnameTextController',
                                                        Duration(
                                                            milliseconds: 2000),
                                                        () async {
                                                          logFirebaseEvent(
                                                              'PROFILE_EDIT_surname_ON_TEXTFIELD_CHANGE');
                                                          logFirebaseEvent(
                                                              'surname_validate_form');
                                                          if (_model.formKey2
                                                                      .currentState ==
                                                                  null ||
                                                              !_model.formKey2
                                                                  .currentState!
                                                                  .validate()) {
                                                            return;
                                                          }
                                                          logFirebaseEvent(
                                                              'surname_backend_call');
                                                          unawaited(
                                                            () async {
                                                              await currentUserReference!
                                                                  .update(
                                                                      createUsersRecordData(
                                                                surname: _model
                                                                    .surnameTextController
                                                                    .text,
                                                              ));
                                                            }(),
                                                          );
                                                        },
                                                      ),
                                                      onFieldSubmitted:
                                                          (_) async {
                                                        logFirebaseEvent(
                                                            'PROFILE_EDIT_surname_ON_TEXTFIELD_SUBMIT');
                                                        logFirebaseEvent(
                                                            'surname_validate_form');
                                                        if (_model.formKey2
                                                                    .currentState ==
                                                                null ||
                                                            !_model.formKey2
                                                                .currentState!
                                                                .validate()) {
                                                          return;
                                                        }
                                                        logFirebaseEvent(
                                                            'surname_backend_call');
                                                        unawaited(
                                                          () async {
                                                            await currentUserReference!
                                                                .update(
                                                                    createUsersRecordData(
                                                              surname: _model
                                                                  .surnameTextController
                                                                  .text,
                                                            ));
                                                          }(),
                                                        );
                                                      },
                                                      autofocus: false,
                                                      textCapitalization:
                                                          TextCapitalization
                                                              .words,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: false,
                                                        labelText: 'Фамилия',
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
                                                                    40.0,
                                                                    8.0),
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelLarge
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLargeFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
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
                                                      keyboardType:
                                                          TextInputType.name,
                                                      cursorColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      enableInteractiveSelection:
                                                          true,
                                                      validator: _model
                                                          .surnameTextControllerValidator
                                                          .asValidator(context),
                                                      inputFormatters: [
                                                        if (!isAndroid &&
                                                            !isiOS)
                                                          TextInputFormatter
                                                              .withFunction(
                                                                  (oldValue,
                                                                      newValue) {
                                                            return TextEditingValue(
                                                              selection: newValue
                                                                  .selection,
                                                              text: newValue
                                                                  .text
                                                                  .toCapitalization(
                                                                      TextCapitalization
                                                                          .words),
                                                            );
                                                          }),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                if (_model.surnameTextController
                                                            .text !=
                                                        null &&
                                                    _model.surnameTextController
                                                            .text !=
                                                        '')
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                16.0, 0.0),
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        logFirebaseEvent(
                                                            'PROFILE_EDIT_Icon_mtdcco04_ON_TAP');
                                                        logFirebaseEvent(
                                                            'Icon_clear_text_fields_pin_codes');
                                                        safeSetState(() {
                                                          _model
                                                              .surnameTextController
                                                              ?.clear();
                                                        });
                                                      },
                                                      child: Icon(
                                                        FFIcons.kcloseIcon,
                                                        color:
                                                            FlutterFlowTheme.of(
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
                                            0.0, 8.0, 0.0, 8.0),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            logFirebaseEvent(
                                                'PROFILE_EDIT_Container_x83g8zu8_ON_TAP');
                                            logFirebaseEvent(
                                                'Container_haptic_feedback');
                                            HapticFeedback.lightImpact();
                                            logFirebaseEvent(
                                                'Container_update_page_state');
                                            _model.dateBorder =
                                                FlutterFlowTheme.of(context)
                                                    .border;
                                            safeSetState(() {});
                                            logFirebaseEvent(
                                                'Container_date_time_picker');
                                            await showModalBottomSheet<bool>(
                                                context: context,
                                                builder: (context) {
                                                  final _datePickedCupertinoTheme =
                                                      CupertinoTheme.of(
                                                          context);
                                                  return ScrollConfiguration(
                                                    behavior:
                                                        const MaterialScrollBehavior()
                                                            .copyWith(
                                                      dragDevices: {
                                                        PointerDeviceKind.mouse,
                                                        PointerDeviceKind.touch,
                                                        PointerDeviceKind
                                                            .stylus,
                                                        PointerDeviceKind
                                                            .unknown
                                                      },
                                                    ),
                                                    child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              3,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                      child: CupertinoTheme(
                                                        data:
                                                            _datePickedCupertinoTheme
                                                                .copyWith(
                                                          textTheme:
                                                              _datePickedCupertinoTheme
                                                                  .textTheme
                                                                  .copyWith(
                                                            dateTimePickerTextStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .headlineMediumFamily,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .headlineMediumIsCustom,
                                                                    ),
                                                          ),
                                                        ),
                                                        child:
                                                            CupertinoDatePicker(
                                                          mode:
                                                              CupertinoDatePickerMode
                                                                  .date,
                                                          minimumDate: (functions
                                                                  .dateMinusYears(
                                                                      getCurrentTimestamp,
                                                                      100) ??
                                                              DateTime(1900)),
                                                          initialDateTime: ((_model
                                                                          .date !=
                                                                      null
                                                                  ? _model.date
                                                                  : functions
                                                                      .dateMinusYears(
                                                                          getCurrentTimestamp,
                                                                          18)) ??
                                                              DateTime.now()),
                                                          maximumDate:
                                                              DateTime(2050),
                                                          backgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primaryBackground,
                                                          use24hFormat: false,
                                                          onDateTimeChanged:
                                                              (newDateTime) =>
                                                                  safeSetState(
                                                                      () {
                                                            _model.datePicked =
                                                                newDateTime;
                                                          }),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });
                                            logFirebaseEvent(
                                                'Container_update_page_state');
                                            _model.date = _model.datePicked;
                                            _model.dateBorder =
                                                Colors.transparent;
                                            safeSetState(() {});
                                            logFirebaseEvent(
                                                'Container_backend_call');
                                            unawaited(
                                              () async {
                                                await currentUserReference!
                                                    .update(
                                                        createUsersRecordData(
                                                  birthDay: _model.date,
                                                ));
                                              }(),
                                            );
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            constraints: BoxConstraints(
                                              minHeight: 56.0,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .white12,
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              border: Border.all(
                                                color: valueOrDefault<Color>(
                                                  _model.dateBorder,
                                                  Colors.transparent,
                                                ),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 0.0, 16.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Дата рождения',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumFamily,
                                                                fontSize:
                                                                    valueOrDefault<
                                                                        double>(
                                                                  _model.date !=
                                                                          null
                                                                      ? 14.0
                                                                      : 17.0,
                                                                  17.0,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMediumIsCustom,
                                                              ),
                                                        ),
                                                        if (dateTimeFormat(
                                                                  "dd.MM.yyyy",
                                                                  _model.date,
                                                                  locale: FFLocalizations.of(
                                                                          context)
                                                                      .languageCode,
                                                                ) !=
                                                                null &&
                                                            dateTimeFormat(
                                                                  "dd.MM.yyyy",
                                                                  _model.date,
                                                                  locale: FFLocalizations.of(
                                                                          context)
                                                                      .languageCode,
                                                                ) !=
                                                                '')
                                                          Text(
                                                            valueOrDefault<
                                                                String>(
                                                              dateTimeFormat(
                                                                "dd.MM.yyyy",
                                                                _model.date,
                                                                locale: FFLocalizations.of(
                                                                        context)
                                                                    .languageCode,
                                                              ),
                                                              '-',
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyLarge
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLargeFamily,
                                                                  fontSize:
                                                                      16.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  lineHeight:
                                                                      1.4,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyLargeIsCustom,
                                                                ),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ].divide(SizedBox(width: 8.0)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Builder(
                                        builder: (context) => Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 8.0, 0.0, 8.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              logFirebaseEvent(
                                                  'PROFILE_EDIT_Container_sj30j1dd_ON_TAP');
                                              logFirebaseEvent(
                                                  'Container_haptic_feedback');
                                              HapticFeedback.lightImpact();
                                              logFirebaseEvent(
                                                  'Container_custom_action');
                                              unawaited(
                                                () async {
                                                  await actions.closeKeyboard(
                                                    context,
                                                  );
                                                }(),
                                              );
                                              logFirebaseEvent(
                                                  'Container_scroll_to');
                                              await _model.columnController
                                                  ?.animateTo(
                                                _model.columnController!
                                                    .position.maxScrollExtent,
                                                duration:
                                                    Duration(milliseconds: 300),
                                                curve: Curves.ease,
                                              );
                                              logFirebaseEvent(
                                                  'Container_update_page_state');
                                              _model.countryBorder =
                                                  FlutterFlowTheme.of(context)
                                                      .border;
                                              safeSetState(() {});
                                              logFirebaseEvent(
                                                  'Container_alert_dialog');
                                              showAlignedDialog(
                                                barrierColor:
                                                    Colors.transparent,
                                                context: context,
                                                isGlobal: false,
                                                avoidOverflow: true,
                                                targetAnchor:
                                                    AlignmentDirectional(
                                                            0.0, -1.0)
                                                        .resolve(
                                                            Directionality.of(
                                                                context)),
                                                followerAnchor:
                                                    AlignmentDirectional(
                                                            0.0, -1.0)
                                                        .resolve(
                                                            Directionality.of(
                                                                context)),
                                                builder: (dialogContext) {
                                                  return Material(
                                                    color: Colors.transparent,
                                                    child: WebViewAware(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          FocusScope.of(
                                                                  dialogContext)
                                                              .unfocus();
                                                          FocusManager.instance
                                                              .primaryFocus
                                                              ?.unfocus();
                                                        },
                                                        child:
                                                            CountryDialogWidget(
                                                          select: (name,
                                                              code) async {
                                                            logFirebaseEvent(
                                                                '_update_page_state');
                                                            _model.countryState =
                                                                name;
                                                            _model.countryCodeState =
                                                                code;
                                                            safeSetState(() {});
                                                            logFirebaseEvent(
                                                                '_backend_call');
                                                            unawaited(
                                                              () async {
                                                                await currentUserReference!
                                                                    .update(
                                                                        createUsersRecordData(
                                                                  country: name,
                                                                  countryCode:
                                                                      code,
                                                                ));
                                                              }(),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );

                                              logFirebaseEvent(
                                                  'Container_update_page_state');
                                              _model.countryBorder =
                                                  Colors.transparent;
                                              safeSetState(() {});
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              constraints: BoxConstraints(
                                                minHeight: 56.0,
                                              ),
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .white12,
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                                border: Border.all(
                                                  color: valueOrDefault<Color>(
                                                    _model.countryBorder,
                                                    Colors.transparent,
                                                  ),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 0.0, 16.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    if (_model.countryState !=
                                                            null &&
                                                        _model.countryState !=
                                                            '')
                                                      Text(
                                                        valueOrDefault<String>(
                                                          getJsonField(
                                                            functions
                                                                .countries()
                                                                .where((e) =>
                                                                    _model
                                                                        .countryState ==
                                                                    getJsonField(
                                                                      e,
                                                                      r'''$.name''',
                                                                    ).toString())
                                                                .toList()
                                                                .firstOrNull,
                                                            r'''$.flag''',
                                                          )?.toString(),
                                                          '--',
                                                        ),
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyLarge
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLargeFamily,
                                                              fontSize: 24.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              lineHeight: 1.4,
                                                              useGoogleFonts:
                                                                  !FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLargeIsCustom,
                                                            ),
                                                      ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Страна',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .labelMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMediumFamily,
                                                                  fontSize:
                                                                      valueOrDefault<
                                                                          double>(
                                                                    _model.countryState !=
                                                                                null &&
                                                                            _model.countryState !=
                                                                                ''
                                                                        ? 14.0
                                                                        : 17.0,
                                                                    17.0,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMediumIsCustom,
                                                                ),
                                                          ),
                                                          if (_model.countryState !=
                                                                  null &&
                                                              _model.countryState !=
                                                                  '')
                                                            Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                _model
                                                                    .countryState,
                                                                '-',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyLarge
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyLargeFamily,
                                                                    fontSize:
                                                                        16.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    lineHeight:
                                                                        1.4,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .bodyLargeIsCustom,
                                                                  ),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                    Icon(
                                                      FFIcons.kright3,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      size: 24.0,
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 8.0)),
                                                ),
                                              ),
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
                                                  0.0, 20.0, 0.0, 0.0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              logFirebaseEvent(
                                                  'PROFILE_EDIT_editPassButton_ON_TAP');
                                              logFirebaseEvent(
                                                  'editPassButton_haptic_feedback');
                                              HapticFeedback.mediumImpact();
                                              if (isWeb) {
                                                logFirebaseEvent(
                                                    'editPassButton_navigate_to');

                                                context.pushNamed(
                                                  EditPasswordWidget.routeName,
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
                                                    'editPassButton_navigate_to');

                                                context.pushNamed(
                                                    EditPasswordWidget
                                                        .routeName);
                                              }
                                            },
                                            text: 'Изменить пароль',
                                            options: FFButtonOptions(
                                              padding: EdgeInsets.all(0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color: Colors.transparent,
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleMediumFamily,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .titleMediumIsCustom,
                                                      ),
                                              elevation: 0.0,
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(0.0),
                                            ),
                                            showLoadingIndicator: false,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 4.0, 0.0, 0.0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              logFirebaseEvent(
                                                  'PROFILE_EDIT_deleteAccButton_ON_TAP');
                                              logFirebaseEvent(
                                                  'deleteAccButton_haptic_feedback');
                                              HapticFeedback.mediumImpact();
                                              logFirebaseEvent(
                                                  'deleteAccButton_bottom_sheet');
                                              showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                useSafeArea: true,
                                                context: context,
                                                builder: (context) {
                                                  return WebViewAware(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        FocusScope.of(context)
                                                            .unfocus();
                                                        FocusManager.instance
                                                            .primaryFocus
                                                            ?.unfocus();
                                                      },
                                                      child: Padding(
                                                        padding: MediaQuery
                                                            .viewInsetsOf(
                                                                context),
                                                        child:
                                                            DeleteAccDialogWidget(),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ).then((value) =>
                                                  safeSetState(() {}));
                                            },
                                            text: 'Удалить профиль',
                                            options: FFButtonOptions(
                                              padding: EdgeInsets.all(0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color: Colors.transparent,
                                              textStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .titleMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMediumFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .titleMediumIsCustom,
                                                  ),
                                              elevation: 0.0,
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(0.0),
                                            ),
                                            showLoadingIndicator: false,
                                          ),
                                        ),
                                      ),
                                      if (responsiveVisibility(
                                        context: context,
                                        phone: false,
                                        tablet: false,
                                        tabletLandscape: false,
                                        desktop: false,
                                      ))
                                        Stack(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 8.0, 0.0, 8.0),
                                              child:
                                                  FlutterFlowDropDown<String>(
                                                controller: _model
                                                        .countryDDValueController ??=
                                                    FormFieldController<String>(
                                                  _model.countryDDValue ??=
                                                      _model.countryState,
                                                ),
                                                options: functions
                                                    .countries()
                                                    .map((e) => getJsonField(
                                                          e,
                                                          r'''$.name''',
                                                        ))
                                                    .toList()
                                                    .map((e) => e.toString())
                                                    .toList(),
                                                onChanged: (val) async {
                                                  safeSetState(() => _model
                                                      .countryDDValue = val);
                                                  logFirebaseEvent(
                                                      'PROFILE_EDIT_countryDD_ON_FORM_WIDGET_SE');
                                                  logFirebaseEvent(
                                                      'countryDD_update_page_state');
                                                  _model.countryState =
                                                      _model.countryState;
                                                  _model.countryCodeState =
                                                      getJsonField(
                                                    functions
                                                        .countries()
                                                        .where((e) =>
                                                            _model
                                                                .countryState ==
                                                            getJsonField(
                                                              e,
                                                              r'''$.name''',
                                                            ).toString())
                                                        .toList()
                                                        .firstOrNull,
                                                    r'''$.code''',
                                                  ).toString();
                                                  safeSetState(() {});
                                                },
                                                width: double.infinity,
                                                height: 56.0,
                                                searchHintTextStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMediumFamily,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelMediumIsCustom,
                                                        ),
                                                searchTextStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMediumIsCustom,
                                                        ),
                                                textStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily,
                                                      color: _model.countryState !=
                                                                  null &&
                                                              _model.countryState !=
                                                                  ''
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      fontSize: 17.0,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumIsCustom,
                                                    ),
                                                hintText: 'Страна',
                                                searchHintText: 'Поиск',
                                                icon: Icon(
                                                  FFIcons.kright3,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  size: 24.0,
                                                ),
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                elevation: 2.0,
                                                borderColor: Colors.transparent,
                                                borderWidth: 0.0,
                                                borderRadius: 16.0,
                                                margin: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        valueOrDefault<double>(
                                                          _model.countryState !=
                                                                      null &&
                                                                  _model.countryState !=
                                                                      ''
                                                              ? 46.0
                                                              : 16.0,
                                                          16.0,
                                                        ),
                                                        0.0,
                                                        16.0,
                                                        0.0),
                                                hidesUnderline: true,
                                                isOverButton: true,
                                                isSearchable: true,
                                                isMultiSelect: false,
                                              ),
                                            ),
                                            if (_model.countryState != null &&
                                                _model.countryState != '')
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    getJsonField(
                                                      functions
                                                          .countries()
                                                          .where((e) =>
                                                              _model
                                                                  .countryState ==
                                                              getJsonField(
                                                                e,
                                                                r'''$.name''',
                                                              ).toString())
                                                          .toList()
                                                          .firstOrNull,
                                                      r'''$.flag''',
                                                    )?.toString(),
                                                    '--',
                                                  ),
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLarge
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLargeFamily,
                                                            fontSize: 24.0,
                                                            letterSpacing: 0.0,
                                                            lineHeight: 1.4,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLargeIsCustom,
                                                          ),
                                                ),
                                              ),
                                          ],
                                        ),
                                    ]
                                        .addToStart(SizedBox(height: 8.0))
                                        .addToEnd(SizedBox(height: 48.0)),
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
