import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/back_button/back_button_widget.dart';
import '/components/calendar_day_comp/calendar_day_comp_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/add_start_date_dialog/add_start_date_dialog_widget.dart';
import '/pages/calendar/add_end_date_dialog/add_end_date_dialog_widget.dart';
import '/pages/calendar/edit_cycle_length/edit_cycle_length_widget.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'calendar_page_model.dart';
export 'calendar_page_model.dart';

class CalendarPageWidget extends StatefulWidget {
  const CalendarPageWidget({
    super.key,
    required this.calendarUser,
  });

  final DocumentReference? calendarUser;

  static String routeName = 'CalendarPage';
  static String routePath = '/calendarPage';

  @override
  State<CalendarPageWidget> createState() => _CalendarPageWidgetState();
}

class _CalendarPageWidgetState extends State<CalendarPageWidget> {
  late CalendarPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CalendarPageModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'CalendarPage'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('CALENDAR_CalendarPage_ON_INIT_STATE');
      logFirebaseEvent('CalendarPage_update_page_state');
      _model.selectedDate = getCurrentTimestamp;
      safeSetState(() {});
      logFirebaseEvent('CalendarPage_custom_action');
      unawaited(
        () async {
          await actions.setStatusBarColor();
        }(),
      );
      logFirebaseEvent('CalendarPage_custom_action');
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
        title: 'CalendarPage',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: StreamBuilder<CalendarRecord>(
              stream: CalendarRecord.getDocument(widget!.calendarUser!),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      width: 20.0,
                      height: 20.0,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                    ),
                  );
                }

                final containerCalendarRecord = snapshot.data!;

                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: Image.asset(
                        'assets/images/Page-Calendar.webp',
                      ).image,
                    ),
                  ),
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
                                          model: _model.backButtonModel1,
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
                                                  'CALENDAR_Container_2pr3div0_CALLBACK');
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
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 12.0, 0.0),
                                        child: wrapWithModel(
                                          model: _model.backButtonModel2,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: BackButtonWidget(
                                            icon: Icon(
                                              FFIcons.kcalendar1,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 24.0,
                                            ),
                                            action: () async {
                                              logFirebaseEvent(
                                                  'CALENDAR_Container_ad4f6vpd_CALLBACK');
                                              logFirebaseEvent(
                                                  'backButton_navigate_to');

                                              context.pushNamed(
                                                CalendarMonthsPageWidget
                                                    .routeName,
                                                queryParameters: {
                                                  'monthCyles': serializeParam(
                                                    containerCalendarRecord
                                                        .monthCycles,
                                                    ParamType.DataStruct,
                                                    isList: true,
                                                  ),
                                                  'calendarRef': serializeParam(
                                                    widget!.calendarUser,
                                                    ParamType.DocumentReference,
                                                  ),
                                                  'duration': serializeParam(
                                                    containerCalendarRecord
                                                        .duration,
                                                    ParamType.int,
                                                  ),
                                                  'length': serializeParam(
                                                    containerCalendarRecord
                                                        .lengthCycle,
                                                    ParamType.int,
                                                  ),
                                                  'fisrtdate': serializeParam(
                                                    containerCalendarRecord
                                                        .firsDate,
                                                    ParamType.DateTime,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
                                      0.0, 8.0, 0.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          Builder(
                                            builder: (context) {
                                              if (valueOrDefault<String>(
                                                    functions.cyclePhase(
                                                        containerCalendarRecord
                                                            .monthCycles
                                                            .toList(),
                                                        _model.selectedDate),
                                                    '-',
                                                  ) ==
                                                  'Овуляция') {
                                                return Container(
                                                  width: 180.0,
                                                  height: 180.0,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Image.asset(
                                                    'assets/images/Moon1.webp',
                                                    fit: BoxFit.cover,
                                                  ),
                                                );
                                              } else if (valueOrDefault<String>(
                                                    functions.cyclePhase(
                                                        containerCalendarRecord
                                                            .monthCycles
                                                            .toList(),
                                                        _model.selectedDate),
                                                    '-',
                                                  ) ==
                                                  'Менструация') {
                                                return Container(
                                                  width: 180.0,
                                                  height: 180.0,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Image.asset(
                                                    'assets/images/Moon4.webp',
                                                    fit: BoxFit.cover,
                                                  ),
                                                );
                                              } else if (valueOrDefault<String>(
                                                    functions.cyclePhase(
                                                        containerCalendarRecord
                                                            .monthCycles
                                                            .toList(),
                                                        _model.selectedDate),
                                                    '-',
                                                  ) ==
                                                  'Фолликулярная') {
                                                return Container(
                                                  width: 180.0,
                                                  height: 180.0,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Image.asset(
                                                    'assets/images/Moon2.webp',
                                                    fit: BoxFit.cover,
                                                  ),
                                                );
                                              } else {
                                                return Container(
                                                  width: 180.0,
                                                  height: 180.0,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Image.asset(
                                                    'assets/images/Moon3.webp',
                                                    fit: BoxFit.cover,
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                          Container(
                                            width: 180.0,
                                            height: 180.0,
                                            decoration: BoxDecoration(
                                              color: Color(0x66CE4390),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 12.0,
                                                  color: Color(0x57000000),
                                                  offset: Offset(
                                                    0.0,
                                                    0.0,
                                                  ),
                                                  spreadRadius: 0.0,
                                                )
                                              ],
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(1.0, 0.0),
                                        child: Container(
                                          height: 110.0,
                                          decoration: BoxDecoration(),
                                          child: Container(
                                            width: double.infinity,
                                            height: 110.0,
                                            child: custom_widgets
                                                .HorizontalDayScroller(
                                              width: double.infinity,
                                              height: 110.0,
                                              selectedDay: _model.selectedDate!,
                                              days: functions.monthDays(
                                                  containerCalendarRecord
                                                      .monthCycles
                                                      .toList()),
                                              dayBuilder: (DateTime day) =>
                                                  CalendarDayCompWidget(
                                                day: day,
                                                selectedDay:
                                                    _model.selectedDate!,
                                                cycles: containerCalendarRecord
                                                    .monthCycles,
                                                update: (day) async {
                                                  logFirebaseEvent(
                                                      'CALENDAR_Container_ax1ywc8b_CALLBACK');
                                                  logFirebaseEvent(
                                                      'HorizontalDayScroller_update_page_state');
                                                  _model.selectedDate = day;
                                                  safeSetState(() {});
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              AutoSizeText(
                                                valueOrDefault<String>(
                                                  dateTimeFormat(
                                                    "dd MMMM yyyy",
                                                    _model.selectedDate,
                                                    locale: FFLocalizations.of(
                                                            context)
                                                        .languageCode,
                                                  ),
                                                  '-',
                                                ),
                                                maxLines: 1,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .override(
                                                          font: GoogleFonts
                                                              .interTight(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          fontSize: 15.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontStyle,
                                                          lineHeight: 1.25,
                                                        ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 4.0, 0.0, 4.0),
                                                child: AutoSizeText(
                                                  '${valueOrDefault<String>(
                                                    functions
                                                        .cycleDay(
                                                            _model
                                                                .selectedDate!,
                                                            containerCalendarRecord
                                                                .monthCycles
                                                                .toList())
                                                        .toString(),
                                                    '0',
                                                  )} ДЕНЬ ЦИКЛА',
                                                  maxLines: 1,
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMediumFamily,
                                                            letterSpacing: 0.0,
                                                            lineHeight: 1.25,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMediumIsCustom,
                                                          ),
                                                ),
                                              ),
                                              AutoSizeText(
                                                'Фаза: ${valueOrDefault<String>(
                                                  functions.cyclePhase(
                                                      containerCalendarRecord
                                                          .monthCycles
                                                          .toList(),
                                                      _model.selectedDate),
                                                  '-',
                                                )}${false ? (functions.ovulationDayInDays(_model.selectedDate!, containerCalendarRecord.monthCycles.toList()) ? ' • ${valueOrDefault<String>(
                                                    functions
                                                        .ovulationDayInDaysNumber(
                                                            _model
                                                                .selectedDate!,
                                                            containerCalendarRecord
                                                                .monthCycles
                                                                .toList())
                                                        .toString(),
                                                    '0',
                                                  )} день' : '') : ''}',
                                                maxLines: 1,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .override(
                                                          font: GoogleFonts
                                                              .interTight(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          fontSize: 15.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontStyle,
                                                          lineHeight: 1.25,
                                                        ),
                                              ),
                                              if (functions
                                                  .ovulationCentralDayInDays(
                                                      _model.selectedDate!,
                                                      containerCalendarRecord
                                                          .monthCycles
                                                          .toList()))
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 4.0, 0.0, 0.0),
                                                  child: AutoSizeText(
                                                    'Высокая вероятность забеременеть',
                                                    maxLines: 1,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyLarge
                                                        .override(
                                                          font: GoogleFonts
                                                              .interTight(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          fontSize: 15.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontStyle,
                                                          lineHeight: 1.25,
                                                        ),
                                                  ),
                                                ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Divider(
                                                    height: 1.0,
                                                    thickness: 1.0,
                                                    indent: 20.0,
                                                    endIndent: 20.0,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .white12,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                20.0,
                                                                16.0,
                                                                20.0,
                                                                16.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              AutoSizeText(
                                                                'Начало',
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                maxLines: 1,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .labelMediumFamily,
                                                                      fontSize:
                                                                          13.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.4,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .labelMediumIsCustom,
                                                                    ),
                                                              ),
                                                              AutoSizeText(
                                                                valueOrDefault<
                                                                    String>(
                                                                  dateTimeFormat(
                                                                    "dd MMMM",
                                                                    functions.startMensDay(
                                                                        containerCalendarRecord
                                                                            .monthCycles
                                                                            .toList(),
                                                                        _model
                                                                            .selectedDate!),
                                                                    locale: FFLocalizations.of(
                                                                            context)
                                                                        .languageCode,
                                                                  ),
                                                                  '-',
                                                                ),
                                                                maxLines: 1,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .titleMediumFamily,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.25,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .titleMediumIsCustom,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              AutoSizeText(
                                                                'Месячные',
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                maxLines: 1,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .labelMediumFamily,
                                                                      fontSize:
                                                                          13.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.4,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .labelMediumIsCustom,
                                                                    ),
                                                              ),
                                                              AutoSizeText(
                                                                valueOrDefault<
                                                                    String>(
                                                                  functions.mensDayText(
                                                                      containerCalendarRecord
                                                                          .monthCycles
                                                                          .toList(),
                                                                      _model
                                                                          .selectedDate!),
                                                                  '-',
                                                                ),
                                                                maxLines: 1,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .titleMediumFamily,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.25,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .titleMediumIsCustom,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              AutoSizeText(
                                                                'Овуляция',
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                maxLines: 1,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .labelMediumFamily,
                                                                      fontSize:
                                                                          13.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.4,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .labelMediumIsCustom,
                                                                    ),
                                                              ),
                                                              AutoSizeText(
                                                                valueOrDefault<
                                                                    String>(
                                                                  functions.ovulationDayText(
                                                                      containerCalendarRecord
                                                                          .monthCycles
                                                                          .toList(),
                                                                      _model
                                                                          .selectedDate!),
                                                                  '-',
                                                                ),
                                                                maxLines: 1,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .titleMediumFamily,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.25,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .titleMediumIsCustom,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ].divide(
                                                          SizedBox(width: 8.0)),
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 1.0,
                                                    thickness: 1.0,
                                                    indent: 20.0,
                                                    endIndent: 20.0,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .white12,
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    height: null,
                                                    child: custom_widgets
                                                        .CycleInfoTimeline(
                                                      width: double.infinity,
                                                      height: null,
                                                      cycles:
                                                          containerCalendarRecord
                                                              .monthCycles,
                                                      phase: valueOrDefault<
                                                          String>(
                                                        functions.cyclePhase(
                                                            containerCalendarRecord
                                                                .monthCycles
                                                                .toList(),
                                                            _model
                                                                .selectedDate),
                                                        '-',
                                                      ),
                                                      selectedDate:
                                                          _model.selectedDate,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 24.0,
                                                                0.0, 0.0),
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
                                                            'CALENDAR_Container_y978qzg7_ON_TAP');
                                                        logFirebaseEvent(
                                                            'Container_bottom_sheet');
                                                        await showModalBottomSheet(
                                                          isScrollControlled:
                                                              true,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          isDismissible: false,
                                                          enableDrag: false,
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
                                                                      EditCycleLengthWidget(
                                                                    listCycles:
                                                                        containerCalendarRecord
                                                                            .monthCycles,
                                                                    length:
                                                                        valueOrDefault<
                                                                            int>(
                                                                      containerCalendarRecord
                                                                          .lengthCycle,
                                                                      0,
                                                                    ),
                                                                    duration:
                                                                        valueOrDefault<
                                                                            int>(
                                                                      containerCalendarRecord
                                                                          .duration,
                                                                      0,
                                                                    ),
                                                                    firstDay:
                                                                        containerCalendarRecord
                                                                            .firsDate!,
                                                                    ref: containerCalendarRecord
                                                                        .reference,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ).then((value) =>
                                                            safeSetState(
                                                                () {}));
                                                      },
                                                      child: Container(
                                                        constraints:
                                                            BoxConstraints(
                                                          minHeight: 40.0,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .white24,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      56.0),
                                                          border: Border.all(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .white12,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      16.0,
                                                                      0.0,
                                                                      16.0,
                                                                      0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Icon(
                                                                FFIcons
                                                                    .ksettings,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                size: 24.0,
                                                              ),
                                                              Text(
                                                                'НАСТРОЙКИ ЦИКЛА',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .titleLargeFamily,
                                                                      fontSize:
                                                                          17.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.25,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .titleLargeIsCustom,
                                                                    ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 4.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ].addToStart(
                                                    SizedBox(height: 16.0)),
                                              ),
                                            ]
                                                .addToStart(
                                                    SizedBox(height: 1.0))
                                                .addToEnd(
                                                    SizedBox(height: 120.0)),
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
                      Align(
                        alignment: AlignmentDirectional(0.0, 1.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(0.0),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 1.0,
                              sigmaY: 3.0,
                            ),
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: 600.0,
                              ),
                              decoration: BoxDecoration(),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 12.0, 20.0, 48.0),
                                child: Builder(
                                  builder: (context) {
                                    if (!functions.mensDayInDays(
                                        containerCalendarRecord.monthCycles
                                            .toList(),
                                        getCurrentTimestamp)) {
                                      return Builder(
                                        builder: (context) => FFButtonWidget(
                                          onPressed: () async {
                                            logFirebaseEvent(
                                                'CALENDAR_PAGE_PAGE___BTN_ON_TAP');
                                            logFirebaseEvent(
                                                'Button_alert_dialog');
                                            await showDialog(
                                              context: context,
                                              builder: (dialogContext) {
                                                return Dialog(
                                                  elevation: 0,
                                                  insetPadding: EdgeInsets.zero,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  alignment:
                                                      AlignmentDirectional(
                                                              0.0, 0.0)
                                                          .resolve(
                                                              Directionality.of(
                                                                  context)),
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
                                                          AddStartDateDialogWidget(
                                                        cyclyList:
                                                            containerCalendarRecord
                                                                .monthCycles,
                                                        day:
                                                            getCurrentTimestamp,
                                                        updateDate: () async {
                                                          logFirebaseEvent(
                                                              '_backend_call');
                                                          unawaited(
                                                            () async {
                                                              await widget!
                                                                  .calendarUser!
                                                                  .update({
                                                                ...mapToFirestore(
                                                                  {
                                                                    'monthCycles':
                                                                        getMonthCycleListFirestoreData(
                                                                      functions.addStartDayToMensCycle(
                                                                          containerCalendarRecord
                                                                              .monthCycles
                                                                              .toList(),
                                                                          getCurrentTimestamp,
                                                                          containerCalendarRecord
                                                                              .lengthCycle,
                                                                          containerCalendarRecord
                                                                              .duration),
                                                                    ),
                                                                  },
                                                                ),
                                                              });
                                                            }(),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          text: 'НАЧАЛО ЦИКЛА',
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
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(56.0),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Builder(
                                        builder: (context) => FFButtonWidget(
                                          onPressed: () async {
                                            logFirebaseEvent(
                                                'CALENDAR_PAGE_PAGE___BTN_ON_TAP');
                                            logFirebaseEvent(
                                                'Button_alert_dialog');
                                            await showDialog(
                                              context: context,
                                              builder: (dialogContext) {
                                                return Dialog(
                                                  elevation: 0,
                                                  insetPadding: EdgeInsets.zero,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  alignment:
                                                      AlignmentDirectional(
                                                              0.0, 0.0)
                                                          .resolve(
                                                              Directionality.of(
                                                                  context)),
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
                                                          AddEndDateDialogWidget(
                                                        cyclyList:
                                                            containerCalendarRecord
                                                                .monthCycles,
                                                        day:
                                                            getCurrentTimestamp,
                                                        updateDate: () async {
                                                          logFirebaseEvent(
                                                              '_backend_call');
                                                          unawaited(
                                                            () async {
                                                              await widget!
                                                                  .calendarUser!
                                                                  .update({
                                                                ...mapToFirestore(
                                                                  {
                                                                    'monthCycles':
                                                                        getMonthCycleListFirestoreData(
                                                                      functions.addEndDayToMensCycle(
                                                                          containerCalendarRecord
                                                                              .monthCycles
                                                                              .toList(),
                                                                          getCurrentTimestamp),
                                                                    ),
                                                                  },
                                                                ),
                                                              });
                                                            }(),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          text: 'ЗАВЕРШИТЬ ЦИКЛ',
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
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }
}
