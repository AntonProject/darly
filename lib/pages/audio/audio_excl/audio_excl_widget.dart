import '/backend/backend.dart';
import '/components/back_button/back_button_widget.dart';
import '/components/empty_list/empty_list_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/audio/audio_home_comp/audio_home_comp_widget.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'audio_excl_model.dart';
export 'audio_excl_model.dart';

class AudioExclWidget extends StatefulWidget {
  const AudioExclWidget({
    super.key,
    required this.audioList,
    required this.title,
  });

  final List<AudioRecord>? audioList;
  final String? title;

  static String routeName = 'AudioExcl';
  static String routePath = '/audioExcl';

  @override
  State<AudioExclWidget> createState() => _AudioExclWidgetState();
}

class _AudioExclWidgetState extends State<AudioExclWidget> {
  late AudioExclModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AudioExclModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'AudioExcl'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('AUDIO_EXCL_PAGE_AudioExcl_ON_INIT_STATE');
      logFirebaseEvent('AudioExcl_custom_action');
      unawaited(
        () async {
          await actions.setStatusBarColor();
        }(),
      );
      logFirebaseEvent('AudioExcl_custom_action');
      unawaited(
        () async {
          await actions.lockLandscapeMode();
        }(),
      );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
        title: 'AudioExcl',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Align(
              alignment: AlignmentDirectional(0.0, -1.0),
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  maxWidth: double.infinity,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.asset(
                      'assets/images/Page-Podcasts-2.webp',
                    ).image,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 54.0, 0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1.0, 0.0),
                        child: wrapWithModel(
                          model: _model.backButtonModel,
                          updateCallback: () => safeSetState(() {}),
                          child: BackButtonWidget(
                            icon: Icon(
                              FFIcons.kleftIcon3,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            action: () async {
                              logFirebaseEvent(
                                  'AUDIO_EXCL_Container_zgk11tmj_CALLBACK');
                              logFirebaseEvent('backButton_navigate_back');
                              context.safePop();
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: 600.0,
                          ),
                          decoration: BoxDecoration(),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 8.0, 20.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 16.0, 0.0, 16.0),
                                    child: Text(
                                      valueOrDefault<String>(
                                        widget!.title,
                                        'Эксклюзив',
                                      ).toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .headlineMediumFamily,
                                            letterSpacing: 0.0,
                                            lineHeight: 1.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .headlineMediumIsCustom,
                                          ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 20.0, 0.0, 0.0),
                                    child: Builder(
                                      builder: (context) {
                                        final audioList = functions
                                                .audioList(
                                                    widget!.audioList?.toList())
                                                ?.toList() ??
                                            [];
                                        if (audioList.isEmpty) {
                                          return Center(
                                            child: EmptyListWidget(),
                                          );
                                        }

                                        return ListView.separated(
                                          padding: EdgeInsets.fromLTRB(
                                            0,
                                            0,
                                            0,
                                            120.0,
                                          ),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: audioList.length,
                                          separatorBuilder: (_, __) =>
                                              SizedBox(height: 8.0),
                                          itemBuilder:
                                              (context, audioListIndex) {
                                            final audioListItem =
                                                audioList[audioListIndex];
                                            return AudioHomeCompWidget(
                                              key: Key(
                                                  'Key82t_${audioListIndex}_of_${audioList.length}'),
                                              index: audioListIndex,
                                              audio: audioListItem,
                                              listAudio: functions.audioList(
                                                  widget!.audioList?.toList()),
                                              title: widget!.title,
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ].addToEnd(SizedBox(height: 34.0)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
