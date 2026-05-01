import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/back_button/back_button_widget.dart';
import '/components/dialogs/country_dialog/country_dialog_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'about_you_model.dart';
export 'about_you_model.dart';

class AboutYouWidget extends StatefulWidget {
  const AboutYouWidget({super.key});

  static String routeName = 'AboutYou';
  static String routePath = '/aboutYou';

  @override
  State<AboutYouWidget> createState() => _AboutYouWidgetState();
}

class _AboutYouWidgetState extends State<AboutYouWidget> {
  late AboutYouModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AboutYouModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'AboutYou'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('ABOUT_YOU_PAGE_AboutYou_ON_INIT_STATE');
      logFirebaseEvent('AboutYou_custom_action');
      unawaited(
        () async {
          await actions.setStatusBarColor();
        }(),
      );
      await Future.wait([
        Future(() async {
          if (currentUserDocument?.birthDay != null) {
            logFirebaseEvent('AboutYou_update_page_state');
            _model.date = currentUserDocument?.birthDay;
            safeSetState(() {});
          }
        }),
        Future(() async {
          if (valueOrDefault(currentUserDocument?.country, '') != null &&
              valueOrDefault(currentUserDocument?.country, '') != '') {
            logFirebaseEvent('AboutYou_update_page_state');
            _model.countryState =
                valueOrDefault(currentUserDocument?.country, '');
            _model.countryCodeState =
                valueOrDefault(currentUserDocument?.countryCode, '');
            safeSetState(() {});
          }
        }),
      ]);
    });

    if (!isWeb) {
      _keyboardVisibilitySubscription =
          KeyboardVisibilityController().onChange.listen((bool visible) {
        safeSetState(() {
          _isKeyboardVisible = visible;
        });
      });
    }

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

    if (!isWeb) {
      _keyboardVisibilitySubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
        title: 'AboutYou',
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
                                'ABOUT_YOU_Container_4u22f9sq_CALLBACK');
                            logFirebaseEvent('backButton_navigate_to');

                            context.goNamed(
                              SplashPageWidget.routeName,
                              extra: <String, dynamic>{
                                '__transition_info__': TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 0),
                                ),
                              },
                            );
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
                            controller: _model.columnController,
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
                                      'РАССКАЖИ О СЕБЕ',
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
                                    'Так мы подберем рекомендации для тебя ',
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
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 8.0, 0.0, 8.0),
                                  child: Container(
                                    constraints: BoxConstraints(
                                      minHeight: 56.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).white12,
                                      borderRadius: BorderRadius.circular(16.0),
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    child: Form(
                                      key: _model.formKey2,
                                      autovalidateMode:
                                          AutovalidateMode.disabled,
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                            controller:
                                                _model.nameTextController,
                                            focusNode: _model.nameFocusNode,
                                            onChanged: (_) =>
                                                EasyDebounce.debounce(
                                              '_model.nameTextController',
                                              Duration(milliseconds: 50),
                                              () => safeSetState(() {}),
                                            ),
                                            onFieldSubmitted: (_) async {
                                              logFirebaseEvent(
                                                  'ABOUT_YOU_PAGE_name_ON_TEXTFIELD_SUBMIT');
                                              logFirebaseEvent(
                                                  'name_validate_form');
                                              if (_model.formKey2
                                                          .currentState ==
                                                      null ||
                                                  !_model.formKey2.currentState!
                                                      .validate()) {
                                                return;
                                              }
                                            },
                                            autofocus: false,
                                            textCapitalization:
                                                TextCapitalization.words,
                                            textInputAction:
                                                TextInputAction.next,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              isDense: false,
                                              labelText: 'Имя',
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
                                                          16.0, 8.0),
                                            ),
                                            style: FlutterFlowTheme.of(context)
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
                                            keyboardType: TextInputType.name,
                                            cursorColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                            enableInteractiveSelection: true,
                                            validator: _model
                                                .nameTextControllerValidator
                                                .asValidator(context),
                                            inputFormatters: [
                                              if (!isAndroid && !isiOS)
                                                TextInputFormatter.withFunction(
                                                    (oldValue, newValue) {
                                                  return TextEditingValue(
                                                    selection:
                                                        newValue.selection,
                                                    text: newValue.text
                                                        .toCapitalization(
                                                            TextCapitalization
                                                                .words),
                                                  );
                                                }),
                                            ],
                                          ),
                                        ),
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
                                      color:
                                          FlutterFlowTheme.of(context).white12,
                                      borderRadius: BorderRadius.circular(16.0),
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    child: Form(
                                      key: _model.formKey1,
                                      autovalidateMode:
                                          AutovalidateMode.disabled,
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                            controller:
                                                _model.surnameTextController,
                                            focusNode: _model.surnameFocusNode,
                                            onChanged: (_) =>
                                                EasyDebounce.debounce(
                                              '_model.surnameTextController',
                                              Duration(milliseconds: 50),
                                              () => safeSetState(() {}),
                                            ),
                                            onFieldSubmitted: (_) async {
                                              logFirebaseEvent(
                                                  'ABOUT_YOU_surname_ON_TEXTFIELD_SUBMIT');
                                              logFirebaseEvent(
                                                  'surname_validate_form');
                                              if (_model.formKey1
                                                          .currentState ==
                                                      null ||
                                                  !_model.formKey1.currentState!
                                                      .validate()) {
                                                return;
                                              }
                                            },
                                            autofocus: false,
                                            textCapitalization:
                                                TextCapitalization.words,
                                            textInputAction:
                                                TextInputAction.next,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              isDense: false,
                                              labelText: 'Фамилия',
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
                                                          16.0, 8.0),
                                            ),
                                            style: FlutterFlowTheme.of(context)
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
                                            keyboardType: TextInputType.name,
                                            cursorColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                            enableInteractiveSelection: true,
                                            validator: _model
                                                .surnameTextControllerValidator
                                                .asValidator(context),
                                            inputFormatters: [
                                              if (!isAndroid && !isiOS)
                                                TextInputFormatter.withFunction(
                                                    (oldValue, newValue) {
                                                  return TextEditingValue(
                                                    selection:
                                                        newValue.selection,
                                                    text: newValue.text
                                                        .toCapitalization(
                                                            TextCapitalization
                                                                .words),
                                                  );
                                                }),
                                            ],
                                          ),
                                        ),
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
                                          'ABOUT_YOU_PAGE_Container_0isugckr_ON_TAP');
                                      logFirebaseEvent(
                                          'Container_haptic_feedback');
                                      HapticFeedback.lightImpact();
                                      logFirebaseEvent(
                                          'Container_date_time_picker');
                                      await showModalBottomSheet<bool>(
                                          context: context,
                                          builder: (context) {
                                            final _datePickedCupertinoTheme =
                                                CupertinoTheme.of(context);
                                            return ScrollConfiguration(
                                              behavior:
                                                  const MaterialScrollBehavior()
                                                      .copyWith(
                                                dragDevices: {
                                                  PointerDeviceKind.mouse,
                                                  PointerDeviceKind.touch,
                                                  PointerDeviceKind.stylus,
                                                  PointerDeviceKind.unknown
                                                },
                                              ),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    3,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                color:
                                                    FlutterFlowTheme.of(context)
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
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMediumFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineMediumIsCustom,
                                                              ),
                                                    ),
                                                  ),
                                                  child: CupertinoDatePicker(
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
                                                    maximumDate: DateTime(2050),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryBackground,
                                                    use24hFormat: false,
                                                    onDateTimeChanged:
                                                        (newDateTime) =>
                                                            safeSetState(() {
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
                                      safeSetState(() {});
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      constraints: BoxConstraints(
                                        minHeight: 56.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .white12,
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        border: Border.all(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Дата рождения',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMediumFamily,
                                                          fontSize:
                                                              valueOrDefault<
                                                                  double>(
                                                            _model.date != null
                                                                ? 14.0
                                                                : 17.0,
                                                            17.0,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelMediumIsCustom,
                                                        ),
                                                  ),
                                                  if (_model.date != null)
                                                    Text(
                                                      dateTimeFormat(
                                                        "dd.MM.yyyy",
                                                        _model.date,
                                                        locale:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .languageCode,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyLarge
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLargeFamily,
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.0,
                                                            lineHeight: 1.4,
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
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 8.0, 0.0, 8.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'ABOUT_YOU_PAGE_Container_np7y0587_ON_TAP');
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
                                        logFirebaseEvent('Container_scroll_to');
                                        await _model.columnController
                                            ?.animateTo(
                                          _model.columnController!.position
                                              .maxScrollExtent,
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.ease,
                                        );
                                        logFirebaseEvent(
                                            'Container_alert_dialog');
                                        showAlignedDialog(
                                          barrierColor: Colors.transparent,
                                          context: context,
                                          isGlobal: false,
                                          avoidOverflow: true,
                                          targetAnchor: AlignmentDirectional(
                                                  0.0, -1.0)
                                              .resolve(
                                                  Directionality.of(context)),
                                          followerAnchor: AlignmentDirectional(
                                                  0.0, -1.0)
                                              .resolve(
                                                  Directionality.of(context)),
                                          builder: (dialogContext) {
                                            return Material(
                                              color: Colors.transparent,
                                              child: WebViewAware(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    FocusScope.of(dialogContext)
                                                        .unfocus();
                                                    FocusManager
                                                        .instance.primaryFocus
                                                        ?.unfocus();
                                                  },
                                                  child: CountryDialogWidget(
                                                    select: (name, code) async {
                                                      logFirebaseEvent(
                                                          '_update_page_state');
                                                      _model.countryState =
                                                          name;
                                                      _model.countryCodeState =
                                                          code;
                                                      safeSetState(() {});
                                                    },
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        constraints: BoxConstraints(
                                          minHeight: 56.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .white12,
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          border: Border.all(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 16.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              if (_model.countryState != null &&
                                                  _model.countryState != '')
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
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Страна',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .labelMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
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
                                                            letterSpacing: 0.0,
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
                                                        _model.countryState!,
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyLarge
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLargeFamily,
                                                              fontSize: 16.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              lineHeight: 1.4,
                                                              useGoogleFonts:
                                                                  !FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLargeIsCustom,
                                                            ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                              Icon(
                                                FFIcons.kright3,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 24.0,
                                              ),
                                            ].divide(SizedBox(width: 8.0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 12.0, 0.0, 12.0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      logFirebaseEvent(
                                          'ABOUT_YOU_PAGE__BTN_ON_TAP');
                                      logFirebaseEvent(
                                          'Button_haptic_feedback');
                                      HapticFeedback.mediumImpact();
                                      logFirebaseEvent('Button_backend_call');
                                      unawaited(
                                        () async {
                                          await currentUserReference!
                                              .update(createUsersRecordData(
                                            displayName:
                                                _model.nameTextController.text,
                                            surname: _model
                                                .surnameTextController.text,
                                          ));
                                        }(),
                                      );
                                      logFirebaseEvent('Button_navigate_to');

                                      context.goNamed(
                                        SplashPageWidget.routeName,
                                        extra: <String, dynamic>{
                                          '__transition_info__': TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.fade,
                                            duration: Duration(milliseconds: 0),
                                          ),
                                        },
                                      );

                                      await Future.wait([
                                        Future(() async {
                                          if (_model.date != null) {
                                            logFirebaseEvent(
                                                'Button_backend_call');
                                            unawaited(
                                              () async {
                                                await currentUserReference!
                                                    .update(
                                                        createUsersRecordData(
                                                  birthDay: _model.date,
                                                ));
                                              }(),
                                            );
                                          }
                                        }),
                                        Future(() async {
                                          if (_model.countryState != null &&
                                              _model.countryState != '') {
                                            logFirebaseEvent(
                                                'Button_backend_call');
                                            unawaited(
                                              () async {
                                                await currentUserReference!
                                                    .update(
                                                        createUsersRecordData(
                                                  country: _model.countryState,
                                                  countryCode:
                                                      _model.countryCodeState,
                                                ));
                                              }(),
                                            );
                                          }
                                        }),
                                      ]);
                                    },
                                    text: 'ПРОДОЛЖИТЬ',
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
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.circular(56.0),
                                    ),
                                  ),
                                ),
                              ].addToEnd(SizedBox(height: 34.0)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (!valueOrDefault<bool>(
                      isWeb
                          ? MediaQuery.viewInsetsOf(context).bottom > 0
                          : _isKeyboardVisible,
                      false,
                    ))
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 48.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            logFirebaseEvent('ABOUT_YOU_PAGE__BTN_ON_TAP');
                            logFirebaseEvent('Button_haptic_feedback');
                            HapticFeedback.mediumImpact();
                            logFirebaseEvent('Button_navigate_to');

                            context.goNamed(
                              SplashPageWidget.routeName,
                              extra: <String, dynamic>{
                                '__transition_info__': TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 0),
                                ),
                              },
                            );
                          },
                          text: 'ПРОПУСТИТЬ',
                          options: FFButtonOptions(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Colors.transparent,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .titleSmallFamily,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .titleSmallIsCustom,
                                ),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          showLoadingIndicator: false,
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
