import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'file_comp_widget.dart' show FileCompWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FileCompModel extends FlutterFlowModel<FileCompWidget> {
  ///  Local state fields for this component.

  FileDTStruct? fileDTstate;
  void updateFileDTstateStruct(Function(FileDTStruct) updateFn) {
    updateFn(fileDTstate ??= FileDTStruct());
  }

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - getFileMetadataFromStorage] action in fileComp widget.
  FileDTStruct? file;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
