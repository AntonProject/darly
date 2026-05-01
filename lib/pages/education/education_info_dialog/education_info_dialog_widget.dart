import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'education_info_dialog_model.dart';
export 'education_info_dialog_model.dart';

class EducationInfoDialogWidget extends StatefulWidget {
  const EducationInfoDialogWidget({
    super.key,
    required this.text,
  });

  final String? text;

  @override
  State<EducationInfoDialogWidget> createState() =>
      _EducationInfoDialogWidgetState();
}

class _EducationInfoDialogWidgetState extends State<EducationInfoDialogWidget> {
  late EducationInfoDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EducationInfoDialogModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (responsiveVisibility(
          context: context,
          phone: false,
          tablet: false,
        ))
          Expanded(
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                logFirebaseEvent('EDUCATION_INFO_DIALOG_Column_r7itjwsv_ON');
                logFirebaseEvent('Column_bottom_sheet');
                Navigator.pop(context);
              },
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(32.0),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 12.0,
                          sigmaY: 12.0,
                        ),
                        child: Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                            maxWidth: 600.0,
                            maxHeight: MediaQuery.sizeOf(context).height * 0.8,
                          ),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).white12,
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0.0, -1.0),
                            child: Stack(
                              alignment: AlignmentDirectional(0.0, 1.0),
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(1.0, 0.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 4.0),
                                            child: Container(
                                              width: 32.0,
                                              height: 32.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'ИНФОРМАЦИЯ',
                                          style: FlutterFlowTheme.of(context)
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
                                                fontWeight: FontWeight.w500,
                                                lineHeight: 1.25,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .titleSmallIsCustom,
                                              ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(1.0, -1.0),
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                logFirebaseEvent(
                                                    'EDUCATION_INFO_DIALOG_Container_oa7zdmjz');
                                                logFirebaseEvent(
                                                    'Container_bottom_sheet');
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                width: valueOrDefault<double>(
                                                  () {
                                                    if (MediaQuery.sizeOf(
                                                                context)
                                                            .width <
                                                        kBreakpointSmall) {
                                                      return 32.0;
                                                    } else if (MediaQuery
                                                                .sizeOf(context)
                                                            .width <
                                                        kBreakpointMedium) {
                                                      return 32.0;
                                                    } else if (MediaQuery
                                                                .sizeOf(context)
                                                            .width <
                                                        kBreakpointLarge) {
                                                      return 48.0;
                                                    } else {
                                                      return 48.0;
                                                    }
                                                  }(),
                                                  48.0,
                                                ),
                                                height: valueOrDefault<double>(
                                                  () {
                                                    if (MediaQuery.sizeOf(
                                                                context)
                                                            .width <
                                                        kBreakpointSmall) {
                                                      return 32.0;
                                                    } else if (MediaQuery
                                                                .sizeOf(context)
                                                            .width <
                                                        kBreakpointMedium) {
                                                      return 32.0;
                                                    } else if (MediaQuery
                                                                .sizeOf(context)
                                                            .width <
                                                        kBreakpointLarge) {
                                                      return 48.0;
                                                    } else {
                                                      return 48.0;
                                                    }
                                                  }(),
                                                  48.0,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .white24,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: Colors.transparent,
                                                  ),
                                                ),
                                                child: Icon(
                                                  FFIcons.kcloseIcon,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  size: valueOrDefault<double>(
                                                    () {
                                                      if (MediaQuery.sizeOf(
                                                                  context)
                                                              .width <
                                                          kBreakpointSmall) {
                                                        return 24.0;
                                                      } else if (MediaQuery
                                                                  .sizeOf(
                                                                      context)
                                                              .width <
                                                          kBreakpointMedium) {
                                                        return 24.0;
                                                      } else if (MediaQuery
                                                                  .sizeOf(
                                                                      context)
                                                              .width <
                                                          kBreakpointLarge) {
                                                        return 32.0;
                                                      } else {
                                                        return 32.0;
                                                      }
                                                    }(),
                                                    32.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 8.0)),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 0.0, 20.0, 0.0),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                valueOrDefault<String>(
                                                  widget!.text,
                                                  'Доступ к проекту Woman 4.0 доступен до 31.10.2025 включительноВыпускной Offline обучения Woman 4.0 — 29 июня | МоскваПервый модуль и расписание первой недели уже открыты для Вас.Будьте внимательны, выход первого урока — 26.05.2025Доступы в чаты для 2 и 3 тарифа открыты! Вступить в разделе «Полезные ссылки»',
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyLarge
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyLargeFamily,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary80,
                                                      fontSize: 17.0,
                                                      letterSpacing: 0.0,
                                                      lineHeight: 1.4,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyLargeIsCustom,
                                                    ),
                                              ),
                                            ]
                                                .addToStart(
                                                    SizedBox(height: 16.0))
                                                .addToEnd(
                                                    SizedBox(height: 150.0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ].addToStart(SizedBox(height: 28.0)),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 12.0, 20.0, 48.0),
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
                                              'EDUCATION_INFO_DIALOG_cancelButton_ON_TA');
                                          logFirebaseEvent(
                                              'cancelButton_haptic_feedback');
                                          HapticFeedback.mediumImpact();
                                          logFirebaseEvent(
                                              'cancelButton_bottom_sheet');
                                          Navigator.pop(context);
                                        },
                                        text: 'ЗАКРЫТЬ',
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
                                          elevation: 0.0,
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .white12,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(56.0),
                                        ),
                                        showLoadingIndicator: false,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (responsiveVisibility(
          context: context,
          tabletLandscape: false,
          desktop: false,
        ))
          Expanded(
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                logFirebaseEvent('EDUCATION_INFO_DIALOG_Column_nhk2pibu_ON');
                logFirebaseEvent('Column_bottom_sheet');
                Navigator.pop(context);
              },
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 48.0, 0.0, 8.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        logFirebaseEvent(
                            'EDUCATION_INFO_DIALOG_Container_si6x7lle');
                        logFirebaseEvent('Container_bottom_sheet');
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 48.0,
                        height: 6.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).accent2,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32.0),
                        topRight: Radius.circular(32.0),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 24.0,
                          sigmaY: 24.0,
                        ),
                        child: Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                            maxWidth: 600.0,
                            maxHeight: MediaQuery.sizeOf(context).height * 0.9,
                          ),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).dialog,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32.0),
                              topRight: Radius.circular(32.0),
                            ),
                          ),
                          child: Stack(
                            alignment: AlignmentDirectional(0.0, 1.0),
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(1.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 16.0, 4.0),
                                          child: Container(
                                            width: 32.0,
                                            height: 32.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'ИНФОРМАЦИЯ',
                                        style: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMediumFamily,
                                              fontSize: 17.0,
                                              letterSpacing: 0.0,
                                              lineHeight: 1.25,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .titleMediumIsCustom,
                                            ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(1.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 16.0, 4.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              logFirebaseEvent(
                                                  'EDUCATION_INFO_DIALOG_Container_jrd2v4n1');
                                              logFirebaseEvent(
                                                  'Container_haptic_feedback');
                                              HapticFeedback.mediumImpact();
                                              logFirebaseEvent(
                                                  'Container_bottom_sheet');
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              width: 32.0,
                                              height: 32.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .white24,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                              child: Icon(
                                                FFIcons.kcloseIcon,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: 24.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 8.0)),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 0.0, 20.0, 0.0),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              valueOrDefault<String>(
                                                widget!.text,
                                                '-',
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyLarge
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyLargeFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    fontSize: 17.0,
                                                    letterSpacing: 0.0,
                                                    lineHeight: 1.4,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodyLargeIsCustom,
                                                  ),
                                            ),
                                          ]
                                              .addToStart(
                                                  SizedBox(height: 16.0))
                                              .addToEnd(
                                                  SizedBox(height: 150.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ].addToStart(SizedBox(height: 28.0)),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 12.0, 20.0, 48.0),
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
                                            'EDUCATION_INFO_DIALOG_cancelButton_ON_TA');
                                        logFirebaseEvent(
                                            'cancelButton_haptic_feedback');
                                        HapticFeedback.mediumImpact();
                                        logFirebaseEvent(
                                            'cancelButton_bottom_sheet');
                                        Navigator.pop(context);
                                      },
                                      text: 'ЗАКРЫТЬ',
                                      options: FFButtonOptions(
                                        width: double.infinity,
                                        height: 56.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .accent1,
                                        textStyle: FlutterFlowTheme.of(context)
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
                                                  !FlutterFlowTheme.of(context)
                                                      .titleSmallIsCustom,
                                            ),
                                        elevation: 0.0,
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .white12,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(56.0),
                                      ),
                                      showLoadingIndicator: false,
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
    );
  }
}
