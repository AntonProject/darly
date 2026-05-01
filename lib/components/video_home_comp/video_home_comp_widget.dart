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
import 'video_home_comp_model.dart';
export 'video_home_comp_model.dart';

class VideoHomeCompWidget extends StatefulWidget {
  const VideoHomeCompWidget({
    super.key,
    required this.videoDoc,
  });

  final VideosRecord? videoDoc;

  @override
  State<VideoHomeCompWidget> createState() => _VideoHomeCompWidgetState();
}

class _VideoHomeCompWidgetState extends State<VideoHomeCompWidget> {
  late VideoHomeCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VideoHomeCompModel());

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
        logFirebaseEvent('VIDEO_HOME_Container_5nvqi3z4_ON_TAP');
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
        constraints: BoxConstraints(
          maxWidth: 158.0,
        ),
        decoration: BoxDecoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 158.0,
              height: 100.0,
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
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
              child: Text(
                widget!.videoDoc!.title.maybeHandleOverflow(
                  maxChars: 30,
                  replacement: '…',
                ),
                maxLines: 1,
                style: FlutterFlowTheme.of(context).labelMedium.override(
                      fontFamily:
                          FlutterFlowTheme.of(context).labelMediumFamily,
                      fontSize: 13.0,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).labelMediumIsCustom,
                    ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
              child: Text(
                widget!.videoDoc!.description.maybeHandleOverflow(
                  maxChars: 80,
                  replacement: '…',
                ),
                maxLines: 2,
                style: FlutterFlowTheme.of(context).titleMedium.override(
                      fontFamily:
                          FlutterFlowTheme.of(context).titleMediumFamily,
                      letterSpacing: 0.0,
                      lineHeight: 1.2,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).titleMediumIsCustom,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
