import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'month_day_model.dart';
export 'month_day_model.dart';

class MonthDayWidget extends StatefulWidget {
  const MonthDayWidget({
    super.key,
    required this.day,
    required this.month,
    bool? edit,
    required this.remove,
    required this.add,
    required this.cycleList,
  }) : this.edit = edit ?? false;

  final DateTime? day;
  final DateTime? month;
  final bool edit;
  final Future Function()? remove;
  final Future Function()? add;
  final List<MonthCycleStruct>? cycleList;

  @override
  State<MonthDayWidget> createState() => _MonthDayWidgetState();
}

class _MonthDayWidgetState extends State<MonthDayWidget> {
  late MonthDayModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MonthDayModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (dateTimeFormat(
              "MMMM",
              widget!.day,
              locale: FFLocalizations.of(context).languageCode,
            ) ==
            dateTimeFormat(
              "MMMM",
              widget!.month,
              locale: FFLocalizations.of(context).languageCode,
            )) {
          return Builder(
            builder: (context) {
              if (widget!.edit) {
                return Builder(
                  builder: (context) {
                    if (functions.mensDayInDays(
                        widget!.cycleList!.toList(), widget!.day!)) {
                      return InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          logFirebaseEvent(
                              'MONTH_DAY_COMP_Container_fkzv0eze_ON_TAP');
                          if (dateTimeFormat(
                                "MMMM",
                                widget!.day,
                                locale:
                                    FFLocalizations.of(context).languageCode,
                              ) ==
                              dateTimeFormat(
                                "MMMM",
                                widget!.month,
                                locale:
                                    FFLocalizations.of(context).languageCode,
                              )) {
                            logFirebaseEvent('Container_execute_callback');
                            await widget.remove?.call();
                          }
                        },
                        child: Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).error,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1.0,
                            ),
                          ),
                          child: Icon(
                            FFIcons.kcheckMini,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                        ),
                      );
                    } else {
                      return InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          logFirebaseEvent(
                              'MONTH_DAY_COMP_Container_wytdj3ve_ON_TAP');
                          if (dateTimeFormat(
                                "MMMM",
                                widget!.day,
                                locale:
                                    FFLocalizations.of(context).languageCode,
                              ) ==
                              dateTimeFormat(
                                "MMMM",
                                widget!.month,
                                locale:
                                    FFLocalizations.of(context).languageCode,
                              )) {
                            logFirebaseEvent('Container_execute_callback');
                            await widget.add?.call();
                          }
                        },
                        child: Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).white12,
                            shape: BoxShape.circle,
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
                              maxLines: 1,
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .titleMediumFamily,
                                    color: valueOrDefault<Color>(
                                      dateTimeFormat(
                                                "yM",
                                                widget!.day,
                                                locale:
                                                    FFLocalizations.of(context)
                                                        .languageCode,
                                              ) ==
                                              dateTimeFormat(
                                                "yM",
                                                getCurrentTimestamp,
                                                locale:
                                                    FFLocalizations.of(context)
                                                        .languageCode,
                                              )
                                          ? FlutterFlowTheme.of(context)
                                              .primaryText
                                          : FlutterFlowTheme.of(context)
                                              .secondaryText,
                                      FlutterFlowTheme.of(context).primaryText,
                                    ),
                                    fontSize: 17.0,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .titleMediumIsCustom,
                                  ),
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
                          "MMyyyy",
                          widget!.month,
                          locale: FFLocalizations.of(context).languageCode,
                        ) ==
                        dateTimeFormat(
                          "MMyyyy",
                          getCurrentTimestamp,
                          locale: FFLocalizations.of(context).languageCode,
                        )) {
                      return Builder(
                        builder: (context) {
                          if (functions.ovulationCentralDayInDays(
                              widget!.day!, widget!.cycleList!.toList())) {
                            return Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: Image.asset(
                                    'assets/images/CalendarDay2.webp',
                                  ).image,
                                ),
                                shape: BoxShape.circle,
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
                                      locale: FFLocalizations.of(context)
                                          .languageCode,
                                    ),
                                    '1',
                                  ),
                                  maxLines: 1,
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .titleMediumFamily,
                                        color: valueOrDefault<Color>(
                                          dateTimeFormat(
                                                    "yM",
                                                    widget!.day,
                                                    locale: FFLocalizations.of(
                                                            context)
                                                        .languageCode,
                                                  ) ==
                                                  dateTimeFormat(
                                                    "yM",
                                                    getCurrentTimestamp,
                                                    locale: FFLocalizations.of(
                                                            context)
                                                        .languageCode,
                                                  )
                                              ? FlutterFlowTheme.of(context)
                                                  .primaryText
                                              : FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                        fontSize: 17.0,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .titleMediumIsCustom,
                                      ),
                                ),
                              ),
                            );
                          } else if (functions.ovulationDayInDays(
                              widget!.day!, widget!.cycleList!.toList())) {
                            return Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).ovulation,
                                shape: BoxShape.circle,
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
                                      locale: FFLocalizations.of(context)
                                          .languageCode,
                                    ),
                                    '1',
                                  ),
                                  maxLines: 1,
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .titleMediumFamily,
                                        color: valueOrDefault<Color>(
                                          dateTimeFormat(
                                                    "yM",
                                                    widget!.day,
                                                    locale: FFLocalizations.of(
                                                            context)
                                                        .languageCode,
                                                  ) ==
                                                  dateTimeFormat(
                                                    "yM",
                                                    getCurrentTimestamp,
                                                    locale: FFLocalizations.of(
                                                            context)
                                                        .languageCode,
                                                  )
                                              ? FlutterFlowTheme.of(context)
                                                  .primaryText
                                              : FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                        fontSize: 17.0,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .titleMediumIsCustom,
                                      ),
                                ),
                              ),
                            );
                          } else if (functions.mensDayInDays(
                              widget!.cycleList!.toList(), widget!.day!)) {
                            return Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).primary,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.transparent,
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
                                      locale: FFLocalizations.of(context)
                                          .languageCode,
                                    ),
                                    '1',
                                  ),
                                  maxLines: 1,
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .titleMediumFamily,
                                        color: valueOrDefault<Color>(
                                          dateTimeFormat(
                                                    "yM",
                                                    widget!.day,
                                                    locale: FFLocalizations.of(
                                                            context)
                                                        .languageCode,
                                                  ) ==
                                                  dateTimeFormat(
                                                    "yM",
                                                    getCurrentTimestamp,
                                                    locale: FFLocalizations.of(
                                                            context)
                                                        .languageCode,
                                                  )
                                              ? FlutterFlowTheme.of(context)
                                                  .primaryText
                                              : FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                        fontSize: 17.0,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .titleMediumIsCustom,
                                      ),
                                ),
                              ),
                            );
                          } else {
                            return ClipOval(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 12.0,
                                  sigmaY: 12.0,
                                ),
                                child: Container(
                                  width: 40.0,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).white12,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color:
                                          FlutterFlowTheme.of(context).white12,
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
                                          locale: FFLocalizations.of(context)
                                              .languageCode,
                                        ),
                                        '1',
                                      ),
                                      maxLines: 1,
                                      style: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .titleMediumFamily,
                                            color: valueOrDefault<Color>(
                                              dateTimeFormat(
                                                        "yM",
                                                        widget!.day,
                                                        locale:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .languageCode,
                                                      ) ==
                                                      dateTimeFormat(
                                                        "yM",
                                                        getCurrentTimestamp,
                                                        locale:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .languageCode,
                                                      )
                                                  ? FlutterFlowTheme.of(context)
                                                      .primaryText
                                                  : FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                            ),
                                            fontSize: 17.0,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .titleMediumIsCustom,
                                          ),
                                    ),
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
                          if (functions.ovulationCentralDayInDays(
                              widget!.day!, widget!.cycleList!.toList())) {
                            return Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: Image.asset(
                                    'assets/images/CalendarDay3.webp',
                                  ).image,
                                ),
                                shape: BoxShape.circle,
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
                                      locale: FFLocalizations.of(context)
                                          .languageCode,
                                    ),
                                    '1',
                                  ),
                                  maxLines: 1,
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .titleMediumFamily,
                                        color: valueOrDefault<Color>(
                                          dateTimeFormat(
                                                    "yM",
                                                    widget!.day,
                                                    locale: FFLocalizations.of(
                                                            context)
                                                        .languageCode,
                                                  ) ==
                                                  dateTimeFormat(
                                                    "yM",
                                                    getCurrentTimestamp,
                                                    locale: FFLocalizations.of(
                                                            context)
                                                        .languageCode,
                                                  )
                                              ? FlutterFlowTheme.of(context)
                                                  .primaryText
                                              : FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                        fontSize: 17.0,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .titleMediumIsCustom,
                                      ),
                                ),
                              ),
                            );
                          } else if (functions.ovulationDayInDays(
                              widget!.day!, widget!.cycleList!.toList())) {
                            return Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: Image.asset(
                                    'assets/images/CalendarDay5.webp',
                                  ).image,
                                ),
                                shape: BoxShape.circle,
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
                                      locale: FFLocalizations.of(context)
                                          .languageCode,
                                    ),
                                    '1',
                                  ),
                                  maxLines: 1,
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .titleMediumFamily,
                                        color: valueOrDefault<Color>(
                                          dateTimeFormat(
                                                    "yM",
                                                    widget!.day,
                                                    locale: FFLocalizations.of(
                                                            context)
                                                        .languageCode,
                                                  ) ==
                                                  dateTimeFormat(
                                                    "yM",
                                                    getCurrentTimestamp,
                                                    locale: FFLocalizations.of(
                                                            context)
                                                        .languageCode,
                                                  )
                                              ? FlutterFlowTheme.of(context)
                                                  .primaryText
                                              : FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                        fontSize: 17.0,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .titleMediumIsCustom,
                                      ),
                                ),
                              ),
                            );
                          } else if (functions.mensDayInDays(
                              widget!.cycleList!.toList(), widget!.day!)) {
                            return Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: Image.asset(
                                    'assets/images/CalendarDay4.webp',
                                  ).image,
                                ),
                                shape: BoxShape.circle,
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
                                      locale: FFLocalizations.of(context)
                                          .languageCode,
                                    ),
                                    '1',
                                  ),
                                  maxLines: 1,
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .titleMediumFamily,
                                        color: valueOrDefault<Color>(
                                          dateTimeFormat(
                                                    "yM",
                                                    widget!.day,
                                                    locale: FFLocalizations.of(
                                                            context)
                                                        .languageCode,
                                                  ) ==
                                                  dateTimeFormat(
                                                    "yM",
                                                    getCurrentTimestamp,
                                                    locale: FFLocalizations.of(
                                                            context)
                                                        .languageCode,
                                                  )
                                              ? FlutterFlowTheme.of(context)
                                                  .primaryText
                                              : FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                        fontSize: 17.0,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .titleMediumIsCustom,
                                      ),
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).white12,
                                shape: BoxShape.circle,
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
                                      locale: FFLocalizations.of(context)
                                          .languageCode,
                                    ),
                                    '1',
                                  ),
                                  maxLines: 1,
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .titleMediumFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .white24,
                                        fontSize: 17.0,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
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
                );
              }
            },
          );
        } else {
          return Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.transparent,
                width: 1.0,
              ),
            ),
          );
        }
      },
    );
  }
}
