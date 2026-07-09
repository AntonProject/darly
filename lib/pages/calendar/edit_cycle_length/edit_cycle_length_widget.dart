import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/back_button/back_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/calendar/days_dropdown_dialog/days_dropdown_dialog_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'edit_cycle_length_model.dart';
export 'edit_cycle_length_model.dart';

class EditCycleLengthWidget extends StatefulWidget {
  const EditCycleLengthWidget({
    super.key,
    this.length,
    required this.listCycles,
    int? duration,
    required this.firstDay,
    required this.ref,
  }) : this.duration = duration ?? 0;

  final int? length;
  final List<MonthCycleStruct>? listCycles;
  final int duration;
  final DateTime? firstDay;
  final DocumentReference? ref;

  @override
  State<EditCycleLengthWidget> createState() => _EditCycleLengthWidgetState();
}

class _EditCycleLengthWidgetState extends State<EditCycleLengthWidget> {
  late EditCycleLengthModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditCycleLengthModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('EDIT_CYCLE_LENGTH_editCycleLength_ON_INI');
      logFirebaseEvent('editCycleLength_update_component_state');
      _model.lengthState = widget!.length;
      _model.durationState = widget!.duration;
      _model.firstDayState = widget!.firstDay;
      safeSetState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
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
                        'EDIT_CYCLE_LENGTH_Container_v1x4ruwc_CAL');
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
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 8.0, 20.0, 0.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 16.0, 0.0, 16.0),
                            child: Text(
                              'НАСТРОЙКА ЦИКЛА',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
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
                              0.0, 24.0, 0.0, 8.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'EDIT_CYCLE_LENGTH_Container_kkne52gw_ON_');
                              logFirebaseEvent('Container_date_time_picker');
                              await showModalBottomSheet<bool>(
                                  context: context,
                                  builder: (context) {
                                    final _datePickedCupertinoTheme =
                                        CupertinoTheme.of(context);
                                    return ScrollConfiguration(
                                      behavior: const MaterialScrollBehavior()
                                          .copyWith(
                                        dragDevices: {
                                          PointerDeviceKind.mouse,
                                          PointerDeviceKind.touch,
                                          PointerDeviceKind.stylus,
                                          PointerDeviceKind.unknown
                                        },
                                      ),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        child: CupertinoTheme(
                                          data: _datePickedCupertinoTheme
                                              .copyWith(
                                            textTheme: _datePickedCupertinoTheme
                                                .textTheme
                                                .copyWith(
                                              dateTimePickerTextStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineMediumFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .headlineMediumIsCustom,
                                                      ),
                                            ),
                                          ),
                                          child: CupertinoDatePicker(
                                            mode: CupertinoDatePickerMode.date,
                                            minimumDate: DateTime(1900),
                                            initialDateTime: ((_model
                                                            .firstDayState !=
                                                        null
                                                    ? _model.firstDayState
                                                    : getCurrentTimestamp) ??
                                                DateTime.now()),
                                            maximumDate: DateTime(2050),
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryBackground,
                                            use24hFormat: false,
                                            onDateTimeChanged: (newDateTime) =>
                                                safeSetState(() {
                                              _model.datePicked = newDateTime;
                                            }),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                              logFirebaseEvent(
                                  'Container_update_component_state');
                              _model.firstDayState = _model.datePicked;
                              safeSetState(() {});
                            },
                            child: Container(
                              width: double.infinity,
                              constraints: BoxConstraints(
                                minHeight: 56.0,
                              ),
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(16.0),
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
                                            'Первый день последних месячных',
                                            maxLines: valueOrDefault<int>(
                                              _model.firstDayState != null
                                                  ? 1
                                                  : 2,
                                              2,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMediumFamily,
                                                  fontSize:
                                                      valueOrDefault<double>(
                                                    _model.firstDayState != null
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
                                          if (_model.firstDayState != null)
                                            Text(
                                              valueOrDefault<String>(
                                                dateTimeFormat(
                                                  "dd MMMM yyyy",
                                                  _model.firstDayState,
                                                  locale: FFLocalizations.of(
                                                          context)
                                                      .languageCode,
                                                ),
                                                '-',
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
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
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyLargeIsCustom,
                                                      ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      FFIcons.kright3,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 24.0,
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
                                    'EDIT_CYCLE_LENGTH_Container_jcjv90f5_ON_');
                                logFirebaseEvent('Container_alert_dialog');
                                await showAlignedDialog(
                                  barrierColor: Colors.transparent,
                                  context: context,
                                  isGlobal: false,
                                  avoidOverflow: false,
                                  targetAnchor: AlignmentDirectional(0.0, -1.0)
                                      .resolve(Directionality.of(context)),
                                  followerAnchor:
                                      AlignmentDirectional(0.0, -1.0)
                                          .resolve(Directionality.of(context)),
                                  builder: (dialogContext) {
                                    return Material(
                                      color: Colors.transparent,
                                      child: WebViewAware(
                                        child: DaysDropdownDialogWidget(
                                          max: 30,
                                          select: (days) async {
                                            logFirebaseEvent(
                                                '_update_component_state');
                                            _model.durationState = days;
                                            safeSetState(() {});
                                          },
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
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(16.0),
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
                                              'Сколько дней идут месячные',
                                              maxLines: valueOrDefault<int>(
                                                _model.durationState! > 0
                                                    ? 1
                                                    : 2,
                                                2,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMediumFamily,
                                                    fontSize:
                                                        valueOrDefault<double>(
                                                      _model.durationState! > 0
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
                                            if (_model.durationState! > 0)
                                              Text(
                                                '${valueOrDefault<String>(
                                                  _model.durationState
                                                      ?.toString(),
                                                  '0',
                                                )} ${valueOrDefault<String>(
                                                  functions.dayText(
                                                      _model.durationState!),
                                                  '0 дней',
                                                )}',
                                                style:
                                                    FlutterFlowTheme.of(context)
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
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyLargeIsCustom,
                                                        ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      Icon(
                                        FFIcons.kright3,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 24.0,
                                      ),
                                    ].divide(SizedBox(width: 8.0)),
                                  ),
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
                                    'EDIT_CYCLE_LENGTH_Container_k40eg3es_ON_');
                                logFirebaseEvent('Container_alert_dialog');
                                await showAlignedDialog(
                                  barrierColor: Colors.transparent,
                                  context: context,
                                  isGlobal: false,
                                  avoidOverflow: false,
                                  targetAnchor: AlignmentDirectional(0.0, -1.0)
                                      .resolve(Directionality.of(context)),
                                  followerAnchor:
                                      AlignmentDirectional(0.0, -1.0)
                                          .resolve(Directionality.of(context)),
                                  builder: (dialogContext) {
                                    return Material(
                                      color: Colors.transparent,
                                      child: WebViewAware(
                                        child: DaysDropdownDialogWidget(
                                          max: 45,
                                          select: (days) async {
                                            logFirebaseEvent(
                                                '_update_component_state');
                                            _model.lengthState = days;
                                            safeSetState(() {});
                                          },
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
                                  maxHeight: 72.0,
                                ),
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(16.0),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AutoSizeText(
                                              'Сколько дней от начала месячных до начала следующих',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMediumFamily,
                                                    fontSize:
                                                        valueOrDefault<double>(
                                                      _model.lengthState! > 0
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
                                            if (_model.lengthState! > 0)
                                              Text(
                                                '${valueOrDefault<String>(
                                                  _model.lengthState
                                                      ?.toString(),
                                                  '0',
                                                )} ${valueOrDefault<String>(
                                                  functions.dayText(
                                                      _model.lengthState!),
                                                  '0 дней',
                                                )}',
                                                style:
                                                    FlutterFlowTheme.of(context)
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
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyLargeIsCustom,
                                                        ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      Icon(
                                        FFIcons.kright3,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 24.0,
                                      ),
                                    ].divide(SizedBox(width: 8.0)),
                                  ),
                                ),
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
            Container(
              constraints: BoxConstraints(
                maxWidth: 600.0,
              ),
              decoration: BoxDecoration(),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 12.0, 20.0, 34.0),
                child: FFButtonWidget(
                  onPressed: ((_model.lengthState! <= 0) ||
                          (_model.durationState! <= 0) ||
                          (_model.firstDayState == null))
                      ? null
                      : () async {
                          logFirebaseEvent(
                              'EDIT_CYCLE_LENGTH_COMP__BTN_ON_TAP');
                          logFirebaseEvent('Button_backend_call');

                          await widget!.ref!.update({
                            ...createCalendarRecordData(
                              firsDate: _model.firstDayState,
                              duration: _model.durationState,
                              lengthCycle: _model.lengthState,
                            ),
                            ...mapToFirestore(
                              {
                                'monthCycles': getMonthCycleListFirestoreData(
                                  functions.editDurationMonthCycle(
                                      _model.lengthState!,
                                      widget!.listCycles!.toList(),
                                      getCurrentTimestamp,
                                      _model.durationState!,
                                      _model.firstDayState),
                                ),
                              },
                            ),
                          });
                          logFirebaseEvent('Button_navigate_back');
                          context.safePop();
                        },
                  text: 'ПРИМЕНИТЬ',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 56.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).titleSmallFamily,
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 17.0,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).titleSmallIsCustom,
                        ),
                    elevation: 0.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(56.0),
                    disabledColor: FlutterFlowTheme.of(context).primaryBG40,
                    disabledTextColor:
                        FlutterFlowTheme.of(context).secondaryText,
                  ),
                  showLoadingIndicator: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
