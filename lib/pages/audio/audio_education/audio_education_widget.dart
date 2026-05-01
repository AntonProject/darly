import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'audio_education_model.dart';
export 'audio_education_model.dart';

class AudioEducationWidget extends StatefulWidget {
  const AudioEducationWidget({
    super.key,
    required this.audioId,
    this.list,
  });

  final String? audioId;
  final List<AudioRecord>? list;

  @override
  State<AudioEducationWidget> createState() => _AudioEducationWidgetState();
}

class _AudioEducationWidgetState extends State<AudioEducationWidget> {
  late AudioEducationModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AudioEducationModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('AUDIO_EDUCATION_audioEducation_ON_INIT_S');
      logFirebaseEvent('audioEducation_custom_action');
      _model.audioQuery = await actions.audioRef(
        widget!.audioId!,
      );
      logFirebaseEvent('audioEducation_update_component_state');
      _model.audioDoc = _model.audioQuery;
      safeSetState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _model.audioDoc != null,
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          logFirebaseEvent('AUDIO_EDUCATION_Container_qrakmpjh_ON_TA');
          logFirebaseEvent('Container_haptic_feedback');
          HapticFeedback.mediumImpact();
          logFirebaseEvent('Container_navigate_to');

          context.pushNamed(
            AudioPlayerWidget.routeName,
            pathParameters: {
              'title': serializeParam(
                functions.titleNew(_model.audioDoc?.category),
                ParamType.String,
              ),
              'currentTrack': serializeParam(
                _model.audioDoc,
                ParamType.Document,
              ),
              'audioFiles': serializeParam(
                widget!.list,
                ParamType.Document,
                isList: true,
              ),
            }.withoutNulls,
            extra: <String, dynamic>{
              'currentTrack': _model.audioDoc,
              'audioFiles': widget!.list,
            },
          );
        },
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 400.0,
          ),
          decoration: BoxDecoration(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: CachedNetworkImage(
                        fadeInDuration: Duration(milliseconds: 500),
                        fadeOutDuration: Duration(milliseconds: 500),
                        imageUrl: getCORSProxyUrl(
                          valueOrDefault<String>(
                            _model.audioDoc?.image,
                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/woman-103qa6/assets/s8g4r2c90vfb/podcast_image_container3.webp',
                          ),
                        ),
                        width: 72.0,
                        height: 72.0,
                        fit: BoxFit.cover,
                        errorWidget: (context, error, stackTrace) =>
                            Image.asset(
                          'assets/images/error_image.jpg',
                          width: 72.0,
                          height: 72.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    if (!valueOrDefault<bool>(
                      functions.dateGreatherThanToday(
                          currentUserDocument?.subscriptionExpDate),
                      false,
                    ))
                      AuthUserStreamWidget(
                        builder: (context) => Container(
                          width: 72.0,
                          height: 72.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).white12,
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).white12,
                              width: 1.0,
                            ),
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Icon(
                              FFIcons.klock2,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                4.0, 0.0, 0.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    if (_model.audioDoc?.category != null &&
                                        _model.audioDoc?.category != '')
                                      Text(
                                        '${functions.titleNew(_model.audioDoc?.category)} • ',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              fontSize: 13.0,
                                              letterSpacing: 0.0,
                                              lineHeight: 1.2,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .bodyMediumIsCustom,
                                            ),
                                      ),
                                    if (_model.audioDoc?.duration != null &&
                                        _model.audioDoc?.duration != '')
                                      Text(
                                        _model.audioDoc!.duration,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              fontSize: 13.0,
                                              letterSpacing: 0.0,
                                              lineHeight: 1.2,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .bodyMediumIsCustom,
                                            ),
                                      ),
                                  ],
                                ),
                                Text(
                                  valueOrDefault<String>(
                                    _model.audioDoc?.audioTitle,
                                    'unknown',
                                  ).toUpperCase(),
                                  maxLines: 2,
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .titleMediumFamily,
                                        fontSize: 17.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        lineHeight: 1.25,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .titleMediumIsCustom,
                                      ),
                                ),
                              ].divide(SizedBox(height: 4.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ].divide(SizedBox(width: 8.0)),
            ),
          ),
        ),
      ),
    );
  }
}
