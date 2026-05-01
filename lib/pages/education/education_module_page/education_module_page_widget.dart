import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/back_button/back_button_widget.dart';
import '/components/empty_list/empty_list_widget.dart';
import '/components/navbar/navbar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/education/education_module_lesson_comp/education_module_lesson_comp_widget.dart';
import '/web/navbar_web/navbar_web_widget.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'education_module_page_model.dart';
export 'education_module_page_model.dart';

class EducationModulePageWidget extends StatefulWidget {
  const EducationModulePageWidget({
    super.key,
    required this.module,
  });

  final EducationModulesRecord? module;

  static String routeName = 'EducationModulePage';
  static String routePath = '/educationModulePage';

  @override
  State<EducationModulePageWidget> createState() =>
      _EducationModulePageWidgetState();
}

class _EducationModulePageWidgetState extends State<EducationModulePageWidget> {
  late EducationModulePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EducationModulePageModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'EducationModulePage'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('EDUCATION_MODULE_EducationModulePage_ON_');
      logFirebaseEvent('EducationModulePage_custom_action');
      unawaited(
        () async {
          await actions.setStatusBarColor();
        }(),
      );
      logFirebaseEvent('EducationModulePage_custom_action');
      unawaited(
        () async {
          await actions.lockLandscapeMode();
        }(),
      );
      logFirebaseEvent('EducationModulePage_firestore_query');
      _model.countQuery = await queryEducationModuleLessonsRecordCount(
        queryBuilder: (educationModuleLessonsRecord) =>
            educationModuleLessonsRecord.where(
          'moduleId',
          isEqualTo: widget!.module?.reference.id,
        ),
      );
      logFirebaseEvent('EducationModulePage_update_page_state');
      _model.countLessons = _model.countQuery;
      safeSetState(() {});
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
        title: 'EducationModulePage',
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
                            Align(
                              alignment: AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 54.0, 0.0, 4.0),
                                child: wrapWithModel(
                                  model: _model.backButtonModel,
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
                                          'EDUCATION_MODULE_Container_9mncp683_CALL');
                                      logFirebaseEvent(
                                          'backButton_navigate_back');
                                      context.safePop();
                                    },
                                  ),
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
                                      20.0, 0.0, 20.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(
                                            valueOrDefault<double>(
                                              () {
                                                if (MediaQuery.sizeOf(context)
                                                        .width <
                                                    kBreakpointSmall) {
                                                  return -1.0;
                                                } else if (MediaQuery.sizeOf(
                                                            context)
                                                        .width <
                                                    kBreakpointMedium) {
                                                  return -1.0;
                                                } else if (MediaQuery.sizeOf(
                                                            context)
                                                        .width <
                                                    kBreakpointLarge) {
                                                  return 0.0;
                                                } else {
                                                  return 0.0;
                                                }
                                              }(),
                                              0.0,
                                            ),
                                            0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 20.0, 0.0, 20.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Модуль №${valueOrDefault<String>(
                                                  widget!.module?.number
                                                      ?.toString(),
                                                  '1',
                                                )}',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMediumFamily,
                                                          fontSize: 15.0,
                                                          letterSpacing: 0.0,
                                                          lineHeight: 1.24,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelMediumIsCustom,
                                                        ),
                                              ),
                                              Text(
                                                valueOrDefault<String>(
                                                  widget!.module?.title,
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
                                                          letterSpacing: 0.0,
                                                          lineHeight: 1.4,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineMediumIsCustom,
                                                        ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    valueOrDefault<double>(
                                                      () {
                                                        if (MediaQuery.sizeOf(
                                                                    context)
                                                                .width <
                                                            kBreakpointSmall) {
                                                          return -1.0;
                                                        } else if (MediaQuery
                                                                    .sizeOf(
                                                                        context)
                                                                .width <
                                                            kBreakpointMedium) {
                                                          return -1.0;
                                                        } else if (MediaQuery
                                                                    .sizeOf(
                                                                        context)
                                                                .width <
                                                            kBreakpointLarge) {
                                                          return 0.0;
                                                        } else {
                                                          return 0.0;
                                                        }
                                                      }(),
                                                      0.0,
                                                    ),
                                                    -1.0),
                                                child: StreamBuilder<
                                                    List<
                                                        EducationModuleLessonsRecord>>(
                                                  stream:
                                                      queryEducationModuleLessonsRecord(
                                                    queryBuilder:
                                                        (educationModuleLessonsRecord) =>
                                                            educationModuleLessonsRecord
                                                                .where(
                                                                  'moduleId',
                                                                  isEqualTo: widget!
                                                                      .module
                                                                      ?.reference
                                                                      .id,
                                                                )
                                                                .orderBy(
                                                                    'number'),
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
                                                    List<EducationModuleLessonsRecord>
                                                        wrapEducationModuleLessonsRecordList =
                                                        snapshot.data!;
                                                    if (wrapEducationModuleLessonsRecordList
                                                        .isEmpty) {
                                                      return EmptyListWidget();
                                                    }

                                                    return Wrap(
                                                      spacing: 15.0,
                                                      runSpacing: 5.0,
                                                      alignment:
                                                          WrapAlignment.start,
                                                      crossAxisAlignment:
                                                          WrapCrossAlignment
                                                              .start,
                                                      direction:
                                                          Axis.horizontal,
                                                      runAlignment:
                                                          WrapAlignment.start,
                                                      verticalDirection:
                                                          VerticalDirection
                                                              .down,
                                                      clipBehavior: Clip.none,
                                                      children: List.generate(
                                                          wrapEducationModuleLessonsRecordList
                                                              .length,
                                                          (wrapIndex) {
                                                        final wrapEducationModuleLessonsRecord =
                                                            wrapEducationModuleLessonsRecordList[
                                                                wrapIndex];
                                                        return InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            logFirebaseEvent(
                                                                'EDUCATION_MODULE_Container_yuhb8sn2_ON_T');
                                                            if ((wrapEducationModuleLessonsRecord
                                                                        .startDate !=
                                                                    null) &&
                                                                !valueOrDefault<
                                                                    bool>(
                                                                  functions.dateGreatherThanToday(
                                                                      wrapEducationModuleLessonsRecord
                                                                          .startDate),
                                                                  false,
                                                                )) {
                                                              logFirebaseEvent(
                                                                  'educationModuleLessonComp_navigate_to');

                                                              context.pushNamed(
                                                                EducationModuleLessonPageWidget
                                                                    .routeName,
                                                                queryParameters:
                                                                    {
                                                                  'lesson':
                                                                      serializeParam(
                                                                    wrapEducationModuleLessonsRecord,
                                                                    ParamType
                                                                        .Document,
                                                                  ),
                                                                  'count':
                                                                      serializeParam(
                                                                    valueOrDefault<
                                                                        int>(
                                                                      _model
                                                                          .countLessons,
                                                                      1,
                                                                    ),
                                                                    ParamType
                                                                        .int,
                                                                  ),
                                                                }.withoutNulls,
                                                                extra: <String,
                                                                    dynamic>{
                                                                  'lesson':
                                                                      wrapEducationModuleLessonsRecord,
                                                                  '__transition_info__':
                                                                      TransitionInfo(
                                                                    hasTransition:
                                                                        true,
                                                                    transitionType:
                                                                        PageTransitionType
                                                                            .fade,
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            0),
                                                                  ),
                                                                },
                                                              );
                                                            }
                                                          },
                                                          child:
                                                              EducationModuleLessonCompWidget(
                                                            key: Key(
                                                                'Keyyuh_${wrapIndex}_of_${wrapEducationModuleLessonsRecordList.length}'),
                                                            lesson:
                                                                wrapEducationModuleLessonsRecord,
                                                          ),
                                                        );
                                                      }),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ].addToEnd(SizedBox(
                                                height: valueOrDefault<double>(
                                              () {
                                                if (MediaQuery.sizeOf(context)
                                                        .width <
                                                    kBreakpointSmall) {
                                                  return 120.0;
                                                } else if (MediaQuery.sizeOf(
                                                            context)
                                                        .width <
                                                    kBreakpointMedium) {
                                                  return 120.0;
                                                } else if (MediaQuery.sizeOf(
                                                            context)
                                                        .width <
                                                    kBreakpointLarge) {
                                                  return 24.0;
                                                } else {
                                                  return 24.0;
                                                }
                                              }(),
                                              24.0,
                                            ))),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  wrapWithModel(
                    model: _model.navbarModel,
                    updateCallback: () => safeSetState(() {}),
                    child: NavbarWidget(
                      pageNum: 2.1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
