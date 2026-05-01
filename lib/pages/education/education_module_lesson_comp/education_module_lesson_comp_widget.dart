import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'education_module_lesson_comp_model.dart';
export 'education_module_lesson_comp_model.dart';

class EducationModuleLessonCompWidget extends StatefulWidget {
  const EducationModuleLessonCompWidget({
    super.key,
    required this.lesson,
  });

  final EducationModuleLessonsRecord? lesson;

  @override
  State<EducationModuleLessonCompWidget> createState() =>
      _EducationModuleLessonCompWidgetState();
}

class _EducationModuleLessonCompWidgetState
    extends State<EducationModuleLessonCompWidget> {
  late EducationModuleLessonCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EducationModuleLessonCompModel());

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
        maxWidth: 165.0,
      ),
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 165.0,
                height: 100.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                      getCORSProxyUrl(
                        widget!.lesson!.image,
                      ),
                    ),
                  ),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).tertiary,
                    width: 1.0,
                  ),
                ),
              ),
              if ((widget!.lesson?.startDate != null) &&
                  valueOrDefault<bool>(
                    functions.dateGreatherThanToday(widget!.lesson?.startDate),
                    false,
                  ))
                ClipRRect(
                  borderRadius: BorderRadius.circular(14.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 2.0,
                      sigmaY: 2.0,
                    ),
                    child: Container(
                      width: 165.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                            getCORSProxyUrl(
                              widget!.lesson!.image,
                            ),
                          ),
                        ),
                        borderRadius: BorderRadius.circular(14.0),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).tertiary,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FFIcons.klock2,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            Text(
                              'Откроется ${dateTimeFormat(
                                "d.M",
                                widget!.lesson?.startDate,
                                locale:
                                    FFLocalizations.of(context).languageCode,
                              )}',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 13.0,
                                    letterSpacing: 0.0,
                                    lineHeight: 1.25,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .bodyMediumIsCustom,
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
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
            child: Text(
              valueOrDefault<String>(
                'Урок ${valueOrDefault<String>(
                  widget!.lesson?.number?.toString(),
                  '1',
                )}',
                'Урок 1',
              ).maybeHandleOverflow(
                maxChars: 30,
                replacement: '…',
              ),
              maxLines: 1,
              style: FlutterFlowTheme.of(context).labelSmall.override(
                    fontFamily: FlutterFlowTheme.of(context).labelSmallFamily,
                    fontSize: 13.0,
                    letterSpacing: 0.0,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).labelSmallIsCustom,
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
            child: Text(
              valueOrDefault<String>(
                widget!.lesson?.title,
                'Без названия',
              ).toUpperCase().maybeHandleOverflow(
                    maxChars: 80,
                    replacement: '…',
                  ),
              maxLines: 2,
              style: FlutterFlowTheme.of(context).titleMedium.override(
                    fontFamily: FlutterFlowTheme.of(context).titleMediumFamily,
                    letterSpacing: 0.0,
                    lineHeight: 1.2,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).titleMediumIsCustom,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
