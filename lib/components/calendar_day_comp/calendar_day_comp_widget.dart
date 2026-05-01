import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'calendar_day_comp_model.dart';
export 'calendar_day_comp_model.dart';

class CalendarDayCompWidget extends StatefulWidget {
  const CalendarDayCompWidget({
    super.key,
    this.cycles,
    required this.day,
    required this.selectedDay,
    required this.update,
  });

  final List<MonthCycleStruct>? cycles;
  final DateTime? day;
  final DateTime? selectedDay;
  final Future Function(DateTime day)? update;

  @override
  State<CalendarDayCompWidget> createState() => _CalendarDayCompWidgetState();
}

class _CalendarDayCompWidgetState extends State<CalendarDayCompWidget> {
  late CalendarDayCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CalendarDayCompModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        logFirebaseEvent('CALENDAR_DAY_ConditionalBuilder_u5kudllb');
        logFirebaseEvent('ConditionalBuilder_execute_callback');
        await widget.update?.call(
          widget!.day!,
        );
      },
      child: Builder(
        builder: (context) {
          if (functions.mensDayInDays(widget!.cycles!.toList(), widget!.day!)) {
            return Builder(
              builder: (context) {
                if (dateTimeFormat(
                      "d/M/y",
                      widget!.day,
                      locale: FFLocalizations.of(context).languageCode,
                    ) ==
                    dateTimeFormat(
                      "d/M/y",
                      getCurrentTimestamp,
                      locale: FFLocalizations.of(context).languageCode,
                    )) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(32.0),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).mens,
                        width: 1.0,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Container(
                        width: 44.0,
                        height: 56.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).mens,
                          borderRadius: BorderRadius.circular(32.0),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).white12,
                            width: 1.0,
                          ),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Text(
                            valueOrDefault<String>(
                              dateTimeFormat(
                                "d",
                                widget!.day,
                                locale:
                                    FFLocalizations.of(context).languageCode,
                              ),
                              '1',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .titleMediumFamily,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 17.0,
                                  letterSpacing: 0.0,
                                  lineHeight: 1.2,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .titleMediumIsCustom,
                                ),
                          ),
                        ),
                      ),
                    ),
                  );
                } else if ((widget!.day! < getCurrentTimestamp) &&
                    functions.mensDayInDays(
                        widget!.cycles!.toList(), widget!.day!)) {
                  return Container(
                    width: 44.0,
                    height: 56.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: Image.asset(
                          'assets/images/Calendar7.png',
                        ).image,
                      ),
                      borderRadius: BorderRadius.circular(32.0),
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Text(
                        valueOrDefault<String>(
                          dateTimeFormat(
                            "d",
                            widget!.day,
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                          '1',
                        ),
                        style: FlutterFlowTheme.of(context)
                            .titleMedium
                            .override(
                              fontFamily: FlutterFlowTheme.of(context)
                                  .titleMediumFamily,
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 17.0,
                              letterSpacing: 0.0,
                              lineHeight: 1.2,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .titleMediumIsCustom,
                            ),
                      ),
                    ),
                  );
                } else {
                  return Container(
                    width: 44.0,
                    height: 56.0,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: Image.asset(
                          'assets/images/CalendarDay1.webp',
                        ).image,
                      ),
                      borderRadius: BorderRadius.circular(32.0),
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Text(
                        valueOrDefault<String>(
                          dateTimeFormat(
                            "d",
                            widget!.day,
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                          '1',
                        ),
                        style: FlutterFlowTheme.of(context)
                            .titleMedium
                            .override(
                              fontFamily: FlutterFlowTheme.of(context)
                                  .titleMediumFamily,
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 17.0,
                              letterSpacing: 0.0,
                              lineHeight: 1.2,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .titleMediumIsCustom,
                            ),
                      ),
                    ),
                  );
                }
              },
            );
          } else if (valueOrDefault<bool>(
            functions.ovulationDayInDays(
                widget!.day!, widget!.cycles!.toList()),
            false,
          )) {
            return Builder(
              builder: (context) {
                if (functions.ovulationCentralDayInDays(
                        widget!.day!, widget!.cycles!.toList()) &&
                    (dateTimeFormat(
                          "d/M/y",
                          widget!.day,
                          locale: FFLocalizations.of(context).languageCode,
                        ) ==
                        dateTimeFormat(
                          "d/M/y",
                          getCurrentTimestamp,
                          locale: FFLocalizations.of(context).languageCode,
                        ))) {
                  return Container(
                    width: 56.0,
                    height: 56.0,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: Image.asset(
                          'assets/images/Calendar8.png',
                        ).image,
                      ),
                      borderRadius: BorderRadius.circular(32.0),
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Text(
                        valueOrDefault<String>(
                          dateTimeFormat(
                            "d",
                            widget!.day,
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                          '1',
                        ),
                        style: FlutterFlowTheme.of(context)
                            .titleMedium
                            .override(
                              fontFamily: FlutterFlowTheme.of(context)
                                  .titleMediumFamily,
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 17.0,
                              letterSpacing: 0.0,
                              lineHeight: 1.2,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .titleMediumIsCustom,
                            ),
                      ),
                    ),
                  );
                } else if (functions.ovulationCentralDayInDays(
                        widget!.day!, widget!.cycles!.toList()) &&
                    (dateTimeFormat(
                          "d/M/y",
                          widget!.day,
                          locale: FFLocalizations.of(context).languageCode,
                        ) !=
                        dateTimeFormat(
                          "d/M/y",
                          getCurrentTimestamp,
                          locale: FFLocalizations.of(context).languageCode,
                        ))) {
                  return Container(
                    width: 56.0,
                    height: 56.0,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: Image.asset(
                          'assets/images/CalendarDay2.webp',
                        ).image,
                      ),
                      borderRadius: BorderRadius.circular(32.0),
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Text(
                        valueOrDefault<String>(
                          dateTimeFormat(
                            "d",
                            widget!.day,
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                          '1',
                        ),
                        style: FlutterFlowTheme.of(context)
                            .titleMedium
                            .override(
                              fontFamily: FlutterFlowTheme.of(context)
                                  .titleMediumFamily,
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 17.0,
                              letterSpacing: 0.0,
                              lineHeight: 1.2,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .titleMediumIsCustom,
                            ),
                      ),
                    ),
                  );
                } else if ((dateTimeFormat(
                          "d/M/y",
                          widget!.day,
                          locale: FFLocalizations.of(context).languageCode,
                        ) ==
                        dateTimeFormat(
                          "d/M/y",
                          getCurrentTimestamp,
                          locale: FFLocalizations.of(context).languageCode,
                        )) &&
                    !functions.ovulationCentralDayInDays(
                        widget!.day!, widget!.cycles!.toList())) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(32.0),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).ovulation,
                        width: 1.0,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Container(
                        width: 44.0,
                        height: 56.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).ovulation,
                          borderRadius: BorderRadius.circular(32.0),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).white12,
                            width: 1.0,
                          ),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Text(
                            valueOrDefault<String>(
                              dateTimeFormat(
                                "d",
                                widget!.day,
                                locale:
                                    FFLocalizations.of(context).languageCode,
                              ),
                              '1',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .titleMediumFamily,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 17.0,
                                  letterSpacing: 0.0,
                                  lineHeight: 1.2,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .titleMediumIsCustom,
                                ),
                          ),
                        ),
                      ),
                    ),
                  );
                } else if ((widget!.day! < getCurrentTimestamp) &&
                    functions.ovulationDayInDays(
                        widget!.day!, widget!.cycles!.toList())) {
                  return Container(
                    width: 44.0,
                    height: 56.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).ovulation,
                      borderRadius: BorderRadius.circular(32.0),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).white12,
                        width: 1.0,
                      ),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Text(
                        valueOrDefault<String>(
                          dateTimeFormat(
                            "d",
                            widget!.day,
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                          '1',
                        ),
                        style: FlutterFlowTheme.of(context)
                            .titleMedium
                            .override(
                              fontFamily: FlutterFlowTheme.of(context)
                                  .titleMediumFamily,
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 17.0,
                              letterSpacing: 0.0,
                              lineHeight: 1.2,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .titleMediumIsCustom,
                            ),
                      ),
                    ),
                  );
                } else {
                  return Container(
                    width: 44.0,
                    height: 56.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: Image.asset(
                          'assets/images/Calendar6.png',
                        ).image,
                      ),
                      borderRadius: BorderRadius.circular(32.0),
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Text(
                        valueOrDefault<String>(
                          dateTimeFormat(
                            "d",
                            widget!.day,
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                          '1',
                        ),
                        style: FlutterFlowTheme.of(context)
                            .titleMedium
                            .override(
                              fontFamily: FlutterFlowTheme.of(context)
                                  .titleMediumFamily,
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 17.0,
                              letterSpacing: 0.0,
                              lineHeight: 1.2,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .titleMediumIsCustom,
                            ),
                      ),
                    ),
                  );
                }
              },
            );
          } else {
            return Builder(
              builder: (context) {
                if (dateTimeFormat(
                      "d/M/y",
                      widget!.day,
                      locale: FFLocalizations.of(context).languageCode,
                    ) ==
                    dateTimeFormat(
                      "d/M/y",
                      widget!.selectedDay,
                      locale: FFLocalizations.of(context).languageCode,
                    )) {
                  return Container(
                    width: 44.0,
                    height: 56.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryText,
                      borderRadius: BorderRadius.circular(32.0),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).white24,
                        width: 1.0,
                      ),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Text(
                        valueOrDefault<String>(
                          dateTimeFormat(
                            "d",
                            widget!.day,
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                          '1',
                        ),
                        style:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .titleMediumFamily,
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  fontSize: 17.0,
                                  letterSpacing: 0.0,
                                  lineHeight: 1.2,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .titleMediumIsCustom,
                                ),
                      ),
                    ),
                  );
                } else {
                  return Container(
                    width: 44.0,
                    height: 56.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).white12,
                      borderRadius: BorderRadius.circular(32.0),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).white12,
                        width: 1.0,
                      ),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Text(
                        valueOrDefault<String>(
                          dateTimeFormat(
                            "d",
                            widget!.day,
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                          '1',
                        ),
                        style: FlutterFlowTheme.of(context)
                            .titleMedium
                            .override(
                              fontFamily: FlutterFlowTheme.of(context)
                                  .titleMediumFamily,
                              color: valueOrDefault<Color>(
                                dateTimeFormat(
                                          "yM",
                                          widget!.day,
                                          locale: FFLocalizations.of(context)
                                              .languageCode,
                                        ) ==
                                        dateTimeFormat(
                                          "yM",
                                          getCurrentTimestamp,
                                          locale: FFLocalizations.of(context)
                                              .languageCode,
                                        )
                                    ? FlutterFlowTheme.of(context).primaryText
                                    : FlutterFlowTheme.of(context)
                                        .secondaryText,
                                FlutterFlowTheme.of(context).primaryText,
                              ),
                              fontSize: 17.0,
                              letterSpacing: 0.0,
                              lineHeight: 1.2,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .titleMediumIsCustom,
                            ),
                      ),
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
