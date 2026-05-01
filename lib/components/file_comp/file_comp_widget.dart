import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'file_comp_model.dart';
export 'file_comp_model.dart';

class FileCompWidget extends StatefulWidget {
  const FileCompWidget({
    super.key,
    required this.fileURL,
    Color? bgColor,
  }) : this.bgColor = bgColor ?? Colors.transparent;

  final String? fileURL;
  final Color bgColor;

  @override
  State<FileCompWidget> createState() => _FileCompWidgetState();
}

class _FileCompWidgetState extends State<FileCompWidget> {
  late FileCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FileCompModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('FILE_COMP_COMP_fileComp_ON_INIT_STATE');
      if (widget!.fileURL != null && widget!.fileURL != '') {
        logFirebaseEvent('fileComp_custom_action');
        _model.file = await actions.getFileMetadataFromStorage(
          widget!.fileURL!,
        );
        logFirebaseEvent('fileComp_update_component_state');
        _model.fileDTstate = _model.file;
        safeSetState(() {});
      }
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
      constraints: BoxConstraints(
        maxWidth: 400.0,
      ),
      decoration: BoxDecoration(
        color: valueOrDefault<Color>(
          widget!.bgColor,
          Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: valueOrDefault<Color>(
            widget!.bgColor,
            Colors.transparent,
          ),
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            logFirebaseEvent('FILE_COMP_COMP_Row_y1pvd66k_ON_TAP');
            logFirebaseEvent('Row_haptic_feedback');
            HapticFeedback.lightImpact();
            logFirebaseEvent('Row_launch_u_r_l');
            unawaited(
              () async {
                await launchURL(widget!.fileURL!);
              }(),
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.asset(
                      'assets/images/button_image.webp',
                    ).image,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Icon(
                  FFIcons.kdocumentText,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      valueOrDefault<String>(
                        _model.fileDTstate?.name,
                        'unnamed',
                      ).toUpperCase(),
                      maxLines: 1,
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleMediumFamily,
                            letterSpacing: 0.0,
                            lineHeight: 1.25,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .titleMediumIsCustom,
                          ),
                    ),
                    Text(
                      valueOrDefault<String>(
                        '${valueOrDefault<String>(
                          _model.fileDTstate?.type,
                          'PDF',
                        )} • ${valueOrDefault<String>(
                          formatNumber(
                            _model.fileDTstate?.sizeMB,
                            formatType: FormatType.decimal,
                            decimalType: DecimalType.automatic,
                          ),
                          '0',
                        )} мб',
                        'PDF • 0 мб',
                      ),
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleMediumFamily,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 13.0,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .titleMediumIsCustom,
                          ),
                    ),
                  ],
                ),
              ),
            ].divide(SizedBox(width: 8.0)),
          ),
        ),
      ),
    );
  }
}
