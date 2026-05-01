import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_list/empty_list_widget.dart';
import '/components/navbar/navbar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/audio/audio_category/audio_category_widget.dart';
import '/pages/audio/audio_home_comp/audio_home_comp_widget.dart';
import '/pages/payment/premium/premium_widget.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'audio_page_model.dart';
export 'audio_page_model.dart';

class AudioPageWidget extends StatefulWidget {
  const AudioPageWidget({super.key});

  static String routeName = 'AudioPage';
  static String routePath = '/audioPage';

  @override
  State<AudioPageWidget> createState() => _AudioPageWidgetState();
}

class _AudioPageWidgetState extends State<AudioPageWidget> {
  late AudioPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AudioPageModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'AudioPage'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('AUDIO_PAGE_PAGE_AudioPage_ON_INIT_STATE');
      logFirebaseEvent('AudioPage_custom_action');
      unawaited(
        () async {
          await actions.closeKeyboard(
            context,
          );
        }(),
      );
      if (isWeb) {
        logFirebaseEvent('AudioPage_navigate_to');

        context.goNamed(
          EducationPageWidget.routeName,
          extra: <String, dynamic>{
            '__transition_info__': TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.fade,
              duration: Duration(milliseconds: 0),
            ),
          },
        );
      }
      logFirebaseEvent('AudioPage_custom_action');
      unawaited(
        () async {
          await actions.setStatusBarColor();
        }(),
      );
      logFirebaseEvent('AudioPage_custom_action');
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
    context.watch<FFAppState>();

    return Title(
        title: 'AudioPage',
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
                    fit: BoxFit.fill,
                    image: Image.asset(
                      'assets/images/Background.webp',
                    ).image,
                  ),
                ),
                child: Stack(
                  alignment: AlignmentDirectional(0.0, 1.0),
                  children: [
                    FutureBuilder<List<AudioRecord>>(
                      future: queryAudioRecordOnce(
                        queryBuilder: (audioRecord) => audioRecord.where(
                          'hide',
                          isEqualTo: false,
                        ),
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 40.0,
                              height: 40.0,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.transparent,
                                ),
                              ),
                            ),
                          );
                        }
                        List<AudioRecord> containerAudioRecordList =
                            snapshot.data!;

                        return Container(
                          height: MediaQuery.sizeOf(context).height * 1.0,
                          constraints: BoxConstraints(
                            maxWidth: 600.0,
                          ),
                          decoration: BoxDecoration(),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 20.0, 20.0),
                                  child: Text(
                                    'ЧТО ХОЧЕШЬ СЕГОДНЯ ПОСЛУШАТЬ?',
                                    style: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .headlineMediumFamily,
                                          letterSpacing: 0.0,
                                          lineHeight: 1.25,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .headlineMediumIsCustom,
                                        ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: null,
                                  child: custom_widgets.DoubleRowList(
                                    width: double.infinity,
                                    height: null,
                                    list: functions.audioCategories(
                                        containerAudioRecordList
                                            .map((e) => e.category)
                                            .toList()),
                                    offset: 0.0,
                                    startEndSpacing: 20.0,
                                    itemBuilder: (String item) =>
                                        AudioCategoryWidget(
                                      title: item,
                                      selectedItem: _model.selectedItem!,
                                      select: (title) async {
                                        logFirebaseEvent(
                                            'AUDIO_Container_bv5cnnhh_CALLBACK');
                                        if (title == 'Избранное') {
                                          logFirebaseEvent(
                                              'DoubleRowList_navigate_to');

                                          context.pushNamed(
                                            AudioWishWidget.routeName,
                                            queryParameters: {
                                              'audioList': serializeParam(
                                                containerAudioRecordList
                                                    .where((e) =>
                                                        (currentUserDocument
                                                                    ?.wishAudioList
                                                                    ?.toList() ??
                                                                [])
                                                            .contains(
                                                                e.reference.id))
                                                    .toList(),
                                                ParamType.Document,
                                                isList: true,
                                              ),
                                              'title': serializeParam(
                                                title,
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                            extra: <String, dynamic>{
                                              'audioList': containerAudioRecordList
                                                  .where((e) =>
                                                      (currentUserDocument
                                                                  ?.wishAudioList
                                                                  ?.toList() ??
                                                              [])
                                                          .contains(
                                                              e.reference.id))
                                                  .toList(),
                                            },
                                          );
                                        } else {
                                          logFirebaseEvent(
                                              'DoubleRowList_update_page_state');
                                          _model.selectedItem = title;
                                          safeSetState(() {});
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      if (!functions.dateGreatherThanToday(
                                              currentUserDocument
                                                  ?.subscriptionExpDate) &&
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
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 24.0, 20.0, 0.0),
                                          child: AuthUserStreamWidget(
                                            builder: (context) => wrapWithModel(
                                              model: _model.premiumModel,
                                              updateCallback: () =>
                                                  safeSetState(() {}),
                                              child: PremiumWidget(),
                                            ),
                                          ),
                                        ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 8.0, 20.0, 0.0),
                                        child: Builder(
                                          builder: (context) {
                                            final audio = (_model
                                                                .selectedItem ==
                                                            'Новое'
                                                        ? functions.audioList(
                                                            containerAudioRecordList
                                                                .where((e) =>
                                                                    e.isNew)
                                                                .toList())
                                                        : functions.audioList(
                                                            containerAudioRecordList
                                                                .where((e) =>
                                                                    e.category ==
                                                                    _model
                                                                        .selectedItem)
                                                                .toList()))
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
                                                16.0,
                                                0,
                                                0,
                                              ),
                                              primary: false,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: audio.length,
                                              separatorBuilder: (_, __) =>
                                                  SizedBox(height: 8.0),
                                              itemBuilder:
                                                  (context, audioIndex) {
                                                final audioItem =
                                                    audio[audioIndex];
                                                return AudioHomeCompWidget(
                                                  key: Key(
                                                      'Key0jn_${audioIndex}_of_${audio.length}'),
                                                  index: audioIndex,
                                                  audio: audioItem,
                                                  listAudio: () {
                                                    if (_model.selectedItem ==
                                                        'Новое') {
                                                      return functions.audioList(
                                                          containerAudioRecordList
                                                              .where((e) =>
                                                                  e.isNew)
                                                              .toList());
                                                    } else if (_model
                                                            .selectedItem ==
                                                        'Эксклюзив') {
                                                      return functions.audioList(
                                                          containerAudioRecordList
                                                              .where((e) =>
                                                                  e.exclusive)
                                                              .toList());
                                                    } else {
                                                      return functions.audioList(
                                                          containerAudioRecordList
                                                              .where((e) =>
                                                                  e.category ==
                                                                  audioItem
                                                                      .category)
                                                              .toList());
                                                    }
                                                  }(),
                                                  title: _model.selectedItem,
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ].addToEnd(SizedBox(height: 120.0)),
                                  ),
                                ),
                              ].addToStart(SizedBox(height: 54.0)),
                            ),
                          ),
                        );
                      },
                    ),
                    wrapWithModel(
                      model: _model.navbarModel,
                      updateCallback: () => safeSetState(() {}),
                      child: NavbarWidget(
                        pageNum: 4.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
