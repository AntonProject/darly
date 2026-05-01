import '/backend/firebase_storage/storage.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'file_upload_dialog_widget.dart' show FileUploadDialogWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FileUploadDialogModel extends FlutterFlowModel<FileUploadDialogWidget> {
  ///  State fields for stateful widgets in this component.

  bool isDataUploading_uploadDataGallery = false;
  FFUploadedFile uploadedLocalFile_uploadDataGallery =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadDataGallery = '';

  bool isDataUploading_uploadDataCamera = false;
  FFUploadedFile uploadedLocalFile_uploadDataCamera =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadDataCamera = '';

  // Stores action output result for [Custom Action - uploadFileWithMetadata] action in Row widget.
  FileDTStruct? fileUpload;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
