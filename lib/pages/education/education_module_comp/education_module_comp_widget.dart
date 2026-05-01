import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'education_module_comp_model.dart';
export 'education_module_comp_model.dart';

class EducationModuleCompWidget extends StatefulWidget {
  const EducationModuleCompWidget({
    super.key,
    required this.module,
  });

  final EducationModulesRecord? module;

  @override
  State<EducationModuleCompWidget> createState() =>
      _EducationModuleCompWidgetState();
}

class _EducationModuleCompWidgetState extends State<EducationModuleCompWidget>
    with TickerProviderStateMixin {
  late EducationModuleCompModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EducationModuleCompModel());

    animationsMap.addAll({
      'containerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 1500.0.ms,
            duration: 600.0.ms,
            color: FlutterFlowTheme.of(context).primary16,
            angle: 0.524,
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 1500.0.ms,
            duration: 600.0.ms,
            color: FlutterFlowTheme.of(context).primary16,
            angle: 0.524,
          ),
        ],
      ),
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
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: 96.0,
        maxWidth: 390.0,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [FlutterFlowTheme.of(context).white12, Color(0x00FFFFFF)],
          stops: [0.0, 1.0],
          begin: AlignmentDirectional(-1.0, 0.0),
          end: AlignmentDirectional(1.0, 0),
        ),
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 72.0,
              height: 72.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).white12,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).white12,
                  width: 1.0,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: CachedNetworkImage(
                  fadeInDuration: Duration(milliseconds: 500),
                  fadeOutDuration: Duration(milliseconds: 500),
                  imageUrl: getCORSProxyUrl(
                    valueOrDefault<String>(
                      widget!.module?.image,
                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/woman-103qa6/assets/gb1n15ty7896/mask_group.webp',
                    ),
                  ),
                  width: 72.0,
                  height: 72.0,
                  fit: BoxFit.cover,
                  errorWidget: (context, error, stackTrace) => Image.asset(
                    'assets/images/error_image.jpg',
                    width: 72.0,
                    height: 72.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Модуль №${valueOrDefault<String>(
                      widget!.module?.number?.toString(),
                      '1',
                    )}',
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelMediumFamily,
                          fontSize: 15.0,
                          letterSpacing: 0.0,
                          lineHeight: 1.24,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).labelMediumIsCustom,
                        ),
                  ),
                  Text(
                    valueOrDefault<String>(
                      widget!.module?.title,
                      'Не указано',
                    ).toUpperCase().maybeHandleOverflow(
                          maxChars: 30,
                          replacement: '…',
                        ),
                    maxLines: 1,
                    style: FlutterFlowTheme.of(context).titleMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).titleMediumFamily,
                          fontSize: 17.0,
                          letterSpacing: 0.0,
                          lineHeight: 1.4,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).titleMediumIsCustom,
                        ),
                  ),
                  if (widget!.module?.startDate != null)
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                      child: Builder(
                        builder: (context) {
                          if (!valueOrDefault<bool>(
                            functions.dateGreatherThanToday(
                                widget!.module?.startDate),
                            false,
                          )) {
                            return Container(
                              height: 24.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).primary,
                                borderRadius: BorderRadius.circular(99.0),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    8.0, 0.0, 8.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Открыто',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 15.0,
                                            letterSpacing: 0.0,
                                            lineHeight: 1.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodyMediumIsCustom,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ).animateOnPageLoad(animationsMap[
                                'containerOnPageLoadAnimation1']!);
                          } else {
                            return Container(
                              height: 24.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).primary8,
                                borderRadius: BorderRadius.circular(99.0),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    8.0, 0.0, 8.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      FFIcons.klock2,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 16.0,
                                    ),
                                    Text(
                                      'Откроется ${dateTimeFormat(
                                        "d.M",
                                        widget!.module?.startDate,
                                        locale: FFLocalizations.of(context)
                                            .languageCode,
                                      )}',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 15.0,
                                            letterSpacing: 0.0,
                                            lineHeight: 1.25,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodyMediumIsCustom,
                                          ),
                                    ),
                                  ].divide(SizedBox(width: 4.0)),
                                ),
                              ),
                            ).animateOnPageLoad(animationsMap[
                                'containerOnPageLoadAnimation2']!);
                          }
                        },
                      ),
                    ),
                ],
              ),
            ),
            Icon(
              FFIcons.kright3,
              color: FlutterFlowTheme.of(context).secondaryText,
              size: 24.0,
            ),
          ].divide(SizedBox(width: 12.0)),
        ),
      ),
    );
  }
}
