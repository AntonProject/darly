import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'audio_dialog_model.dart';
export 'audio_dialog_model.dart';

class AudioDialogWidget extends StatefulWidget {
  const AudioDialogWidget({
    super.key,
    required this.audioComp,
    this.audioList,
  });

  final AudioRecord? audioComp;
  final List<AudioRecord>? audioList;

  @override
  State<AudioDialogWidget> createState() => _AudioDialogWidgetState();
}

class _AudioDialogWidgetState extends State<AudioDialogWidget> {
  late AudioDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AudioDialogModel());

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
        logFirebaseEvent('AUDIO_DIALOG_COMP_Column_wkzbeeps_ON_TAP');
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
                logFirebaseEvent('AUDIO_DIALOG_Container_zqk2k4ky_ON_TAP');
                logFirebaseEvent('Container_haptic_feedback');
                HapticFeedback.lightImpact();
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
                  child: Stack(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 0.0, 20.0, 0.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Stack(
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 72.0,
                                              height: 72.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .white12,
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .white12,
                                                ),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                child: CachedNetworkImage(
                                                  fadeInDuration: Duration(
                                                      milliseconds: 500),
                                                  fadeOutDuration: Duration(
                                                      milliseconds: 500),
                                                  imageUrl: getCORSProxyUrl(
                                                    widget!.audioComp!.image,
                                                  ),
                                                  width: 72.0,
                                                  height: 72.0,
                                                  fit: BoxFit.cover,
                                                  errorWidget: (context, error,
                                                          stackTrace) =>
                                                      Image.asset(
                                                    'assets/images/error_image.jpg',
                                                    width: 72.0,
                                                    height: 72.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        4.0, 0.0, 0.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        if (widget!.audioComp
                                                                    ?.category !=
                                                                null &&
                                                            widget!.audioComp
                                                                    ?.category !=
                                                                '')
                                                          Text(
                                                            '${functions.titleNew(widget!.audioComp?.category)} • ',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  fontSize:
                                                                      13.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  lineHeight:
                                                                      1.2,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMediumIsCustom,
                                                                ),
                                                          ),
                                                        if (widget!.audioComp
                                                                    ?.duration !=
                                                                null &&
                                                            widget!.audioComp
                                                                    ?.duration !=
                                                                '')
                                                          Text(
                                                            widget!.audioComp!
                                                                .duration,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  fontSize:
                                                                      13.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  lineHeight:
                                                                      1.2,
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
                                                        widget!.audioComp
                                                            ?.audioTitle,
                                                        ' Без названия',
                                                      ).toUpperCase(),
                                                      maxLines: 2,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .titleMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMediumFamily,
                                                            letterSpacing: 0.0,
                                                            lineHeight: 1.25,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMediumIsCustom,
                                                          ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 4.0)),
                                                ),
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 8.0)),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(1.0, 0.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              logFirebaseEvent(
                                                  'AUDIO_DIALOG_Container_tfcl75td_ON_TAP');
                                              logFirebaseEvent(
                                                  'Container_haptic_feedback');
                                              HapticFeedback.mediumImpact();
                                              logFirebaseEvent(
                                                  'Container_bottom_sheet');
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              width: 32.0,
                                              height: 32.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .white24,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                              child: Icon(
                                                FFIcons.kcloseIcon,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: 24.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 20.0, 0.0, 20.0),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .white12,
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .tertiary,
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
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  logFirebaseEvent(
                                                      'AUDIO_DIALOG_COMP_Row_npydn4pp_ON_TAP');
                                                  logFirebaseEvent(
                                                      'Row_haptic_feedback');
                                                  HapticFeedback.lightImpact();
                                                  logFirebaseEvent(
                                                      'Row_bottom_sheet');
                                                  Navigator.pop(context);
                                                  logFirebaseEvent(
                                                      'Row_navigate_to');

                                                  context.pushNamed(
                                                    AudioPlayerWidget.routeName,
                                                    pathParameters: {
                                                      'title': serializeParam(
                                                        functions.titleNew(
                                                            widget!.audioComp
                                                                ?.category),
                                                        ParamType.String,
                                                      ),
                                                      'audioFiles':
                                                          serializeParam(
                                                        widget!.audioList,
                                                        ParamType.Document,
                                                        isList: true,
                                                      ),
                                                      'currentTrack':
                                                          serializeParam(
                                                        widget!.audioComp,
                                                        ParamType.Document,
                                                      ),
                                                    }.withoutNulls,
                                                    extra: <String, dynamic>{
                                                      'audioFiles':
                                                          widget!.audioList,
                                                      'currentTrack':
                                                          widget!.audioComp,
                                                    },
                                                  );
                                                },
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Icon(
                                                      FFIcons.kplayOff,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      size: 24.0,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        'Начать прослушивание',
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .titleMedium
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMediumFamily,
                                                              letterSpacing:
                                                                  0.0,
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
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      size: 24.0,
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 12.0)),
                                                ),
                                              ),
                                            ),
                                            Builder(
                                              builder: (context) => Padding(
                                                padding: EdgeInsets.all(16.0),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    logFirebaseEvent(
                                                        'AUDIO_DIALOG_COMP_Row_5x9iwbez_ON_TAP');
                                                    logFirebaseEvent(
                                                        'Row_haptic_feedback');
                                                    HapticFeedback
                                                        .lightImpact();
                                                    logFirebaseEvent(
                                                        'Row_share');
                                                    await Share.share(
                                                      'woman://com.appfyl.woman/audioPlayer/:title/:currentTrack/:audioFiles',
                                                      sharePositionOrigin:
                                                          getWidgetBoundingBox(
                                                              context),
                                                    );
                                                    logFirebaseEvent(
                                                        'Row_bottom_sheet');
                                                    Navigator.pop(context);
                                                  },
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Icon(
                                                        FFIcons.kshare2,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        size: 24.0,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          'Поделиться',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .titleMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMediumFamily,
                                                                letterSpacing:
                                                                    0.0,
                                                                lineHeight:
                                                                    1.25,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleMediumIsCustom,
                                                              ),
                                                        ),
                                                      ),
                                                      Icon(
                                                        FFIcons.kright3,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        size: 24.0,
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 12.0)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  logFirebaseEvent(
                                                      'AUDIO_DIALOG_COMP_Row_cn8ye6ot_ON_TAP');
                                                  logFirebaseEvent(
                                                      'Row_haptic_feedback');
                                                  HapticFeedback.lightImpact();
                                                  if ((currentUserDocument
                                                              ?.wishAudioList
                                                              ?.toList() ??
                                                          [])
                                                      .contains(widget!
                                                          .audioComp
                                                          ?.reference
                                                          .id)) {
                                                    logFirebaseEvent(
                                                        'Row_backend_call');

                                                    await currentUserReference!
                                                        .update({
                                                      ...mapToFirestore(
                                                        {
                                                          'wishAudioList':
                                                              FieldValue
                                                                  .arrayRemove([
                                                            widget!.audioComp
                                                                ?.reference.id
                                                          ]),
                                                        },
                                                      ),
                                                    });
                                                  } else {
                                                    logFirebaseEvent(
                                                        'Row_backend_call');

                                                    await currentUserReference!
                                                        .update({
                                                      ...mapToFirestore(
                                                        {
                                                          'wishAudioList':
                                                              FieldValue
                                                                  .arrayUnion([
                                                            widget!.audioComp
                                                                ?.reference.id
                                                          ]),
                                                        },
                                                      ),
                                                    });
                                                  }
                                                },
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Builder(
                                                      builder: (context) {
                                                        if ((currentUserDocument
                                                                    ?.wishAudioList
                                                                    ?.toList() ??
                                                                [])
                                                            .contains(widget!
                                                                .audioComp
                                                                ?.reference
                                                                .id)) {
                                                          return Icon(
                                                            FFIcons.klikeOn,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            size: 24.0,
                                                          );
                                                        } else {
                                                          return Icon(
                                                            FFIcons.klikeOff,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            size: 24.0,
                                                          );
                                                        }
                                                      },
                                                    ),
                                                    Expanded(
                                                      child:
                                                          AuthUserStreamWidget(
                                                        builder: (context) =>
                                                            Text(
                                                          valueOrDefault<
                                                              String>(
                                                            (currentUserDocument
                                                                            ?.wishAudioList
                                                                            ?.toList() ??
                                                                        [])
                                                                    .contains(widget!
                                                                        .audioComp
                                                                        ?.reference
                                                                        .id)
                                                                ? 'Удалить из избранного'
                                                                : 'Добавить в избранное',
                                                            'Добавить в избранное',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .titleMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMediumFamily,
                                                                letterSpacing:
                                                                    0.0,
                                                                lineHeight:
                                                                    1.25,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleMediumIsCustom,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                    Icon(
                                                      FFIcons.kright3,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      size: 24.0,
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 12.0)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
                                        'AUDIO_DIALOG_COMP_cancelButton_ON_TAP');
                                    logFirebaseEvent(
                                        'cancelButton_haptic_feedback');
                                    HapticFeedback.mediumImpact();
                                    logFirebaseEvent(
                                        'cancelButton_bottom_sheet');
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
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
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
                                      color:
                                          FlutterFlowTheme.of(context).white12,
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
                    ],
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
