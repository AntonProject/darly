import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/back_button/back_button_widget.dart';
import '/components/month_day/month_day_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'calendar_months_page_model.dart';
export 'calendar_months_page_model.dart';

class CalendarMonthsPageWidget extends StatefulWidget {
  const CalendarMonthsPageWidget({
    super.key,
    required this.monthCyles,
    required this.calendarRef,
    int? duration,
    int? length,
    this.fisrtdate,
  })  : this.duration = duration ?? 0,
        this.length = length ?? 0;

  final List<MonthCycleStruct>? monthCyles;
  final DocumentReference? calendarRef;
  final int duration;
  final int length;
  final DateTime? fisrtdate;

  static String routeName = 'CalendarMonthsPage';
  static String routePath = '/calendarMonthsPage';

  @override
  State<CalendarMonthsPageWidget> createState() =>
      _CalendarMonthsPageWidgetState();
}

class _CalendarMonthsPageWidgetState extends State<CalendarMonthsPageWidget> {
  late CalendarMonthsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CalendarMonthsPageModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'CalendarMonthsPage'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('CALENDAR_MONTHS_CalendarMonthsPage_ON_IN');
      logFirebaseEvent('CalendarMonthsPage_update_page_state');
      _model.cycles = functions
          .calendarMonths(widget!.monthCyles?.toList(), widget!.fisrtdate,
              widget!.length, widget!.duration)
          .toList()
          .cast<MonthCycleStruct>();
      safeSetState(() {});
      logFirebaseEvent('CalendarMonthsPage_custom_action');
      unawaited(
        () async {
          await actions.setStatusBarColor();
        }(),
      );
      logFirebaseEvent('CalendarMonthsPage_custom_action');
      unawaited(
        () async {
          await actions.lockLandscapeMode();
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
        title: 'CalendarMonthsPage',
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
                    'assets/images/Page-Calendar.webp',
                  ).image,
                ),
              ),
              child: Align(
                alignment: AlignmentDirectional(0.0, -1.0),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 600.0,
                  ),
                  decoration: BoxDecoration(),
                  child: Stack(
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 54.0, 0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0.0, -1.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 4.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 12.0, 0.0),
                                        child: wrapWithModel(
                                          model: _model.backButtonModel,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: BackButtonWidget(
                                            icon: Icon(
                                              FFIcons.kleftIcon3,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 24.0,
                                            ),
                                            action: () async {
                                              logFirebaseEvent(
                                                  'CALENDAR_MONTHS_Container_cg3sbj7d_CALLB');
                                              logFirebaseEvent(
                                                  'backButton_navigate_back');
                                              context.safePop();
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Календарь цикла',
                                      style: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .titleMediumFamily,
                                            fontSize: 17.0,
                                            letterSpacing: 0.0,
                                            lineHeight: 1.2,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .titleMediumIsCustom,
                                          ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 0.0, 12.0, 0.0),
                                      child: Container(
                                        width: 56.0,
                                        decoration: BoxDecoration(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 20.0, 0.0),
                                child: Builder(
                                  builder: (context) {
                                    final months = _model.cycles.toList();

                                    return SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: List.generate(months.length,
                                                (monthsIndex) {
                                          final monthsItem =
                                              months[monthsIndex];
                                          return Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Color(0x10FFFFFF),
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .white12,
                                                width: 1.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      12.0, 24.0, 12.0, 24.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            -1.0, 0.0),
                                                    child: Text(
                                                      functions.monthTitle(
                                                          monthsItem.month),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .titleMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMediumFamily,
                                                            fontSize: 17.0,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMediumIsCustom,
                                                          ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            -1.0, 0.0),
                                                    child: Container(
                                                      width: double.infinity,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Builder(
                                                        builder: (context) {
                                                          final days = functions
                                                              .monthDaysWithOffset(
                                                                  monthsItem
                                                                      .month)
                                                              .toList();

                                                          return GridView
                                                              .builder(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            gridDelegate:
                                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount: 7,
                                                              crossAxisSpacing:
                                                                  4.0,
                                                              mainAxisSpacing:
                                                                  4.0,
                                                              childAspectRatio:
                                                                  1.0,
                                                            ),
                                                            primary: false,
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemCount:
                                                                days.length,
                                                            itemBuilder:
                                                                (context,
                                                                    daysIndex) {
                                                              final daysItem =
                                                                  days[
                                                                      daysIndex];
                                                              return wrapWithModel(
                                                                model: _model
                                                                    .monthDayModels
                                                                    .getModel(
                                                                  daysItem
                                                                      .toString(),
                                                                  daysIndex,
                                                                ),
                                                                updateCallback: () =>
                                                                    safeSetState(
                                                                        () {}),
                                                                updateOnChange:
                                                                    true,
                                                                child:
                                                                    MonthDayWidget(
                                                                  key: Key(
                                                                    'Keyxzb_${daysItem.toString()}',
                                                                  ),
                                                                  month:
                                                                      monthsItem
                                                                          .month!,
                                                                  day: daysItem,
                                                                  edit: _model
                                                                      .edit,
                                                                  cycleList:
                                                                      _model
                                                                          .cycles,
                                                                  remove:
                                                                      () async {
                                                                    logFirebaseEvent(
                                                                        'CALENDAR_MONTHS_Container_xzb7xmks_CALLB');
                                                                    logFirebaseEvent(
                                                                        'monthDay_update_page_state');
                                                                    _model.cycles = functions
                                                                        .removeDayToMensCycle(
                                                                            daysItem,
                                                                            _model.cycles
                                                                                .toList())
                                                                        .toList()
                                                                        .cast<
                                                                            MonthCycleStruct>();
                                                                    safeSetState(
                                                                        () {});
                                                                  },
                                                                  add:
                                                                      () async {
                                                                    logFirebaseEvent(
                                                                        'CALENDAR_MONTHS_Container_xzb7xmks_CALLB');
                                                                    logFirebaseEvent(
                                                                        'monthDay_update_page_state');
                                                                    _model.cycles = functions
                                                                        .addDayToMensCycle(
                                                                            _model.cycles
                                                                                .toList(),
                                                                            daysItem,
                                                                            widget!
                                                                                .duration,
                                                                            widget!
                                                                                .length)
                                                                        .toList()
                                                                        .cast<
                                                                            MonthCycleStruct>();
                                                                    safeSetState(
                                                                        () {});
                                                                  },
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ].divide(SizedBox(height: 4.0)),
                                              ),
                                            ),
                                          );
                                        })
                                            .divide(SizedBox(height: 10.0))
                                            .addToStart(SizedBox(height: 24.0))
                                            .addToEnd(SizedBox(height: 120.0)),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (_model.edit)
                        Align(
                          alignment: AlignmentDirectional(0.0, -1.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 120.0, 20.0, 0.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 12.0,
                                  sigmaY: 12.0,
                                ),
                                child: Visibility(
                                  visible: _model.edit,
                                  child: Container(
                                    width: double.infinity,
                                    height: 32.0,
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).white12,
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .white12,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 8.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Text(
                                                'пн',
                                                style:
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
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Text(
                                                'вт',
                                                style:
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
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Text(
                                                'ср',
                                                style:
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
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Text(
                                                'чт',
                                                style:
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
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Text(
                                                'пт',
                                                style:
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
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Text(
                                                'сб',
                                                style:
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
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Text(
                                                'вс',
                                                style:
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
                                              ),
                                            ),
                                          ),
                                        ]
                                            .addToStart(SizedBox(width: 8.0))
                                            .addToEnd(SizedBox(width: 8.0)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 1.0),
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: 600.0,
                          ),
                          decoration: BoxDecoration(),
                          child: Builder(
                            builder: (context) {
                              if (_model.edit) {
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 48.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            logFirebaseEvent(
                                                'CALENDAR_MONTHS_PAGE_PAGE__BTN_ON_TAP');
                                            logFirebaseEvent(
                                                'Button_update_page_state');
                                            _model.edit = false;
                                            _model.cycles = functions
                                                .calendarMonths(
                                                    widget!.monthCyles
                                                        ?.toList(),
                                                    widget!.fisrtdate,
                                                    widget!.length,
                                                    widget!.duration)
                                                .toList()
                                                .cast<MonthCycleStruct>();
                                            safeSetState(() {});
                                          },
                                          text: 'ОТМЕНА',
                                          options: FFButtonOptions(
                                            width: 50.0,
                                            height: 56.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .white24,
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
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .white12,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(56.0),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            logFirebaseEvent(
                                                'CALENDAR_MONTHS_PAGE_PAGE__BTN_ON_TAP');
                                            logFirebaseEvent(
                                                'Button_update_page_state');
                                            _model.edit = false;
                                            safeSetState(() {});
                                            logFirebaseEvent(
                                                'Button_backend_call');
                                            unawaited(
                                              () async {
                                                await widget!.calendarRef!
                                                    .update({
                                                  ...mapToFirestore(
                                                    {
                                                      'monthCycles':
                                                          getMonthCycleListFirestoreData(
                                                        _model.cycles,
                                                      ),
                                                    },
                                                  ),
                                                });
                                              }(),
                                            );
                                          },
                                          text: 'СОХРАНИТЬ',
                                          options: FFButtonOptions(
                                            width: 50.0,
                                            height: 56.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .white24,
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
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .white12,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(56.0),
                                          ),
                                        ),
                                      ),
                                    ]
                                        .divide(SizedBox(width: 12.0))
                                        .addToStart(SizedBox(width: 20.0))
                                        .addToEnd(SizedBox(width: 20.0)),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 20.0, 48.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(56.0),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 12.0,
                                        sigmaY: 12.0,
                                      ),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          logFirebaseEvent(
                                              'CALENDAR_MONTHS_PAGE_PAGE____BTN_ON_TAP');
                                          logFirebaseEvent(
                                              'Button_update_page_state');
                                          _model.edit = true;
                                          safeSetState(() {});
                                        },
                                        text: 'ИЗМЕНИТЬ ДАТЫ МЕСЯЧНЫХ',
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
                                              .white24,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .titleSmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmallFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                fontSize: 17.0,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .titleSmallIsCustom,
                                              ),
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .white12,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(56.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
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
