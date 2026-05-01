import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import 'photo_upload_dialog_widget.dart' show PhotoUploadDialogWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PhotoUploadDialogModel extends FlutterFlowModel<PhotoUploadDialogWidget> {
  ///  State fields for stateful widgets in this component.

  bool isDataUploading_uploadDataGalleryProfile = false;
  FFUploadedFile uploadedLocalFile_uploadDataGalleryProfile =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadDataGalleryProfile = '';

  bool isDataUploading_uploadDataCameraProfile = false;
  FFUploadedFile uploadedLocalFile_uploadDataCameraProfile =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadDataCameraProfile = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
