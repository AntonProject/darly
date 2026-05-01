import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/audio/audio_dialog/audio_dialog_widget.dart';
import '/pages/payment/premium_chat_dialog/premium_chat_dialog_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'audio_home_comp_model.dart';
export 'audio_home_comp_model.dart';

class AudioHomeCompWidget extends StatefulWidget {
  const AudioHomeCompWidget({
    super.key,
    int? index,
    required this.audio,
    this.listAudio,
    String? title,
  })  : this.index = index ?? 0,
        this.title = title ?? 'Подкаст';

  final int index;
  final AudioRecord? audio;
  final List<AudioRecord>? listAudio;
  final String title;

  @override
  State<AudioHomeCompWidget> createState() => _AudioHomeCompWidgetState();
}

class _AudioHomeCompWidgetState extends State<AudioHomeCompWidget> {
  late AudioHomeCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AudioHomeCompModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        logFirebaseEvent('AUDIO_HOME_Container_v9e2mtlg_ON_TAP');
        if (!valueOrDefault<bool>(
          functions
              .dateGreatherThanToday(currentUserDocument?.subscriptionExpDate),
          false,
        )) {
          if (!() {
            if (isiOS) {
              return valueOrDefault<bool>(
                functions.checkVersionReview(FFAppState().version,
                    getRemoteConfigString('appleReviewVersion')),
                false,
              );
            } else if (isAndroid) {
              return valueOrDefault<bool>(
                functions.checkVersionReview(FFAppState().version,
                    getRemoteConfigString('googleReviewVersion')),
                false,
              );
            } else {
              return false;
            }
          }()) {
            logFirebaseEvent('Container_bottom_sheet');
            showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              isDismissible: false,
              enableDrag: false,
              context: context,
              builder: (context) {
                return WebViewAware(
                  child: Padding(
                    padding: MediaQuery.viewInsetsOf(context),
                    child: PremiumChatDialogWidget(),
                  ),
                );
              },
            ).then((value) => safeSetState(() {}));

            return;
          }
        }
        logFirebaseEvent('Container_navigate_to');

        context.pushNamed(
          AudioPlayerWidget.routeName,
          pathParameters: {
            'title': serializeParam(
              functions.titleNew(widget!.audio?.category),
              ParamType.String,
            ),
            'currentTrack': serializeParam(
              widget!.audio,
              ParamType.Document,
            ),
            'audioFiles': serializeParam(
              widget!.listAudio,
              ParamType.Document,
              isList: true,
            ),
          }.withoutNulls,
          extra: <String, dynamic>{
            'currentTrack': widget!.audio,
            'audioFiles': widget!.listAudio,
          },
        );
      },
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 400.0,
        ),
        decoration: BoxDecoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget!.index > 0)
              Divider(
                height: 1.0,
                thickness: 1.0,
                indent: 84.0,
                color: FlutterFlowTheme.of(context).white12,
              ),
            Padding(
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
                            widget!.audio!.image,
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
                      if (!functions.dateGreatherThanToday(
                              currentUserDocument?.subscriptionExpDate) &&
                          () {
                            if (isiOS) {
                              return !valueOrDefault<bool>(
                                functions.checkVersionReview(
                                    FFAppState().version,
                                    getRemoteConfigString(
                                        'appleReviewVersion')),
                                false,
                              );
                            } else if (isAndroid) {
                              return !valueOrDefault<bool>(
                                functions.checkVersionReview(
                                    FFAppState().version,
                                    getRemoteConfigString(
                                        'googleReviewVersion')),
                                false,
                              );
                            } else {
                              return true;
                            }
                          }())
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
                                      if (((widget!.title == 'Избранное') ||
                                              (widget!.title == 'Эксклюзив')) &&
                                          (widget!.audio?.category != null &&
                                              widget!.audio?.category != ''))
                                        Text(
                                          '${functions.titleNew(widget!.audio?.category)} • ',
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
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        ),
                                      if (widget!.audio?.duration != null &&
                                          widget!.audio?.duration != '')
                                        Text(
                                          widget!.audio!.duration,
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
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        ),
                                    ],
                                  ),
                                  Text(
                                    valueOrDefault<String>(
                                      widget!.audio?.audioTitle,
                                      'БЕЗ НАЗВАНИЯ',
                                    ).toUpperCase(),
                                    maxLines: 2,
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
                                ].divide(SizedBox(height: 4.0)),
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'AUDIO_HOME_Icon_gaakexyc_ON_TAP');
                              logFirebaseEvent('Icon_haptic_feedback');
                              HapticFeedback.mediumImpact();
                              if (!valueOrDefault<bool>(
                                functions.dateGreatherThanToday(
                                    currentUserDocument?.subscriptionExpDate),
                                false,
                              )) {
                                if (!() {
                                  if (isiOS) {
                                    return valueOrDefault<bool>(
                                      functions.checkVersionReview(
                                          FFAppState().version,
                                          getRemoteConfigString(
                                              'appleReviewVersion')),
                                      false,
                                    );
                                  } else if (isAndroid) {
                                    return valueOrDefault<bool>(
                                      functions.checkVersionReview(
                                          FFAppState().version,
                                          getRemoteConfigString(
                                              'googleReviewVersion')),
                                      false,
                                    );
                                  } else {
                                    return false;
                                  }
                                }()) {
                                  logFirebaseEvent('Icon_bottom_sheet');
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    isDismissible: false,
                                    enableDrag: false,
                                    context: context,
                                    builder: (context) {
                                      return WebViewAware(
                                        child: Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: PremiumChatDialogWidget(),
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));

                                  return;
                                }
                              }
                              logFirebaseEvent('Icon_bottom_sheet');
                              showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                useSafeArea: true,
                                context: context,
                                builder: (context) {
                                  return WebViewAware(
                                    child: Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: AudioDialogWidget(
                                        audioComp: widget!.audio!,
                                        audioList: widget!.listAudio,
                                      ),
                                    ),
                                  );
                                },
                              ).then((value) => safeSetState(() {}));
                            },
                            child: Icon(
                              FFIcons.kmore2,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ].divide(SizedBox(width: 8.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
