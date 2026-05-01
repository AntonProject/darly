import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'audio_day_home_model.dart';
export 'audio_day_home_model.dart';

class AudioDayHomeWidget extends StatefulWidget {
  const AudioDayHomeWidget({super.key});

  @override
  State<AudioDayHomeWidget> createState() => _AudioDayHomeWidgetState();
}

class _AudioDayHomeWidgetState extends State<AudioDayHomeWidget> {
  late AudioDayHomeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AudioDayHomeModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 12.0,
          sigmaY: 12.0,
        ),
        child: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            logFirebaseEvent('AUDIO_DAY_HOME_Container_2anbuu53_ON_TAP');
            logFirebaseEvent('Container_haptic_feedback');
            HapticFeedback.mediumImpact();
            if ((currentUserDocument?.practicOfDay != null) &&
                (dateTimeFormat(
                      "d/M/y",
                      currentUserDocument?.practicOfDayDate,
                      locale: FFLocalizations.of(context).languageCode,
                    ) ==
                    dateTimeFormat(
                      "d/M/y",
                      getCurrentTimestamp,
                      locale: FFLocalizations.of(context).languageCode,
                    ))) {
              logFirebaseEvent('Container_backend_call');
              _model.userDayPractic = await AudioRecord.getDocumentOnce(
                  currentUserDocument!.practicOfDay!);
              logFirebaseEvent('Container_navigate_to');

              context.pushNamed(
                AudioPlayerWidget.routeName,
                pathParameters: {
                  'title': serializeParam(
                    'ПРАКТИКА ДНЯ',
                    ParamType.String,
                  ),
                  'currentTrack': serializeParam(
                    _model.userDayPractic,
                    ParamType.Document,
                  ),
                  'audioFiles': serializeParam(
                    functions.emptyAudioList(),
                    ParamType.Document,
                    isList: true,
                  ),
                }.withoutNulls,
                extra: <String, dynamic>{
                  'currentTrack': _model.userDayPractic,
                  'audioFiles': functions.emptyAudioList(),
                },
              );
            } else {
              logFirebaseEvent('Container_custom_action');
              _model.practicRandomAudio = await actions.practicOfDayAudio();
              logFirebaseEvent('Container_navigate_to');

              context.pushNamed(
                AudioPlayerWidget.routeName,
                pathParameters: {
                  'title': serializeParam(
                    'ПРАКТИКА ДНЯ',
                    ParamType.String,
                  ),
                  'currentTrack': serializeParam(
                    _model.practicRandomAudio,
                    ParamType.Document,
                  ),
                  'audioFiles': serializeParam(
                    functions.emptyAudioList(),
                    ParamType.Document,
                    isList: true,
                  ),
                }.withoutNulls,
                extra: <String, dynamic>{
                  'currentTrack': _model.practicRandomAudio,
                  'audioFiles': functions.emptyAudioList(),
                },
              );

              logFirebaseEvent('Container_backend_call');
              unawaited(
                () async {
                  await currentUserReference!.update(createUsersRecordData(
                    practicOfDay: _model.practicRandomAudio?.reference,
                    practicOfDayDate: getCurrentTimestamp,
                  ));
                }(),
              );
            }

            safeSetState(() {});
          },
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(
              minHeight: 96.0,
            ),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).white12,
              borderRadius: BorderRadius.circular(24.0),
              border: Border.all(
                color: FlutterFlowTheme.of(context).white12,
                width: 1.0,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ПРАКТИКА ДНЯ',
                          style: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleMediumFamily,
                                fontSize: 17.0,
                                letterSpacing: 0.0,
                                lineHeight: 1.4,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .titleMediumIsCustom,
                              ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 8.0, 0.0, 0.0),
                          child: Container(
                            height: 40.0,
                            constraints: BoxConstraints(
                              minWidth: 116.0,
                            ),
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).primary,
                              borderRadius: BorderRadius.circular(56.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).white12,
                                width: 1.0,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FFIcons.kplay,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 18.0,
                                ),
                                Text(
                                  'СЛУШАТЬ',
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
                              ]
                                  .divide(SizedBox(width: 8.0))
                                  .addToStart(SizedBox(width: 12.0))
                                  .addToEnd(SizedBox(width: 16.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28.0),
                    child: Image.asset(
                      'assets/images/AppStoreWoman.jpg',
                      width: 80.0,
                      height: 80.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ].divide(SizedBox(width: 4.0)),
            ),
          ),
        ),
      ),
    );
  }
}
