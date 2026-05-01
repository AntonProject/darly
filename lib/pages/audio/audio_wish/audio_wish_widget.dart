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
import 'audio_wish_model.dart';
export 'audio_wish_model.dart';

class AudioWishWidget extends StatefulWidget {
  const AudioWishWidget({
    super.key,
    required this.audioList,
    required this.title,
  });

  final List<AudioRecord>? audioList;
  final String? title;

  static String routeName = 'AudioWish';
  static String routePath = '/audioWish';

  @override
  State<AudioWishWidget> createState() => _AudioWishWidgetState();
}

class _AudioWishWidgetState extends State<AudioWishWidget> {
  late AudioWishModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AudioWishModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'AudioWish'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('AUDIO_WISH_PAGE_AudioWish_ON_INIT_STATE');
      logFirebaseEvent('AudioWish_custom_action');
      unawaited(
        () async {
          await actions.setStatusBarColor();
        }(),
      );
      logFirebaseEvent('AudioWish_custom_action');
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
        title: 'AudioWish',
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
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.asset(
                      'assets/images/Page-Podcasts-4.webp',
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
                                  'AUDIO_WISH_Container_l71v3uko_CALLBACK');
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
                                        'Избранное',
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
                                        final audio = functions
                                                .audioList(
                                                    widget!.audioList?.toList())
                                                ?.toList() ??
                                            [];
                                        if (audio.isEmpty) {
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
                                          itemCount: audio.length,
                                          separatorBuilder: (_, __) =>
                                              SizedBox(height: 8.0),
                                          itemBuilder: (context, audioIndex) {
                                            final audioItem = audio[audioIndex];
                                            return AudioHomeCompWidget(
                                              key: Key(
                                                  'Key0ck_${audioIndex}_of_${audio.length}'),
                                              index: audioIndex,
                                              audio: audioItem,
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
