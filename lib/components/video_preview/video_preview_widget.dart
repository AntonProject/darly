import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'video_preview_model.dart';
export 'video_preview_model.dart';

class VideoPreviewWidget extends StatefulWidget {
  const VideoPreviewWidget({
    super.key,
    double? height,
    required this.videoDT,
  }) : this.height = height ?? 212.0;

  final double height;
  final VideoFileStruct? videoDT;

  @override
  State<VideoPreviewWidget> createState() => _VideoPreviewWidgetState();
}

class _VideoPreviewWidgetState extends State<VideoPreviewWidget> {
  late VideoPreviewModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VideoPreviewModel());

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
        logFirebaseEvent('VIDEO_PREVIEW_Container_4a6fmca8_ON_TAP');
        logFirebaseEvent('Container_haptic_feedback');
        HapticFeedback.lightImpact();
        logFirebaseEvent('Container_navigate_to');

        context.pushNamed(
          VideoPlayerWidget.routeName,
          queryParameters: {
            'urltoPath': serializeParam(
              functions.urlToVideoPath(widget!.videoDT!.url),
              ParamType.String,
            ),
          }.withoutNulls,
        );
      },
      child: Container(
        width: double.infinity,
        height: widget!.height,
        constraints: BoxConstraints(
          maxWidth: 600.0,
          maxHeight: 600.0,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(
              getCORSProxyUrl(
                valueOrDefault<String>(
                  widget!.videoDT?.imagePreview,
                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/woman-103qa6/assets/ufnzpqto096m/AppStoreWoman.jpg',
                ),
              ),
            ),
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).tertiary,
            width: 1.0,
          ),
        ),
        child: Align(
          alignment: AlignmentDirectional(1.0, 1.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (valueOrDefault<String>(
                        widget!.videoDT?.duration,
                        '-',
                      ) !=
                      null &&
                  valueOrDefault<String>(
                        widget!.videoDT?.duration,
                        '-',
                      ) !=
                      '')
                Align(
                  alignment: AlignmentDirectional(1.0, 1.0),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(56.0),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 12.0,
                          sigmaY: 12.0,
                        ),
                        child: Container(
                          constraints: BoxConstraints(
                            minHeight: 20.0,
                          ),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).white12,
                            borderRadius: BorderRadius.circular(56.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).white12,
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 0.0, 8.0, 0.0),
                            child: Text(
                              valueOrDefault<String>(
                                widget!.videoDT?.duration,
                                '-',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .titleMediumFamily,
                                    letterSpacing: 0.0,
                                    lineHeight: 1.25,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .titleMediumIsCustom,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
