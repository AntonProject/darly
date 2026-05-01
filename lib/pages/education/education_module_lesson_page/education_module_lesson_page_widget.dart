import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/back_button/back_button_widget.dart';
import '/components/empty_list/empty_list_widget.dart';
import '/components/file_comp/file_comp_widget.dart';
import '/components/navbar/navbar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/audio/audio_education/audio_education_widget.dart';
import '/pages/education/education_lesson_note_dialog/education_lesson_note_dialog_widget.dart';
import '/pages/education/lesson_chapter/lesson_chapter_widget.dart';
import '/web/navbar_web/navbar_web_widget.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'education_module_lesson_page_model.dart';
export 'education_module_lesson_page_model.dart';

class EducationModuleLessonPageWidget extends StatefulWidget {
  const EducationModuleLessonPageWidget({
    super.key,
    required this.lesson,
    int? count,
  }) : this.count = count ?? 1;

  final EducationModuleLessonsRecord? lesson;
  final int count;

  static String routeName = 'EducationModuleLessonPage';
  static String routePath = '/educationModuleLessonPage';

  @override
  State<EducationModuleLessonPageWidget> createState() =>
      _EducationModuleLessonPageWidgetState();
}

class _EducationModuleLessonPageWidgetState
    extends State<EducationModuleLessonPageWidget> {
  late EducationModuleLessonPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EducationModuleLessonPageModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'EducationModuleLessonPage'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('EDUCATION_MODULE_LESSON_EducationModuleL');
      logFirebaseEvent('EducationModuleLessonPage_custom_action');
      unawaited(
        () async {
          await actions.setStatusBarColor();
        }(),
      );
      if (!(currentUserDocument?.lessonsUser?.toList() ?? [])
          .contains(widget!.lesson?.reference)) {
        logFirebaseEvent('EducationModuleLessonPage_backend_call');
        unawaited(
          () async {
            await currentUserReference!.update({
              ...mapToFirestore(
                {
                  'lessonsUser':
                      FieldValue.arrayUnion([widget!.lesson?.reference]),
                },
              ),
            });
          }(),
        );
      }
      logFirebaseEvent('EducationModuleLessonPage_custom_action');
      unawaited(
        () async {
          await actions.unlockLandscapeMode();
        }(),
      );
    });

    _model.messageFieldTextController ??= TextEditingController();
    _model.messageFieldFocusNode ??= FocusNode();

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
        title: 'EducationModuleLessonPage',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.asset(
                    'assets/images/Background.webp',
                  ).image,
                ),
              ),
              child: Stack(
                alignment: AlignmentDirectional(0.0, 1.0),
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (isWeb &&
                          responsiveVisibility(
                            context: context,
                            phone: false,
                            tablet: false,
                          ))
                        wrapWithModel(
                          model: _model.navbarWebModel,
                          updateCallback: () => safeSetState(() {}),
                          updateOnChange: true,
                          child: NavbarWebWidget(
                            pageNum: 2.1,
                          ),
                        ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 54.0, 0.0, 4.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                    child: wrapWithModel(
                                      model: _model.backButtonModel1,
                                      updateCallback: () => safeSetState(() {}),
                                      child: BackButtonWidget(
                                        icon: Icon(
                                          FFIcons.kleftIcon3,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 24.0,
                                        ),
                                        action: () async {
                                          logFirebaseEvent(
                                              'EDUCATION_MODULE_LESSON_Container_e97mpt');
                                          logFirebaseEvent(
                                              'backButton_navigate_back');
                                          context.safePop();
                                          logFirebaseEvent(
                                              'backButton_custom_action');
                                          unawaited(
                                            () async {
                                              await actions.lockLandscapeMode();
                                            }(),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Text(
                                    valueOrDefault<String>(
                                      'Урок ${valueOrDefault<String>(
                                        widget!.lesson?.number?.toString(),
                                        '1',
                                      )} из ${valueOrDefault<String>(
                                        widget!.count.toString(),
                                        '1',
                                      )}',
                                      'Урок 1 из 1',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .titleMediumFamily,
                                          fontSize: 17.0,
                                          letterSpacing: 0.0,
                                          lineHeight: 1.2,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .titleMediumIsCustom,
                                        ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 12.0, 0.0),
                                      child: wrapWithModel(
                                        model: _model.backButtonModel2,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: BackButtonWidget(
                                          icon: Icon(
                                            FFIcons.kbook,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 24.0,
                                          ),
                                          action: () async {
                                            logFirebaseEvent(
                                                'EDUCATION_MODULE_LESSON_Container_orw17y');
                                            logFirebaseEvent(
                                                'backButton_haptic_feedback');
                                            HapticFeedback.mediumImpact();
                                            logFirebaseEvent(
                                                'backButton_bottom_sheet');
                                            showModalBottomSheet(
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  Colors.transparent,
                                              useSafeArea: true,
                                              context: context,
                                              builder: (context) {
                                                return WebViewAware(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                      FocusManager
                                                          .instance.primaryFocus
                                                          ?.unfocus();
                                                    },
                                                    child: Padding(
                                                      padding: MediaQuery
                                                          .viewInsetsOf(
                                                              context),
                                                      child:
                                                          EducationLessonNoteDialogWidget(
                                                        lessonId: widget!
                                                            .lesson!
                                                            .reference
                                                            .id,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ).then(
                                                (value) => safeSetState(() {}));
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: 800.0,
                                ),
                                decoration: BoxDecoration(),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if ((widget!.lesson?.video != null &&
                                              widget!.lesson?.video != '') ||
                                          (widget!.lesson?.image != null &&
                                              widget!.lesson?.image != ''))
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 20.0, 20.0, 0.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14.0),
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiary,
                                              ),
                                            ),
                                            child: Builder(
                                              builder: (context) {
                                                if (widget!.lesson?.video !=
                                                        null &&
                                                    widget!.lesson?.video !=
                                                        '') {
                                                  return Container(
                                                    width: double.infinity,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .height *
                                                        0.3,
                                                    child: custom_widgets
                                                        .PaymentWebview(
                                                      width: double.infinity,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.3,
                                                      html:
                                                          widget!.lesson?.video,
                                                    ),
                                                  );
                                                } else {
                                                  return ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14.0),
                                                    child: CachedNetworkImage(
                                                      fadeInDuration: Duration(
                                                          milliseconds: 500),
                                                      fadeOutDuration: Duration(
                                                          milliseconds: 500),
                                                      imageUrl: getCORSProxyUrl(
                                                        widget!.lesson!.image,
                                                      ),
                                                      width: double.infinity,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.3,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      if (widget!.lesson?.title != null &&
                                          widget!.lesson?.title != '')
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20.0, 12.0, 20.0, 0.0),
                                            child: Text(
                                              valueOrDefault<String>(
                                                widget!.lesson?.title,
                                                'Не указано',
                                              )
                                                  .toUpperCase()
                                                  .maybeHandleOverflow(
                                                    maxChars: 30,
                                                    replacement: '…',
                                                  ),
                                              maxLines: 1,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineMediumFamily,
                                                        fontSize: 24.0,
                                                        letterSpacing: 0.0,
                                                        lineHeight: 1.4,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .headlineMediumIsCustom,
                                                      ),
                                            ),
                                          ),
                                        ),
                                      if (widget!.lesson?.description != null &&
                                          widget!.lesson?.description != '')
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20.0, 12.0, 20.0, 0.0),
                                            child: Text(
                                              widget!.lesson!.description,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelLarge
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelLargeFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    letterSpacing: 0.0,
                                                    lineHeight: 1.4,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .labelLargeIsCustom,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      if (widget!.lesson?.taskInformation !=
                                              null &&
                                          widget!.lesson?.taskInformation != '')
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 32.0, 20.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: Text(
                                                  'Задание:',
                                                  maxLines: 1,
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleLarge
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLargeFamily,
                                                            letterSpacing: 0.0,
                                                            lineHeight: 1.4,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLargeIsCustom,
                                                          ),
                                                ),
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 16.0, 0.0, 0.0),
                                                  child: Text(
                                                    widget!.lesson!
                                                        .taskInformation,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelLarge
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLargeFamily,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          letterSpacing: 0.0,
                                                          lineHeight: 1.4,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelLargeIsCustom,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      if (widget!.lesson?.audioId != null &&
                                          widget!.lesson?.audioId != '')
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 32.0, 20.0, 0.0),
                                          child: wrapWithModel(
                                            model: _model.audioEducationModel,
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            updateOnChange: true,
                                            child: AudioEducationWidget(
                                              audioId: widget!.lesson!.audioId,
                                            ),
                                          ),
                                        ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 0.0, 20.0, 0.0),
                                        child: FutureBuilder<
                                            List<
                                                EducationModuleLessonChaptersRecord>>(
                                          future:
                                              queryEducationModuleLessonChaptersRecordOnce(
                                            queryBuilder:
                                                (educationModuleLessonChaptersRecord) =>
                                                    educationModuleLessonChaptersRecord
                                                        .where(
                                                          'lessonId',
                                                          isEqualTo: widget!
                                                              .lesson
                                                              ?.reference
                                                              .id,
                                                        )
                                                        .orderBy('number'),
                                          ),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 1.0,
                                                  height: 1.0,
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(
                                                      Colors.transparent,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                            List<EducationModuleLessonChaptersRecord>
                                                columnEducationModuleLessonChaptersRecordList =
                                                snapshot.data!;

                                            return Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: List.generate(
                                                      columnEducationModuleLessonChaptersRecordList
                                                          .length, (columnIndex) {
                                                final columnEducationModuleLessonChaptersRecord =
                                                    columnEducationModuleLessonChaptersRecordList[
                                                        columnIndex];
                                                return LessonChapterWidget(
                                                  key: Key(
                                                      'Key1b8_${columnIndex}_of_${columnEducationModuleLessonChaptersRecordList.length}'),
                                                  chapter:
                                                      columnEducationModuleLessonChaptersRecord,
                                                );
                                              })
                                                  .divide(
                                                      SizedBox(height: 32.0))
                                                  .addToStart(
                                                      SizedBox(height: 32.0)),
                                            );
                                          },
                                        ),
                                      ),
                                      if (widget!.lesson!.files.length > 0)
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20.0, 32.0, 20.0, 0.0),
                                            child: Text(
                                              'Материалы урока',
                                              maxLines: 1,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLarge
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLargeFamily,
                                                        letterSpacing: 0.0,
                                                        lineHeight: 1.4,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .titleLargeIsCustom,
                                                      ),
                                            ),
                                          ),
                                        ),
                                      if (widget!.lesson!.files.length > 0)
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20.0, 0.0, 20.0, 0.0),
                                            child: Builder(
                                              builder: (context) {
                                                final files = widget!
                                                        .lesson?.files
                                                        ?.toList() ??
                                                    [];
                                                if (files.isEmpty) {
                                                  return EmptyListWidget();
                                                }

                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: List.generate(
                                                          files.length,
                                                          (filesIndex) {
                                                    final filesItem =
                                                        files[filesIndex];
                                                    return FileCompWidget(
                                                      key: Key(
                                                          'Keydhu_${filesIndex}_of_${files.length}'),
                                                      fileURL: filesItem,
                                                      bgColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .white12,
                                                    );
                                                  })
                                                      .divide(SizedBox(
                                                          height: 16.0))
                                                      .addToStart(SizedBox(
                                                          height: 16.0)),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                    ].addToEnd(SizedBox(
                                        height: valueOrDefault<double>(
                                      () {
                                        if (MediaQuery.sizeOf(context).width <
                                            kBreakpointSmall) {
                                          return 120.0;
                                        } else if (MediaQuery.sizeOf(context)
                                                .width <
                                            kBreakpointMedium) {
                                          return 120.0;
                                        } else if (MediaQuery.sizeOf(context)
                                                .width <
                                            kBreakpointLarge) {
                                          return 24.0;
                                        } else {
                                          return 24.0;
                                        }
                                      }(),
                                      120.0,
                                    ))),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isWeb &&
                          responsiveVisibility(
                            context: context,
                            phone: false,
                            tablet: false,
                          ))
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            VerticalDivider(
                              width: 1.0,
                              thickness: 1.0,
                              color: FlutterFlowTheme.of(context).tertiary,
                            ),
                            if (valueOrDefault<bool>(
                              functions.dateGreatherThanToday(
                                  currentUserDocument
                                      ?.educationSubscriptionExpDate),
                              false,
                            ))
                              Align(
                                alignment: AlignmentDirectional(-1.0, 0.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => Container(
                                    width: 320.0,
                                    height:
                                        MediaQuery.sizeOf(context).height * 1.0,
                                    constraints: BoxConstraints(
                                      maxWidth: 260.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: Image.asset(
                                          'assets/images/Background.webp',
                                        ).image,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 0.0, 20.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'ЗАМЕТКА ОБ УРОКЕ',
                                            style: FlutterFlowTheme.of(context)
                                                .titleSmall
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmallFamily,
                                                  fontSize: 17.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmallIsCustom,
                                                ),
                                          ),
                                          Expanded(
                                            child: StreamBuilder<
                                                List<
                                                    EducationModuleNotesRecord>>(
                                              stream:
                                                  queryEducationModuleNotesRecord(
                                                queryBuilder:
                                                    (educationModuleNotesRecord) =>
                                                        educationModuleNotesRecord
                                                            .where(
                                                              'lessonId',
                                                              isEqualTo: widget!
                                                                          .lesson
                                                                          ?.reference
                                                                          .id !=
                                                                      ''
                                                                  ? widget!
                                                                      .lesson
                                                                      ?.reference
                                                                      .id
                                                                  : null,
                                                            )
                                                            .orderBy(
                                                                'created_at',
                                                                descending:
                                                                    true),
                                              ),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 20.0,
                                                      height: 20.0,
                                                      child:
                                                          CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                Color>(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                                List<EducationModuleNotesRecord>
                                                    listViewEducationModuleNotesRecordList =
                                                    snapshot.data!;

                                                return ListView.separated(
                                                  padding: EdgeInsets.fromLTRB(
                                                    0,
                                                    16.0,
                                                    0,
                                                    0,
                                                  ),
                                                  reverse: true,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount:
                                                      listViewEducationModuleNotesRecordList
                                                          .length,
                                                  separatorBuilder: (_, __) =>
                                                      SizedBox(height: 16.0),
                                                  itemBuilder:
                                                      (context, listViewIndex) {
                                                    final listViewEducationModuleNotesRecord =
                                                        listViewEducationModuleNotesRecordList[
                                                            listViewIndex];
                                                    return Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.0, 0.0),
                                                      child: Container(
                                                        constraints:
                                                            BoxConstraints(
                                                          maxWidth:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.75,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .white12,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    12.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    12.0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    12.0),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              if (listViewEducationModuleNotesRecord
                                                                          .text !=
                                                                      null &&
                                                                  listViewEducationModuleNotesRecord
                                                                          .text !=
                                                                      '')
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          4.0,
                                                                          0.0,
                                                                          4.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    listViewEducationModuleNotesRecord
                                                                        .text,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context).bodyLargeFamily,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          lineHeight:
                                                                              1.25,
                                                                          useGoogleFonts:
                                                                              !FlutterFlowTheme.of(context).bodyLargeIsCustom,
                                                                        ),
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            constraints: BoxConstraints(
                                              minHeight: 48.0,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .white12,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 24.0,
                                                  color: Color(0x1F2A2929),
                                                  offset: Offset(
                                                    0.0,
                                                    4.0,
                                                  ),
                                                  spreadRadius: 0.0,
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                width: 1.0,
                                              ),
                                            ),
                                            child: Stack(
                                              alignment: AlignmentDirectional(
                                                  1.0, 0.0),
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  child: TextFormField(
                                                    controller: _model
                                                        .messageFieldTextController,
                                                    focusNode: _model
                                                        .messageFieldFocusNode,
                                                    onChanged: (_) =>
                                                        EasyDebounce.debounce(
                                                      '_model.messageFieldTextController',
                                                      Duration(
                                                          milliseconds: 500),
                                                      () => safeSetState(() {}),
                                                    ),
                                                    onFieldSubmitted:
                                                        (_) async {
                                                      logFirebaseEvent(
                                                          'EDUCATION_MODULE_LESSON_messageField_ON_');
                                                      if (_model.messageFieldTextController
                                                                  .text !=
                                                              null &&
                                                          _model.messageFieldTextController
                                                                  .text !=
                                                              '') {
                                                        logFirebaseEvent(
                                                            'messageField_backend_call');

                                                        await EducationModuleNotesRecord
                                                            .collection
                                                            .doc()
                                                            .set(
                                                                createEducationModuleNotesRecordData(
                                                              createdAt:
                                                                  getCurrentTimestamp,
                                                              createdBy:
                                                                  currentUserUid,
                                                              text: _model
                                                                  .messageFieldTextController
                                                                  .text,
                                                              lessonId: widget!
                                                                  .lesson
                                                                  ?.reference
                                                                  .id,
                                                            ));
                                                        logFirebaseEvent(
                                                            'messageField_clear_text_fields_pin_codes');
                                                        safeSetState(() {
                                                          _model
                                                              .messageFieldTextController
                                                              ?.clear();
                                                        });
                                                      }
                                                    },
                                                    autofocus: false,
                                                    textInputAction:
                                                        TextInputAction.send,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      isDense: false,
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumFamily,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMediumIsCustom,
                                                              ),
                                                      hintText:
                                                          'Напишите заметки об уроке',
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                fontSize: 15.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                                lineHeight:
                                                                    1.25,
                                                              ),
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      focusedErrorBorder:
                                                          InputBorder.none,
                                                      contentPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  16.0,
                                                                  0.0,
                                                                  50.0,
                                                                  0.0),
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          lineHeight: 1.25,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMediumIsCustom,
                                                        ),
                                                    maxLines: 10,
                                                    minLines: 1,
                                                    cursorColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                    enableInteractiveSelection:
                                                        true,
                                                    validator: _model
                                                        .messageFieldTextControllerValidator
                                                        .asValidator(context),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 2.0, 4.0, 2.0),
                                                  child: Container(
                                                    width: 40.0,
                                                    height: 40.0,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          valueOrDefault<Color>(
                                                        _model.messageFieldTextController
                                                                        .text ==
                                                                    null ||
                                                                _model
                                                                        .messageFieldTextController
                                                                        .text ==
                                                                    ''
                                                            ? FlutterFlowTheme
                                                                    .of(context)
                                                                .white12
                                                            : FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .white12,
                                                      ),
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                    ),
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
                                                            'EDUCATION_MODULE_LESSON_Icon_fkm1fwwx_ON');
                                                        if (_model.messageFieldTextController
                                                                    .text !=
                                                                null &&
                                                            _model.messageFieldTextController
                                                                    .text !=
                                                                '') {
                                                          logFirebaseEvent(
                                                              'Icon_backend_call');

                                                          await EducationModuleNotesRecord
                                                              .collection
                                                              .doc()
                                                              .set(
                                                                  createEducationModuleNotesRecordData(
                                                                createdAt:
                                                                    getCurrentTimestamp,
                                                                createdBy:
                                                                    currentUserUid,
                                                                text: _model
                                                                    .messageFieldTextController
                                                                    .text,
                                                                lessonId: widget!
                                                                    .lesson
                                                                    ?.reference
                                                                    .id,
                                                              ));
                                                          logFirebaseEvent(
                                                              'Icon_clear_text_fields_pin_codes');
                                                          safeSetState(() {
                                                            _model
                                                                .messageFieldTextController
                                                                ?.clear();
                                                          });
                                                        }
                                                      },
                                                      child: Icon(
                                                        FFIcons.karrowUp,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 24.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]
                                            .divide(SizedBox(height: 16.0))
                                            .addToStart(SizedBox(height: 20.0))
                                            .addToEnd(SizedBox(height: 24.0)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                    ],
                  ),
                  wrapWithModel(
                    model: _model.navbarModel,
                    updateCallback: () => safeSetState(() {}),
                    child: NavbarWidget(
                      pageNum: 2.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
