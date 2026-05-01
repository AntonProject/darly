import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'days_dropdown_dialog_model.dart';
export 'days_dropdown_dialog_model.dart';

class DaysDropdownDialogWidget extends StatefulWidget {
  const DaysDropdownDialogWidget({
    super.key,
    required this.select,
    int? max,
  }) : this.max = max ?? 30;

  final Future Function(int days)? select;
  final int max;

  @override
  State<DaysDropdownDialogWidget> createState() =>
      _DaysDropdownDialogWidgetState();
}

class _DaysDropdownDialogWidgetState extends State<DaysDropdownDialogWidget> {
  late DaysDropdownDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DaysDropdownDialogModel());

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
        logFirebaseEvent('DAYS_DROPDOWN_DIALOG_Column_wu12zjuv_ON_');
        logFirebaseEvent('Column_close_dialog_drawer_etc');
        Navigator.pop(context);
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 70.0, 20.0, 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 12.0,
                  sigmaY: 12.0,
                ),
                child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    minHeight: 56.0,
                    maxWidth: 600.0,
                    maxHeight: 230.0,
                  ),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                  ),
                  child: Builder(
                    builder: (context) {
                      final days = functions.daysList(widget!.max).toList();

                      return ListView.builder(
                        padding: EdgeInsets.fromLTRB(
                          0,
                          6.0,
                          0,
                          6.0,
                        ),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: days.length,
                        itemBuilder: (context, daysIndex) {
                          final daysItem = days[daysIndex];
                          return Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 2.0, 0.0, 2.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                logFirebaseEvent(
                                    'DAYS_DROPDOWN_DIALOG_Row_xzjzpp2r_ON_TAP');
                                logFirebaseEvent('Row_haptic_feedback');
                                HapticFeedback.lightImpact();
                                logFirebaseEvent('Row_execute_callback');
                                await widget.select?.call(
                                  daysItem,
                                );
                                logFirebaseEvent('Row_close_dialog_drawer_etc');
                                Navigator.pop(context);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 8.0),
                                    child: Text(
                                      valueOrDefault<String>(
                                        daysItem.toString(),
                                        '-',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyLargeFamily,
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            lineHeight: 1.4,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodyLargeIsCustom,
                                          ),
                                    ),
                                  ),
                                ],
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
    );
  }
}
