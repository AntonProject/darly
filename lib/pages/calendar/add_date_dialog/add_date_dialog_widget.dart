import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'add_date_dialog_model.dart';
export 'add_date_dialog_model.dart';

class AddDateDialogWidget extends StatefulWidget {
  const AddDateDialogWidget({
    super.key,
    required this.cyclyList,
    required this.day,
    required this.updateDate,
  });

  final List<MonthCycleStruct>? cyclyList;
  final DateTime? day;
  final Future Function()? updateDate;

  @override
  State<AddDateDialogWidget> createState() => _AddDateDialogWidgetState();
}

class _AddDateDialogWidgetState extends State<AddDateDialogWidget> {
  late AddDateDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddDateDialogModel());

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
        logFirebaseEvent('ADD_DATE_DIALOG_Column_pwfh4sto_ON_TAP');
        logFirebaseEvent('Column_close_dialog_drawer_etc');
        Navigator.pop(context);
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: 279.0,
            ),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondary,
              boxShadow: [
                BoxShadow(
                  blurRadius: 24.0,
                  color: Color(0x33000000),
                  offset: Offset(
                    0.0,
                    0.0,
                  ),
                )
              ],
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 20.0),
                    child: Text(
                      'Добавить менструацию ${valueOrDefault<String>(
                        dateTimeFormat(
                          "dd MMMM",
                          widget!.day,
                          locale: FFLocalizations.of(context).languageCode,
                        ),
                        '-',
                      )}?',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleMediumFamily,
                            fontSize: 17.0,
                            letterSpacing: 0.0,
                            lineHeight: 1.4,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .titleMediumIsCustom,
                          ),
                    ),
                  ),
                  Divider(
                    height: 1.0,
                    thickness: 1.0,
                    color: FlutterFlowTheme.of(context).tertiary,
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      logFirebaseEvent('ADD_DATE_DIALOG_COMP___BTN_ON_TAP');
                      logFirebaseEvent('Button_haptic_feedback');
                      HapticFeedback.heavyImpact();
                      logFirebaseEvent('Button_execute_callback');
                      await widget.updateDate?.call();
                      logFirebaseEvent('Button_close_dialog_drawer_etc');
                      Navigator.pop(context);
                    },
                    text: 'Да, добавить',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 44.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: Colors.transparent,
                      textStyle: FlutterFlowTheme.of(context)
                          .titleLarge
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleLargeFamily,
                            color: FlutterFlowTheme.of(context).primary,
                            fontSize: 17.0,
                            letterSpacing: 0.0,
                            lineHeight: 1.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .titleLargeIsCustom,
                          ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.only(),
                    ),
                    showLoadingIndicator: false,
                  ),
                  Divider(
                    height: 1.0,
                    thickness: 1.0,
                    color: FlutterFlowTheme.of(context).tertiary,
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      logFirebaseEvent('ADD_DATE_DIALOG_COMP__BTN_ON_TAP');
                      logFirebaseEvent('Button_haptic_feedback');
                      HapticFeedback.mediumImpact();
                      logFirebaseEvent('Button_close_dialog_drawer_etc');
                      Navigator.pop(context);
                    },
                    text: 'Отмена',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 44.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: Colors.transparent,
                      textStyle: FlutterFlowTheme.of(context)
                          .titleMedium
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleMediumFamily,
                            color: FlutterFlowTheme.of(context).primary,
                            fontSize: 17.0,
                            letterSpacing: 0.0,
                            lineHeight: 1.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .titleMediumIsCustom,
                          ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12.0),
                        bottomRight: Radius.circular(12.0),
                      ),
                    ),
                    showLoadingIndicator: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
