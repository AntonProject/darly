import '/backend/firebase_storage/storage.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'file_upload_dialog_model.dart';
export 'file_upload_dialog_model.dart';

class FileUploadDialogWidget extends StatefulWidget {
  const FileUploadDialogWidget({
    super.key,
    this.uploadFileState,
    this.uploadImage,
  });

  final Future Function(FileDTStruct? file)? uploadFileState;
  final Future Function(String? image)? uploadImage;

  @override
  State<FileUploadDialogWidget> createState() => _FileUploadDialogWidgetState();
}

class _FileUploadDialogWidgetState extends State<FileUploadDialogWidget> {
  late FileUploadDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FileUploadDialogModel());

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
        logFirebaseEvent('FILE_UPLOAD_DIALOG_Column_cdb706ya_ON_TA');
        logFirebaseEvent('Column_bottom_sheet');
        Navigator.pop(context);
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 48.0, 0.0, 8.0),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                logFirebaseEvent('FILE_UPLOAD_DIALOG_Container_f8czk3ct_ON');
                logFirebaseEvent('Container_bottom_sheet');
                Navigator.pop(context);
              },
              child: Container(
                width: 48.0,
                height: 6.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).accent2,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0.0, 1.0),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.0),
                topRight: Radius.circular(32.0),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 24.0,
                  sigmaY: 24.0,
                ),
                child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    maxWidth: 600.0,
                    maxHeight: MediaQuery.sizeOf(context).height * 0.9,
                  ),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).dialog,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(1.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              child: Container(
                                width: 32.0,
                                height: 32.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'ДОБАВИТЬ ФАЙЛ',
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .titleMediumFamily,
                                  fontSize: 17.0,
                                  letterSpacing: 0.0,
                                  lineHeight: 1.25,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .titleMediumIsCustom,
                                ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(1.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 16.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  logFirebaseEvent(
                                      'FILE_UPLOAD_DIALOG_Container_yzh3xu2b_ON');
                                  logFirebaseEvent('Container_bottom_sheet');
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: 32.0,
                                  height: 32.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).white24,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  child: Icon(
                                    FFIcons.kcloseIcon,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 24.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 8.0)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).white12,
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).tertiary,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'FILE_UPLOAD_DIALOG_Row_kamyz3j7_ON_TAP');
                                    logFirebaseEvent('Row_haptic_feedback');
                                    HapticFeedback.lightImpact();
                                    logFirebaseEvent(
                                        'Row_upload_media_to_firebase');
                                    final selectedMedia = await selectMedia(
                                      maxWidth: 600.00,
                                      maxHeight: 600.00,
                                      imageQuality: 96,
                                      mediaSource: MediaSource.photoGallery,
                                      multiImage: false,
                                    );
                                    if (selectedMedia != null &&
                                        selectedMedia.every((m) =>
                                            validateFileFormat(
                                                m.storagePath, context))) {
                                      safeSetState(() => _model
                                              .isDataUploading_uploadDataGallery =
                                          true);
                                      var selectedUploadedFiles =
                                          <FFUploadedFile>[];

                                      var downloadUrls = <String>[];
                                      try {
                                        selectedUploadedFiles = selectedMedia
                                            .map((m) => FFUploadedFile(
                                                  name: m.storagePath
                                                      .split('/')
                                                      .last,
                                                  bytes: m.bytes,
                                                  height: m.dimensions?.height,
                                                  width: m.dimensions?.width,
                                                  blurHash: m.blurHash,
                                                  originalFilename:
                                                      m.originalFilename,
                                                ))
                                            .toList();

                                        downloadUrls = (await Future.wait(
                                          selectedMedia.map(
                                            (m) async => await uploadData(
                                                m.storagePath, m.bytes),
                                          ),
                                        ))
                                            .where((u) => u != null)
                                            .map((u) => u!)
                                            .toList();
                                      } finally {
                                        _model.isDataUploading_uploadDataGallery =
                                            false;
                                      }
                                      if (selectedUploadedFiles.length ==
                                              selectedMedia.length &&
                                          downloadUrls.length ==
                                              selectedMedia.length) {
                                        safeSetState(() {
                                          _model.uploadedLocalFile_uploadDataGallery =
                                              selectedUploadedFiles.first;
                                          _model.uploadedFileUrl_uploadDataGallery =
                                              downloadUrls.first;
                                        });
                                      } else {
                                        safeSetState(() {});
                                        return;
                                      }
                                    }

                                    if ((_model.uploadedFileUrl_uploadDataGallery !=
                                                null &&
                                            _model.uploadedFileUrl_uploadDataGallery !=
                                                '') &&
                                        !_model
                                            .isDataUploading_uploadDataGallery) {
                                      logFirebaseEvent('Row_execute_callback');
                                      await widget.uploadImage?.call(
                                        _model
                                            .uploadedFileUrl_uploadDataGallery,
                                      );
                                    }
                                    logFirebaseEvent('Row_bottom_sheet');
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Icon(
                                        FFIcons.kgallery,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 24.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Выбрать из галереи',
                                          style: FlutterFlowTheme.of(context)
                                              .titleMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMediumFamily,
                                                letterSpacing: 0.0,
                                                lineHeight: 1.25,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .titleMediumIsCustom,
                                              ),
                                        ),
                                      ),
                                      Icon(
                                        FFIcons.kright3,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 24.0,
                                      ),
                                    ].divide(SizedBox(width: 12.0)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'FILE_UPLOAD_DIALOG_Row_2gveawa9_ON_TAP');
                                    logFirebaseEvent('Row_haptic_feedback');
                                    HapticFeedback.lightImpact();
                                    logFirebaseEvent(
                                        'Row_upload_media_to_firebase');
                                    final selectedMedia = await selectMedia(
                                      maxWidth: 600.00,
                                      maxHeight: 600.00,
                                      imageQuality: 96,
                                      multiImage: false,
                                    );
                                    if (selectedMedia != null &&
                                        selectedMedia.every((m) =>
                                            validateFileFormat(
                                                m.storagePath, context))) {
                                      safeSetState(() => _model
                                              .isDataUploading_uploadDataCamera =
                                          true);
                                      var selectedUploadedFiles =
                                          <FFUploadedFile>[];

                                      var downloadUrls = <String>[];
                                      try {
                                        selectedUploadedFiles = selectedMedia
                                            .map((m) => FFUploadedFile(
                                                  name: m.storagePath
                                                      .split('/')
                                                      .last,
                                                  bytes: m.bytes,
                                                  height: m.dimensions?.height,
                                                  width: m.dimensions?.width,
                                                  blurHash: m.blurHash,
                                                  originalFilename:
                                                      m.originalFilename,
                                                ))
                                            .toList();

                                        downloadUrls = (await Future.wait(
                                          selectedMedia.map(
                                            (m) async => await uploadData(
                                                m.storagePath, m.bytes),
                                          ),
                                        ))
                                            .where((u) => u != null)
                                            .map((u) => u!)
                                            .toList();
                                      } finally {
                                        _model.isDataUploading_uploadDataCamera =
                                            false;
                                      }
                                      if (selectedUploadedFiles.length ==
                                              selectedMedia.length &&
                                          downloadUrls.length ==
                                              selectedMedia.length) {
                                        safeSetState(() {
                                          _model.uploadedLocalFile_uploadDataCamera =
                                              selectedUploadedFiles.first;
                                          _model.uploadedFileUrl_uploadDataCamera =
                                              downloadUrls.first;
                                        });
                                      } else {
                                        safeSetState(() {});
                                        return;
                                      }
                                    }

                                    if ((_model.uploadedFileUrl_uploadDataCamera !=
                                                null &&
                                            _model.uploadedFileUrl_uploadDataCamera !=
                                                '') &&
                                        !_model
                                            .isDataUploading_uploadDataCamera) {
                                      logFirebaseEvent('Row_execute_callback');
                                      await widget.uploadImage?.call(
                                        _model.uploadedFileUrl_uploadDataCamera,
                                      );
                                    }
                                    logFirebaseEvent('Row_bottom_sheet');
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Icon(
                                        FFIcons.kcamera,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 24.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Снять фото',
                                          style: FlutterFlowTheme.of(context)
                                              .titleMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMediumFamily,
                                                letterSpacing: 0.0,
                                                lineHeight: 1.25,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .titleMediumIsCustom,
                                              ),
                                        ),
                                      ),
                                      Icon(
                                        FFIcons.kright3,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 24.0,
                                      ),
                                    ].divide(SizedBox(width: 12.0)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'FILE_UPLOAD_DIALOG_Row_1ux4t69d_ON_TAP');
                                    logFirebaseEvent('Row_haptic_feedback');
                                    HapticFeedback.lightImpact();
                                    logFirebaseEvent('Row_custom_action');
                                    _model.fileUpload =
                                        await actions.uploadFileWithMetadata();
                                    logFirebaseEvent('Row_execute_callback');
                                    await widget.uploadFileState?.call(
                                      _model.fileUpload,
                                    );
                                    logFirebaseEvent('Row_bottom_sheet');
                                    Navigator.pop(context);

                                    safeSetState(() {});
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Icon(
                                        FFIcons.kfile2,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 24.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Добавить файл',
                                          style: FlutterFlowTheme.of(context)
                                              .titleMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMediumFamily,
                                                letterSpacing: 0.0,
                                                lineHeight: 1.25,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .titleMediumIsCustom,
                                              ),
                                        ),
                                      ),
                                      Icon(
                                        FFIcons.kright3,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 24.0,
                                      ),
                                    ].divide(SizedBox(width: 12.0)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 12.0, 20.0, 48.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(56.0),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 12.0,
                              sigmaY: 12.0,
                            ),
                            child: FFButtonWidget(
                              onPressed: () async {
                                logFirebaseEvent(
                                    'FILE_UPLOAD_DIALOG_cancelButton_ON_TAP');
                                logFirebaseEvent('cancelButton_bottom_sheet');
                                Navigator.pop(context);
                              },
                              text: 'ОТМЕНА',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 56.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).white24,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .titleSmallFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 17.0,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .titleSmallIsCustom,
                                    ),
                                elevation: 0.0,
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).white12,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(56.0),
                              ),
                              showLoadingIndicator: false,
                            ),
                          ),
                        ),
                      ),
                    ].addToStart(SizedBox(height: 28.0)),
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
