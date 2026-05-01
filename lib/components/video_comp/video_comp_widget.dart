import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'video_comp_model.dart';
export 'video_comp_model.dart';

class VideoCompWidget extends StatefulWidget {
  const VideoCompWidget({
    super.key,
    required this.videoDoc,
  });

  final VideosRecord? videoDoc;

  @override
  State<VideoCompWidget> createState() => _VideoCompWidgetState();
}

class _VideoCompWidgetState extends State<VideoCompWidget> {
  late VideoCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VideoCompModel());

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
        logFirebaseEvent('VIDEO_Container_xltlxis5_ON_TAP');
        logFirebaseEvent('Container_haptic_feedback');
        HapticFeedback.lightImpact();
        logFirebaseEvent('Container_backend_call');
        unawaited(
          () async {
            await widget!.videoDoc!.reference.update({
              ...mapToFirestore(
                {
                  'views': FieldValue.increment(1),
                },
              ),
            });
          }(),
        );
        logFirebaseEvent('Container_navigate_to');

        context.pushNamed(
          VideoPlayerWidget.routeName,
          queryParameters: {
            'urltoPath': serializeParam(
              functions.urlToVideoPath(widget!.videoDoc!.videoUrl),
              ParamType.String,
            ),
          }.withoutNulls,
        );
      },
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          maxWidth: 600.0,
        ),
        decoration: BoxDecoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              height: 212.0,
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
                        widget!.videoDoc?.image,
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (widget!.videoDoc?.duration != null &&
                        widget!.videoDoc?.duration != '')
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
                                      widget!.videoDoc?.duration,
                                      '-',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
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
            Align(
              alignment: AlignmentDirectional(-1.0, 0.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
                child: Text(
                  widget!.videoDoc!.description.maybeHandleOverflow(
                    maxChars: 150,
                    replacement: '…',
                  ),
                  maxLines: 2,
                  style: FlutterFlowTheme.of(context).titleMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).titleMediumFamily,
                        fontSize: 17.0,
                        letterSpacing: 0.0,
                        lineHeight: 1.25,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).titleMediumIsCustom,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
