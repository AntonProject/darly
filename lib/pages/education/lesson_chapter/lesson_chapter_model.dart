import '/backend/backend.dart';
import '/components/empty_list/empty_list_widget.dart';
import '/components/file_comp/file_comp_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/audio/audio_education/audio_education_widget.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'lesson_chapter_widget.dart' show LessonChapterWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LessonChapterModel extends FlutterFlowModel<LessonChapterWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for audioEducation component.
  late AudioEducationModel audioEducationModel;

  @override
  void initState(BuildContext context) {
    audioEducationModel = createModel(context, () => AudioEducationModel());
  }

  @override
  void dispose() {
    audioEducationModel.dispose();
  }
}
