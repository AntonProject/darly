import '/backend/backend.dart';
import '/components/empty_list/empty_list_widget.dart';
import '/components/file_comp/file_comp_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/audio/audio_education/audio_education_widget.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'lesson_chapter_model.dart';
export 'lesson_chapter_model.dart';

class LessonChapterWidget extends StatefulWidget {
  const LessonChapterWidget({
    super.key,
    required this.chapter,
  });

  final EducationModuleLessonChaptersRecord? chapter;

  @override
  State<LessonChapterWidget> createState() => _LessonChapterWidgetState();
}

class _LessonChapterWidgetState extends State<LessonChapterWidget> {
  late LessonChapterModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LessonChapterModel());

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
        minWidth: 320.0,
        maxWidth: 800.0,
      ),
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget!.chapter?.title != null && widget!.chapter?.title != '')
            Align(
              alignment: AlignmentDirectional(-1.0, 0.0),
              child: Text(
                widget!.chapter!.title.toUpperCase().maybeHandleOverflow(
                      maxChars: 30,
                      replacement: '…',
                    ),
                maxLines: 1,
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily:
                          FlutterFlowTheme.of(context).headlineMediumFamily,
                      fontSize: 24.0,
                      letterSpacing: 0.0,
                      lineHeight: 1.4,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).headlineMediumIsCustom,
                    ),
              ),
            ),
          if (widget!.chapter?.description != null &&
              widget!.chapter?.description != '')
            Align(
              alignment: AlignmentDirectional(-1.0, 0.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                child: Text(
                  widget!.chapter!.description,
                  style: FlutterFlowTheme.of(context).labelLarge.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).labelLargeFamily,
                        color: FlutterFlowTheme.of(context).primaryText,
                        letterSpacing: 0.0,
                        lineHeight: 1.4,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).labelLargeIsCustom,
                      ),
                ),
              ),
            ),
          if (widget!.chapter?.taskInformation != null &&
              widget!.chapter?.taskInformation != '')
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'ЗАДАНИЕ:',
                      maxLines: 1,
                      style:
                          FlutterFlowTheme.of(context).headlineMedium.override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .headlineMediumFamily,
                                fontSize: 24.0,
                                letterSpacing: 0.0,
                                lineHeight: 1.4,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .headlineMediumIsCustom,
                              ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                      child: Text(
                        widget!.chapter!.taskInformation,
                        style: FlutterFlowTheme.of(context).labelLarge.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).labelLargeFamily,
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                              lineHeight: 1.4,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .labelLargeIsCustom,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (widget!.chapter?.image != null && widget!.chapter?.image != '')
            Align(
              alignment: AlignmentDirectional(-1.0, 0.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).tertiary,
                    width: 1.0,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14.0),
                    child: CachedNetworkImage(
                      fadeInDuration: Duration(milliseconds: 500),
                      fadeOutDuration: Duration(milliseconds: 500),
                      imageUrl: getCORSProxyUrl(
                        widget!.chapter!.image,
                      ),
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height * 0.3,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          if (widget!.chapter?.video != null && widget!.chapter?.video != '')
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
              child: Container(
                constraints: BoxConstraints(
                  minWidth: 320.0,
                  maxWidth: 800.0,
                ),
                decoration: BoxDecoration(),
                child: Visibility(
                  visible: widget!.chapter?.video != null &&
                      widget!.chapter?.video != '',
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height * 0.3,
                    child: custom_widgets.PaymentWebview(
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height * 0.3,
                      html: widget!.chapter?.video,
                    ),
                  ),
                ),
              ),
            ),
          if (widget!.chapter?.audioId != null &&
              widget!.chapter?.audioId != '')
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
              child: wrapWithModel(
                model: _model.audioEducationModel,
                updateCallback: () => safeSetState(() {}),
                updateOnChange: true,
                child: AudioEducationWidget(
                  audioId: widget!.chapter!.audioId,
                ),
              ),
            ),
          if (widget!.chapter!.files.length > 0)
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: AlignmentDirectional(-1.0, 0.0),
                  child: Text(
                    'МАТЕРИАЛЫ УРОКА',
                    maxLines: 1,
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).headlineMediumFamily,
                          fontSize: 24.0,
                          letterSpacing: 0.0,
                          lineHeight: 1.4,
                          useGoogleFonts: !FlutterFlowTheme.of(context)
                              .headlineMediumIsCustom,
                        ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-1.0, 0.0),
                  child: Builder(
                    builder: (context) {
                      final files = widget!.chapter?.files?.toList() ?? [];
                      if (files.isEmpty) {
                        return EmptyListWidget();
                      }

                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: List.generate(files.length, (filesIndex) {
                          final filesItem = files[filesIndex];
                          return FileCompWidget(
                            key: Key('Key4z3_${filesIndex}_of_${files.length}'),
                            fileURL: filesItem,
                            bgColor: FlutterFlowTheme.of(context).white12,
                          );
                        })
                            .divide(SizedBox(height: 16.0))
                            .addToStart(SizedBox(height: 16.0)),
                      );
                    },
                  ),
                ),
              ].addToStart(SizedBox(height: 20.0)),
            ),
        ],
      ),
    );
  }
}
