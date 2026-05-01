import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_list/empty_list_widget.dart';
import '/components/navbar/navbar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/education/education_info_dialog/education_info_dialog_widget.dart';
import '/pages/education/education_module_comp/education_module_comp_widget.dart';
import '/pages/education/education_note_dialog/education_note_dialog_widget.dart';
import '/pages/education/review/review_widget.dart';
import '/web/navbar_web/navbar_web_widget.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'education_page_model.dart';
export 'education_page_model.dart';

class EducationPageWidget extends StatefulWidget {
  const EducationPageWidget({super.key});

  static String routeName = 'EducationPage';
  static String routePath = '/educationPage';

  @override
  State<EducationPageWidget> createState() => _EducationPageWidgetState();
}

class _EducationPageWidgetState extends State<EducationPageWidget> {
  late EducationPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EducationPageModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'EducationPage'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('EDUCATION_EducationPage_ON_INIT_STATE');
      logFirebaseEvent('EducationPage_custom_action');
      unawaited(
        () async {
          await actions.closeKeyboard(
            context,
          );
        }(),
      );
      logFirebaseEvent('EducationPage_custom_action');
      unawaited(
        () async {
          await actions.setStatusBarColor();
        }(),
      );
      logFirebaseEvent('EducationPage_custom_action');
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
        title: 'EducationPage',
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
                            pageNum: 2.0,
                          ),
                        ),
                      Expanded(
                        child: FutureBuilder<List<EducationRecord>>(
                          future: queryEducationRecordOnce(
                            singleRecord: true,
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
                            List<EducationRecord> rowEducationRecordList =
                                snapshot.data!;
                            // Return an empty Container when the item does not exist.
                            if (snapshot.data!.isEmpty) {
                              return Container();
                            }
                            final rowEducationRecord =
                                rowEducationRecordList.isNotEmpty
                                    ? rowEducationRecordList.first
                                    : null;

                            return Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        constraints: BoxConstraints(
                                          minHeight: MediaQuery.sizeOf(context)
                                                  .height *
                                              1.0,
                                        ),
                                        decoration: BoxDecoration(),
                                        child: SingleChildScrollView(
                                          controller: _model.columnController1,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.45,
                                                child: Stack(
                                                  children: [
                                                    if (rowEducationRecord
                                                                ?.image !=
                                                            null &&
                                                        rowEducationRecord
                                                                ?.image !=
                                                            '')
                                                      Container(
                                                        width: double.infinity,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.45,
                                                        child: custom_widgets
                                                            .MaskedImage(
                                                          width:
                                                              double.infinity,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.45,
                                                          imageUrl:
                                                              valueOrDefault<
                                                                  String>(
                                                            rowEducationRecord
                                                                ?.image,
                                                            'https://firebasestorage.googleapis.com/v0/b/woman-f4872.firebasestorage.app/o/Imagenew.jpg?alt=media&token=84fe7de2-aaea-471e-9a36-63be912af728',
                                                          ),
                                                          topRadius: 0.0,
                                                        ),
                                                      ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 1.0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    20.0,
                                                                    0.0,
                                                                    20.0,
                                                                    0.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            if (rowEducationRecord
                                                                        ?.title !=
                                                                    null &&
                                                                rowEducationRecord
                                                                        ?.title !=
                                                                    '')
                                                              Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  rowEducationRecord
                                                                      ?.title,
                                                                  'My Inspirations',
                                                                ),
                                                                maxLines: 2,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .ballet(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .customColor2,
                                                                      fontSize:
                                                                          48.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                      lineHeight:
                                                                          1.0,
                                                                    ),
                                                              ),
                                                            if (rowEducationRecord
                                                                        ?.subtitle !=
                                                                    null &&
                                                                rowEducationRecord
                                                                        ?.subtitle !=
                                                                    '')
                                                              AutoSizeText(
                                                                valueOrDefault<
                                                                    String>(
                                                                  rowEducationRecord
                                                                      ?.subtitle,
                                                                  'WOMAN  V',
                                                                ),
                                                                maxLines: 1,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .instrumentSerif(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      fontSize:
                                                                          84.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                      lineHeight:
                                                                          0.9,
                                                                    ),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, -1.0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    54.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Builder(
                                                          builder: (context) {
                                                            if (valueOrDefault<
                                                                    bool>(
                                                                  functions.dateGreatherThanToday(
                                                                      currentUserDocument
                                                                          ?.educationSubscriptionExpDate),
                                                                  false,
                                                                ) &&
                                                                !valueOrDefault<
                                                                    bool>(
                                                                  functions.dayGreatherThanToday(
                                                                      rowEducationRecord
                                                                          ?.startDate),
                                                                  false,
                                                                )) {
                                                              return Visibility(
                                                                visible:
                                                                    responsiveVisibility(
                                                                  context:
                                                                      context,
                                                                  tabletLandscape:
                                                                      false,
                                                                  desktop:
                                                                      false,
                                                                ),
                                                                child:
                                                                    SingleChildScrollView(
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  controller: _model
                                                                      .rowController,
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      if (rowEducationRecord?.information !=
                                                                              null &&
                                                                          rowEducationRecord?.information !=
                                                                              '')
                                                                        InkWell(
                                                                          splashColor:
                                                                              Colors.transparent,
                                                                          focusColor:
                                                                              Colors.transparent,
                                                                          hoverColor:
                                                                              Colors.transparent,
                                                                          highlightColor:
                                                                              Colors.transparent,
                                                                          onTap:
                                                                              () async {
                                                                            logFirebaseEvent('EDUCATION_Container_bda408kt_ON_TAP');
                                                                            logFirebaseEvent('Container_bottom_sheet');
                                                                            showModalBottomSheet(
                                                                              isScrollControlled: true,
                                                                              backgroundColor: Colors.transparent,
                                                                              useSafeArea: true,
                                                                              context: context,
                                                                              builder: (context) {
                                                                                return WebViewAware(
                                                                                  child: GestureDetector(
                                                                                    onTap: () {
                                                                                      FocusScope.of(context).unfocus();
                                                                                      FocusManager.instance.primaryFocus?.unfocus();
                                                                                    },
                                                                                    child: Padding(
                                                                                      padding: MediaQuery.viewInsetsOf(context),
                                                                                      child: EducationInfoDialogWidget(
                                                                                        text: rowEducationRecord!.information,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ).then((value) =>
                                                                                safeSetState(() {}));
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                36.0,
                                                                            constraints:
                                                                                BoxConstraints(
                                                                              minWidth: 141.0,
                                                                            ),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: FlutterFlowTheme.of(context).white12,
                                                                              borderRadius: BorderRadius.circular(100.0),
                                                                            ),
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(99.0),
                                                                              child: BackdropFilter(
                                                                                filter: ImageFilter.blur(
                                                                                  sigmaX: 6.0,
                                                                                  sigmaY: 14.0,
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Icon(
                                                                                        FFIcons.kinfo,
                                                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                                                        size: 24.0,
                                                                                      ),
                                                                                      Text(
                                                                                        'Информация',
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                              fontSize: 15.0,
                                                                                              letterSpacing: 0.0,
                                                                                              lineHeight: 1.25,
                                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                            ),
                                                                                      ),
                                                                                    ].divide(SizedBox(width: 4.0)),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      InkWell(
                                                                        splashColor:
                                                                            Colors.transparent,
                                                                        focusColor:
                                                                            Colors.transparent,
                                                                        hoverColor:
                                                                            Colors.transparent,
                                                                        highlightColor:
                                                                            Colors.transparent,
                                                                        onTap:
                                                                            () async {
                                                                          logFirebaseEvent(
                                                                              'EDUCATION_Container_57cfzm5v_ON_TAP');
                                                                          logFirebaseEvent(
                                                                              'Container_bottom_sheet');
                                                                          unawaited(
                                                                            () async {}(),
                                                                          );
                                                                          logFirebaseEvent(
                                                                              'Container_bottom_sheet');
                                                                          showModalBottomSheet(
                                                                            isScrollControlled:
                                                                                true,
                                                                            backgroundColor:
                                                                                Colors.transparent,
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return WebViewAware(
                                                                                child: GestureDetector(
                                                                                  onTap: () {
                                                                                    FocusScope.of(context).unfocus();
                                                                                    FocusManager.instance.primaryFocus?.unfocus();
                                                                                  },
                                                                                  child: Padding(
                                                                                    padding: MediaQuery.viewInsetsOf(context),
                                                                                    child: EducationNoteDialogWidget(
                                                                                      educationId: rowEducationRecord!.reference.id,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                          ).then((value) =>
                                                                              safeSetState(() {}));
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              36.0,
                                                                          constraints:
                                                                              BoxConstraints(
                                                                            minWidth:
                                                                                109.0,
                                                                          ),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).white12,
                                                                            borderRadius:
                                                                                BorderRadius.circular(100.0),
                                                                          ),
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(99.0),
                                                                            child:
                                                                                BackdropFilter(
                                                                              filter: ImageFilter.blur(
                                                                                sigmaX: 6.0,
                                                                                sigmaY: 14.0,
                                                                              ),
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Icon(
                                                                                      FFIcons.kbook,
                                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                                      size: 24.0,
                                                                                    ),
                                                                                    Text(
                                                                                      'Блокнот',
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                            fontSize: 15.0,
                                                                                            letterSpacing: 0.0,
                                                                                            lineHeight: 1.25,
                                                                                            useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                          ),
                                                                                    ),
                                                                                  ].divide(SizedBox(width: 4.0)),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      InkWell(
                                                                        splashColor:
                                                                            Colors.transparent,
                                                                        focusColor:
                                                                            Colors.transparent,
                                                                        hoverColor:
                                                                            Colors.transparent,
                                                                        highlightColor:
                                                                            Colors.transparent,
                                                                        onTap:
                                                                            () async {
                                                                          logFirebaseEvent(
                                                                              'EDUCATION_Container_3my8zp2k_ON_TAP');
                                                                          logFirebaseEvent(
                                                                              'Container_launch_u_r_l');
                                                                          unawaited(
                                                                            () async {
                                                                              await launchURL(getRemoteConfigString('supportTg'));
                                                                            }(),
                                                                          );
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              36.0,
                                                                          constraints:
                                                                              BoxConstraints(
                                                                            minWidth:
                                                                                111.0,
                                                                          ),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).white12,
                                                                            borderRadius:
                                                                                BorderRadius.circular(100.0),
                                                                          ),
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(99.0),
                                                                            child:
                                                                                BackdropFilter(
                                                                              filter: ImageFilter.blur(
                                                                                sigmaX: 8.0,
                                                                                sigmaY: 14.0,
                                                                              ),
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Container(
                                                                                      width: 24.0,
                                                                                      height: 24.0,
                                                                                      decoration: BoxDecoration(
                                                                                        image: DecorationImage(
                                                                                          fit: BoxFit.cover,
                                                                                          image: Image.asset(
                                                                                            'assets/images/Telegram.png',
                                                                                          ).image,
                                                                                        ),
                                                                                        shape: BoxShape.circle,
                                                                                      ),
                                                                                    ),
                                                                                    Text(
                                                                                      'Новости',
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                            fontSize: 15.0,
                                                                                            letterSpacing: 0.0,
                                                                                            lineHeight: 1.25,
                                                                                            useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                          ),
                                                                                    ),
                                                                                  ].divide(SizedBox(width: 4.0)),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ]
                                                                        .divide(SizedBox(
                                                                            width:
                                                                                8.0))
                                                                        .addToStart(SizedBox(
                                                                            width:
                                                                                20.0))
                                                                        .addToEnd(SizedBox(
                                                                            width:
                                                                                20.0)),
                                                                  ),
                                                                ),
                                                              );
                                                            } else if (valueOrDefault<
                                                                bool>(
                                                              functions.dayGreatherThanToday(
                                                                  rowEducationRecord
                                                                      ?.startDate),
                                                              false,
                                                            )) {
                                                              return Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        20.0,
                                                                        0.0,
                                                                        20.0,
                                                                        0.0),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              0.0),
                                                                  child:
                                                                      BackdropFilter(
                                                                    filter:
                                                                        ImageFilter
                                                                            .blur(
                                                                      sigmaX:
                                                                          3.0,
                                                                      sigmaY:
                                                                          5.0,
                                                                    ),
                                                                    child: Text(
                                                                      'СТАРТ В ${functions.monthsText(rowEducationRecord!.startDate!)}',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context).titleMediumFamily,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            letterSpacing:
                                                                                3.0,
                                                                            lineHeight:
                                                                                1.4,
                                                                            useGoogleFonts:
                                                                                !FlutterFlowTheme.of(context).titleMediumIsCustom,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            } else {
                                                              return Container(
                                                                width: double
                                                                    .infinity,
                                                                height: 0.0,
                                                                decoration:
                                                                    BoxDecoration(),
                                                              );
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Padding(
                                                  padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                              valueOrDefault<
                                                                  double>(
                                                                () {
                                                                  if (MediaQuery.sizeOf(
                                                                              context)
                                                                          .width <
                                                                      kBreakpointSmall) {
                                                                    return 0.0;
                                                                  } else if (MediaQuery.sizeOf(
                                                                              context)
                                                                          .width <
                                                                      kBreakpointMedium) {
                                                                    return 0.0;
                                                                  } else if (MediaQuery.sizeOf(
                                                                              context)
                                                                          .width <
                                                                      kBreakpointLarge) {
                                                                    return 20.0;
                                                                  } else {
                                                                    return 20.0;
                                                                  }
                                                                }(),
                                                                0.0,
                                                              ),
                                                              0.0,
                                                              valueOrDefault<
                                                                  double>(
                                                                () {
                                                                  if (MediaQuery.sizeOf(
                                                                              context)
                                                                          .width <
                                                                      kBreakpointSmall) {
                                                                    return 0.0;
                                                                  } else if (MediaQuery.sizeOf(
                                                                              context)
                                                                          .width <
                                                                      kBreakpointMedium) {
                                                                    return 0.0;
                                                                  } else if (MediaQuery.sizeOf(
                                                                              context)
                                                                          .width <
                                                                      kBreakpointLarge) {
                                                                    return 20.0;
                                                                  } else {
                                                                    return 20.0;
                                                                  }
                                                                }(),
                                                                0.0,
                                                              ),
                                                              0.0),
                                                  child: Container(
                                                    constraints: BoxConstraints(
                                                      maxWidth: 800.0,
                                                    ),
                                                    decoration: BoxDecoration(),
                                                    child: Builder(
                                                      builder: (context) {
                                                        if (!valueOrDefault<
                                                            bool>(
                                                          functions.dateGreatherThanToday(
                                                              currentUserDocument
                                                                  ?.educationSubscriptionExpDate),
                                                          false,
                                                        )) {
                                                          return Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              if (rowEducationRecord
                                                                          ?.description !=
                                                                      null &&
                                                                  rowEducationRecord
                                                                          ?.description !=
                                                                      '')
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          20.0,
                                                                          0.0,
                                                                          20.0,
                                                                          16.0),
                                                                  child: Text(
                                                                    rowEducationRecord!
                                                                        .description,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context).titleMediumFamily,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryText,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          lineHeight:
                                                                              1.25,
                                                                          useGoogleFonts:
                                                                              !FlutterFlowTheme.of(context).titleMediumIsCustom,
                                                                        ),
                                                                  ),
                                                                ),
                                                              if (() {
                                                                    if (isiOS) {
                                                                      return !valueOrDefault<
                                                                          bool>(
                                                                        functions.checkVersionReview(
                                                                            FFAppState().version,
                                                                            getRemoteConfigString('appleReviewVersion')),
                                                                        false,
                                                                      );
                                                                    } else if (isAndroid) {
                                                                      return !valueOrDefault<
                                                                          bool>(
                                                                        functions.checkVersionReview(
                                                                            FFAppState().version,
                                                                            getRemoteConfigString('googleReviewVersion')),
                                                                        false,
                                                                      );
                                                                    } else {
                                                                      return true;
                                                                    }
                                                                  }() &&
                                                                  !valueOrDefault<
                                                                      bool>(
                                                                    functions.dateGreatherThanToday(
                                                                        currentUserDocument
                                                                            ?.educationSubscriptionExpDate),
                                                                    false,
                                                                  ))
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          1.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            20.0,
                                                                            0.0,
                                                                            20.0,
                                                                            0.0),
                                                                    child:
                                                                        FFButtonWidget(
                                                                      onPressed:
                                                                          () async {
                                                                        logFirebaseEvent(
                                                                            'EDUCATION_PAGE_PAGE___BTN_ON_TAP');
                                                                        logFirebaseEvent(
                                                                            'Button_haptic_feedback');
                                                                        HapticFeedback
                                                                            .mediumImpact();
                                                                        logFirebaseEvent(
                                                                            'Button_launch_u_r_l');
                                                                        unawaited(
                                                                          () async {
                                                                            await launchURL(rowEducationRecord!.preSaleURL);
                                                                          }(),
                                                                        );
                                                                      },
                                                                      text:
                                                                          'ЗАПОЛНИТЬ ПРЕДЗАПИСЬ',
                                                                      options:
                                                                          FFButtonOptions(
                                                                        width: double
                                                                            .infinity,
                                                                        height:
                                                                            56.0,
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            16.0,
                                                                            0.0,
                                                                            16.0,
                                                                            0.0),
                                                                        iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                        textStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              fontSize: 17.0,
                                                                              letterSpacing: 0.0,
                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).titleSmallIsCustom,
                                                                            ),
                                                                        elevation:
                                                                            0.0,
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Colors.transparent,
                                                                          width:
                                                                              1.0,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(56.0),
                                                                      ),
                                                                      showLoadingIndicator:
                                                                          false,
                                                                    ),
                                                                  ),
                                                                ),
                                                              if (rowEducationRecord
                                                                          ?.video !=
                                                                      null &&
                                                                  rowEducationRecord
                                                                          ?.video !=
                                                                      '')
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          -1.0,
                                                                          0.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            20.0,
                                                                            24.0,
                                                                            20.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      'ВИДЕО О КУРСЕ',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context).titleMediumFamily,
                                                                            fontSize:
                                                                                17.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            lineHeight:
                                                                                1.0,
                                                                            useGoogleFonts:
                                                                                !FlutterFlowTheme.of(context).titleMediumIsCustom,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              if (rowEducationRecord
                                                                          ?.video !=
                                                                      null &&
                                                                  rowEducationRecord
                                                                          ?.video !=
                                                                      '')
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          20.0,
                                                                          12.0,
                                                                          20.0,
                                                                          0.0),
                                                                  child:
                                                                      InkWell(
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor:
                                                                        Colors
                                                                            .transparent,
                                                                    hoverColor:
                                                                        Colors
                                                                            .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onTap:
                                                                        () async {
                                                                      logFirebaseEvent(
                                                                          'EDUCATION_Container_rhka0lx7_ON_TAP');
                                                                      logFirebaseEvent(
                                                                          'Container_haptic_feedback');
                                                                      HapticFeedback
                                                                          .lightImpact();
                                                                      logFirebaseEvent(
                                                                          'Container_navigate_to');

                                                                      context
                                                                          .pushNamed(
                                                                        VideoPlayerWidget
                                                                            .routeName,
                                                                        queryParameters:
                                                                            {
                                                                          'urltoPath':
                                                                              serializeParam(
                                                                            functions.urlToVideoPath(rowEducationRecord!.video),
                                                                            ParamType.String,
                                                                          ),
                                                                        }.withoutNulls,
                                                                      );
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      height:
                                                                          212.0,
                                                                      constraints:
                                                                          BoxConstraints(
                                                                        maxWidth:
                                                                            600.0,
                                                                      ),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(14.0),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).tertiary,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Stack(
                                                                        children: [
                                                                          ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(14.0),
                                                                            child:
                                                                                Image.network(
                                                                              getCORSProxyUrl(
                                                                                valueOrDefault<String>(
                                                                                  rowEducationRecord?.videoImage,
                                                                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/woman-103qa6/assets/ufnzpqto096m/AppStoreWoman.jpg',
                                                                                ),
                                                                              ),
                                                                              width: double.infinity,
                                                                              height: double.infinity,
                                                                              fit: BoxFit.cover,
                                                                              errorBuilder: (context, error, stackTrace) => Image.asset(
                                                                                'assets/images/error_image.jpg',
                                                                                width: double.infinity,
                                                                                height: double.infinity,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 72.0,
                                                                              height: 72.0,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).primary,
                                                                                shape: BoxShape.circle,
                                                                              ),
                                                                              child: Icon(
                                                                                FFIcons.kplay,
                                                                                color: FlutterFlowTheme.of(context).info,
                                                                                size: 40.0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              if ((rowEducationRecord
                                                                              ?.information !=
                                                                          null &&
                                                                      rowEducationRecord
                                                                              ?.information !=
                                                                          '') &&
                                                                  responsiveVisibility(
                                                                    context:
                                                                        context,
                                                                    tabletLandscape:
                                                                        false,
                                                                    desktop:
                                                                        false,
                                                                  ))
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          16.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            56.0),
                                                                    child:
                                                                        BackdropFilter(
                                                                      filter: ImageFilter
                                                                          .blur(
                                                                        sigmaX:
                                                                            12.0,
                                                                        sigmaY:
                                                                            12.0,
                                                                      ),
                                                                      child:
                                                                          Visibility(
                                                                        visible:
                                                                            responsiveVisibility(
                                                                          context:
                                                                              context,
                                                                          tabletLandscape:
                                                                              false,
                                                                          desktop:
                                                                              false,
                                                                        ),
                                                                        child:
                                                                            FFButtonWidget(
                                                                          onPressed:
                                                                              () async {
                                                                            logFirebaseEvent('EDUCATION_PAGE_PAGE___BTN_ON_TAP');
                                                                            logFirebaseEvent('Button_haptic_feedback');
                                                                            HapticFeedback.mediumImpact();
                                                                            logFirebaseEvent('Button_launch_u_r_l');
                                                                            unawaited(
                                                                              () async {
                                                                                await launchURL(rowEducationRecord!.reviewURL);
                                                                              }(),
                                                                            );
                                                                          },
                                                                          text:
                                                                              'ЧИТАТЬ ОТЗЫВЫ',
                                                                          options:
                                                                              FFButtonOptions(
                                                                            height:
                                                                                48.0,
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                16.0,
                                                                                0.0,
                                                                                16.0,
                                                                                0.0),
                                                                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).white12,
                                                                            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                  fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                  letterSpacing: 0.0,
                                                                                  lineHeight: 1.2,
                                                                                  useGoogleFonts: !FlutterFlowTheme.of(context).titleSmallIsCustom,
                                                                                ),
                                                                            elevation:
                                                                                0.0,
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: FlutterFlowTheme.of(context).white12,
                                                                              width: 1.0,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(56.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              FutureBuilder<
                                                                  int>(
                                                                future:
                                                                    queryEducationReviewsRecordCount(
                                                                  queryBuilder:
                                                                      (educationReviewsRecord) =>
                                                                          educationReviewsRecord
                                                                              .where(
                                                                    'educationId',
                                                                    isEqualTo:
                                                                        rowEducationRecord
                                                                            ?.reference
                                                                            .id,
                                                                  ),
                                                                ),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  // Customize what your widget looks like when it's loading.
                                                                  if (!snapshot
                                                                      .hasData) {
                                                                    return Center(
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            275.0,
                                                                        height:
                                                                            275.0,
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          valueColor:
                                                                              AlwaysStoppedAnimation<Color>(
                                                                            Colors.transparent,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                  int containerCount =
                                                                      snapshot
                                                                          .data!;

                                                                  return Container(
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child:
                                                                        Visibility(
                                                                      visible:
                                                                          containerCount >
                                                                              0,
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(-1.0, 0.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 20.0, 16.0),
                                                                              child: Text(
                                                                                'ОТЗЫВЫ',
                                                                                style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                      fontFamily: FlutterFlowTheme.of(context).titleMediumFamily,
                                                                                      fontSize: 17.0,
                                                                                      letterSpacing: 0.0,
                                                                                      lineHeight: 1.0,
                                                                                      useGoogleFonts: !FlutterFlowTheme.of(context).titleMediumIsCustom,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          FutureBuilder<
                                                                              List<EducationReviewsRecord>>(
                                                                            future:
                                                                                queryEducationReviewsRecordOnce(
                                                                              queryBuilder: (educationReviewsRecord) => educationReviewsRecord
                                                                                  .where(
                                                                                    'educationId',
                                                                                    isEqualTo: rowEducationRecord?.reference.id,
                                                                                  )
                                                                                  .orderBy('created_at', descending: true),
                                                                            ),
                                                                            builder:
                                                                                (context, snapshot) {
                                                                              // Customize what your widget looks like when it's loading.
                                                                              if (!snapshot.hasData) {
                                                                                return Center(
                                                                                  child: SizedBox(
                                                                                    width: 215.0,
                                                                                    height: 215.0,
                                                                                    child: CircularProgressIndicator(
                                                                                      valueColor: AlwaysStoppedAnimation<Color>(
                                                                                        Colors.transparent,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              }
                                                                              List<EducationReviewsRecord> containerEducationReviewsRecordList = snapshot.data!;

                                                                              return Container(
                                                                                constraints: BoxConstraints(
                                                                                  minHeight: 210.0,
                                                                                  maxHeight: 215.0,
                                                                                ),
                                                                                decoration: BoxDecoration(),
                                                                                child: Stack(
                                                                                  children: [
                                                                                    Align(
                                                                                      alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 1.0, 0.0),
                                                                                        child: Builder(
                                                                                          builder: (context) {
                                                                                            final reviews = containerEducationReviewsRecordList.sortedList(keyOf: (e) => e.index, desc: false).toList();
                                                                                            if (reviews.isEmpty) {
                                                                                              return EmptyListWidget();
                                                                                            }

                                                                                            return SingleChildScrollView(
                                                                                              scrollDirection: Axis.horizontal,
                                                                                              controller: _model.reviewsListViewScrollController,
                                                                                              child: Row(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                children: List.generate(reviews.length, (reviewsIndex) {
                                                                                                  final reviewsItem = reviews[reviewsIndex];
                                                                                                  return ReviewWidget(
                                                                                                    key: Key('Key7ig_${reviewsIndex}_of_${reviews.length}'),
                                                                                                    reviewDoc: reviewsItem,
                                                                                                    educationTitle: rowEducationRecord!.subtitle,
                                                                                                  );
                                                                                                }).divide(SizedBox(width: 12.0)).addToStart(SizedBox(width: 20.0)).addToEnd(SizedBox(width: 20.0)),
                                                                                              ),
                                                                                            );
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    if (responsiveVisibility(
                                                                                      context: context,
                                                                                      phone: false,
                                                                                      tablet: false,
                                                                                    ))
                                                                                      Align(
                                                                                        alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                                                                          child: ClipOval(
                                                                                            child: BackdropFilter(
                                                                                              filter: ImageFilter.blur(
                                                                                                sigmaX: 12.0,
                                                                                                sigmaY: 12.0,
                                                                                              ),
                                                                                              child: Visibility(
                                                                                                visible: isWeb &&
                                                                                                    responsiveVisibility(
                                                                                                      context: context,
                                                                                                      phone: false,
                                                                                                      tablet: false,
                                                                                                    ),
                                                                                                child: FlutterFlowIconButton(
                                                                                                  borderColor: FlutterFlowTheme.of(context).white12,
                                                                                                  borderRadius: 99.0,
                                                                                                  borderWidth: 1.0,
                                                                                                  buttonSize: 56.0,
                                                                                                  fillColor: FlutterFlowTheme.of(context).white12,
                                                                                                  icon: Icon(
                                                                                                    FFIcons.kleftIcon3,
                                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                                    size: 28.0,
                                                                                                  ),
                                                                                                  onPressed: () async {
                                                                                                    logFirebaseEvent('EDUCATION_PAGE_PAGE_leftIcon3_ICN_ON_TAP');
                                                                                                    logFirebaseEvent('IconButton_scroll_to');
                                                                                                    await _model.reviewsListViewScrollController?.animateTo(
                                                                                                      0,
                                                                                                      duration: Duration(milliseconds: 100),
                                                                                                      curve: Curves.ease,
                                                                                                    );
                                                                                                  },
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    Align(
                                                                                      alignment: AlignmentDirectional(1.0, 0.0),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                                                                                        child: ClipOval(
                                                                                          child: BackdropFilter(
                                                                                            filter: ImageFilter.blur(
                                                                                              sigmaX: 12.0,
                                                                                              sigmaY: 12.0,
                                                                                            ),
                                                                                            child: Visibility(
                                                                                              visible: isWeb &&
                                                                                                  responsiveVisibility(
                                                                                                    context: context,
                                                                                                    phone: false,
                                                                                                    tablet: false,
                                                                                                  ),
                                                                                              child: FlutterFlowIconButton(
                                                                                                borderColor: FlutterFlowTheme.of(context).white12,
                                                                                                borderRadius: 99.0,
                                                                                                borderWidth: 1.0,
                                                                                                buttonSize: 56.0,
                                                                                                fillColor: FlutterFlowTheme.of(context).white12,
                                                                                                icon: Icon(
                                                                                                  FFIcons.krightIcon12,
                                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                                  size: 28.0,
                                                                                                ),
                                                                                                onPressed: () async {
                                                                                                  logFirebaseEvent('EDUCATION_rightIcon12_ICN_ON_TAP');
                                                                                                  logFirebaseEvent('IconButton_scroll_to');
                                                                                                  await _model.reviewsListViewScrollController?.animateTo(
                                                                                                    _model.reviewsListViewScrollController!.position.maxScrollExtent,
                                                                                                    duration: Duration(milliseconds: 100),
                                                                                                    curve: Curves.ease,
                                                                                                  );
                                                                                                },
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                              if (isWeb &&
                                                                  responsiveVisibility(
                                                                    context:
                                                                        context,
                                                                    phone:
                                                                        false,
                                                                    tablet:
                                                                        false,
                                                                  ))
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          24.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    getRemoteConfigString(
                                                                        'license_info'),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context).labelMediumFamily,
                                                                          fontSize:
                                                                              13.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          lineHeight:
                                                                              1.4,
                                                                          useGoogleFonts:
                                                                              !FlutterFlowTheme.of(context).labelMediumIsCustom,
                                                                        ),
                                                                  ),
                                                                ),
                                                            ],
                                                          );
                                                        } else {
                                                          return Builder(
                                                            builder: (context) {
                                                              if (valueOrDefault<
                                                                  bool>(
                                                                functions.dayGreatherThanToday(
                                                                    rowEducationRecord
                                                                        ?.startDate),
                                                                false,
                                                              )) {
                                                                return Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    if (rowEducationRecord?.description !=
                                                                            null &&
                                                                        rowEducationRecord?.description !=
                                                                            '')
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            20.0,
                                                                            0.0,
                                                                            20.0,
                                                                            12.0),
                                                                        child:
                                                                            Text(
                                                                          rowEducationRecord!
                                                                              .description,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .titleMedium
                                                                              .override(
                                                                                fontFamily: FlutterFlowTheme.of(context).titleMediumFamily,
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                letterSpacing: 0.0,
                                                                                lineHeight: 1.25,
                                                                                useGoogleFonts: !FlutterFlowTheme.of(context).titleMediumIsCustom,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          16.0,
                                                                          0.0),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(56.0),
                                                                        child:
                                                                            BackdropFilter(
                                                                          filter:
                                                                              ImageFilter.blur(
                                                                            sigmaX:
                                                                                12.0,
                                                                            sigmaY:
                                                                                12.0,
                                                                          ),
                                                                          child:
                                                                              FFButtonWidget(
                                                                            onPressed:
                                                                                () {
                                                                              print('Button pressed ...');
                                                                            },
                                                                            text:
                                                                                valueOrDefault<String>(
                                                                              'КУРС ОТКРОЕТСЯ ${dateTimeFormat(
                                                                                "d MMMM",
                                                                                rowEducationRecord?.startDate,
                                                                                locale: FFLocalizations.of(context).languageCode,
                                                                              )}',
                                                                              'КУРС ОТКРОЕТСЯ ',
                                                                            ).toUpperCase(),
                                                                            icon:
                                                                                Icon(
                                                                              FFIcons.klock2,
                                                                              size: 24.0,
                                                                            ),
                                                                            options:
                                                                                FFButtonOptions(
                                                                              width: double.infinity,
                                                                              height: 56.0,
                                                                              padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                              iconColor: FlutterFlowTheme.of(context).primary50,
                                                                              color: FlutterFlowTheme.of(context).white12,
                                                                              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                    fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                                                                    color: FlutterFlowTheme.of(context).primary50,
                                                                                    fontSize: 17.0,
                                                                                    letterSpacing: 0.0,
                                                                                    useGoogleFonts: !FlutterFlowTheme.of(context).titleSmallIsCustom,
                                                                                  ),
                                                                              elevation: 0.0,
                                                                              borderSide: BorderSide(
                                                                                color: FlutterFlowTheme.of(context).white12,
                                                                                width: 1.0,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(56.0),
                                                                            ),
                                                                            showLoadingIndicator:
                                                                                false,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                );
                                                              } else {
                                                                return Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          valueOrDefault<
                                                                              double>(
                                                                            () {
                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                return 20.0;
                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                return 20.0;
                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                return 0.0;
                                                                              } else {
                                                                                return 0.0;
                                                                              }
                                                                            }(),
                                                                            0.0,
                                                                          ),
                                                                          20.0,
                                                                          valueOrDefault<
                                                                              double>(
                                                                            () {
                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                return 20.0;
                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                return 20.0;
                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                return 0.0;
                                                                              } else {
                                                                                return 0.0;
                                                                              }
                                                                            }(),
                                                                            0.0,
                                                                          ),
                                                                          0.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              10.0),
                                                                          child:
                                                                              Text(
                                                                            'ОБУЧЕНИЕ',
                                                                            style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                  fontFamily: FlutterFlowTheme.of(context).titleMediumFamily,
                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                  letterSpacing: 0.0,
                                                                                  lineHeight: 1.25,
                                                                                  useGoogleFonts: !FlutterFlowTheme.of(context).titleMediumIsCustom,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      if (rowEducationRecord
                                                                              ?.reference !=
                                                                          null)
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              -1.0,
                                                                              0.0),
                                                                          child:
                                                                              StreamBuilder<List<EducationModulesRecord>>(
                                                                            stream:
                                                                                queryEducationModulesRecord(
                                                                              queryBuilder: (educationModulesRecord) => educationModulesRecord
                                                                                  .where(
                                                                                    'educationId',
                                                                                    isEqualTo: rowEducationRecord?.reference.id,
                                                                                  )
                                                                                  .orderBy('number'),
                                                                            ),
                                                                            builder:
                                                                                (context, snapshot) {
                                                                              // Customize what your widget looks like when it's loading.
                                                                              if (!snapshot.hasData) {
                                                                                return Center(
                                                                                  child: SizedBox(
                                                                                    width: 1.0,
                                                                                    height: 1.0,
                                                                                    child: CircularProgressIndicator(
                                                                                      valueColor: AlwaysStoppedAnimation<Color>(
                                                                                        Colors.transparent,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              }
                                                                              List<EducationModulesRecord> wrapEducationModulesRecordList = snapshot.data!;
                                                                              if (wrapEducationModulesRecordList.isEmpty) {
                                                                                return EmptyListWidget();
                                                                              }

                                                                              return Wrap(
                                                                                spacing: 20.0,
                                                                                runSpacing: 12.0,
                                                                                alignment: WrapAlignment.start,
                                                                                crossAxisAlignment: WrapCrossAlignment.start,
                                                                                direction: Axis.horizontal,
                                                                                runAlignment: WrapAlignment.start,
                                                                                verticalDirection: VerticalDirection.down,
                                                                                clipBehavior: Clip.none,
                                                                                children: List.generate(wrapEducationModulesRecordList.length, (wrapIndex) {
                                                                                  final wrapEducationModulesRecord = wrapEducationModulesRecordList[wrapIndex];
                                                                                  return InkWell(
                                                                                    splashColor: Colors.transparent,
                                                                                    focusColor: Colors.transparent,
                                                                                    hoverColor: Colors.transparent,
                                                                                    highlightColor: Colors.transparent,
                                                                                    onTap: () async {
                                                                                      logFirebaseEvent('EDUCATION_Container_sz2roaex_ON_TAP');
                                                                                      if (!valueOrDefault<bool>(
                                                                                        functions.dateGreatherThanToday(wrapEducationModulesRecord.startDate),
                                                                                        false,
                                                                                      )) {
                                                                                        logFirebaseEvent('educationModuleComp_navigate_to');

                                                                                        context.pushNamed(
                                                                                          EducationModulePageWidget.routeName,
                                                                                          queryParameters: {
                                                                                            'module': serializeParam(
                                                                                              wrapEducationModulesRecord,
                                                                                              ParamType.Document,
                                                                                            ),
                                                                                          }.withoutNulls,
                                                                                          extra: <String, dynamic>{
                                                                                            'module': wrapEducationModulesRecord,
                                                                                            '__transition_info__': TransitionInfo(
                                                                                              hasTransition: true,
                                                                                              transitionType: PageTransitionType.fade,
                                                                                              duration: Duration(milliseconds: 0),
                                                                                            ),
                                                                                          },
                                                                                        );
                                                                                      } else {
                                                                                        return;
                                                                                      }
                                                                                    },
                                                                                    child: EducationModuleCompWidget(
                                                                                      key: Key('Keysz2_${wrapIndex}_of_${wrapEducationModulesRecordList.length}'),
                                                                                      module: wrapEducationModulesRecord,
                                                                                    ),
                                                                                  );
                                                                                }),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ),
                                                                    ],
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ),
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
                                              120.0,
                                            ))),
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
                                        color: FlutterFlowTheme.of(context)
                                            .tertiary,
                                      ),
                                      if (valueOrDefault<bool>(
                                        functions.dateGreatherThanToday(
                                            currentUserDocument
                                                ?.educationSubscriptionExpDate),
                                        false,
                                      ))
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: AuthUserStreamWidget(
                                            builder: (context) => Container(
                                              width: 320.0,
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  1.0,
                                              constraints: BoxConstraints(
                                                maxWidth: 260.0,
                                              ),
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: Image.asset(
                                                    'assets/images/Background.webp',
                                                  ).image,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        20.0, 0.0, 20.0, 0.0),
                                                child: SingleChildScrollView(
                                                  controller:
                                                      _model.columnController2,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        child: BackdropFilter(
                                                          filter:
                                                              ImageFilter.blur(
                                                            sigmaX: 12.0,
                                                            sigmaY: 12.0,
                                                          ),
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .white12,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          20.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    'ВАШ ДОСТУП',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context).titleSmallFamily,
                                                                          fontSize:
                                                                              17.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          useGoogleFonts:
                                                                              !FlutterFlowTheme.of(context).titleSmallIsCustom,
                                                                        ),
                                                                  ),
                                                                  Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children:
                                                                            [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                12.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 4.0,
                                                                              height: 4.0,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                shape: BoxShape.circle,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              'Доступ к проекту ${valueOrDefault<String>(
                                                                                rowEducationRecord?.subtitle,
                                                                                'WOMAN',
                                                                              )} доступен до ${valueOrDefault<String>(
                                                                                dateTimeFormat(
                                                                                  "dd.MM.yyyy",
                                                                                  currentUserDocument?.educationSubscriptionExpDate,
                                                                                  locale: FFLocalizations.of(context).languageCode,
                                                                                ),
                                                                                'undefined',
                                                                              )} включительно',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                    fontSize: 15.0,
                                                                                    letterSpacing: 0.0,
                                                                                    lineHeight: 1.4,
                                                                                    useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ].divide(SizedBox(width: 8.0)),
                                                                      ),
                                                                      Builder(
                                                                        builder:
                                                                            (context) {
                                                                          final addInfo =
                                                                              rowEducationRecord?.additionalInformation?.toList() ?? [];

                                                                          return Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children:
                                                                                List.generate(addInfo.length, (addInfoIndex) {
                                                                              final addInfoItem = addInfo[addInfoIndex];
                                                                              return Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                                                                                    child: Container(
                                                                                      width: 4.0,
                                                                                      height: 4.0,
                                                                                      decoration: BoxDecoration(
                                                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                                                        shape: BoxShape.circle,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      valueOrDefault<String>(
                                                                                        addInfoItem,
                                                                                        '-',
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                            fontSize: 15.0,
                                                                                            letterSpacing: 0.0,
                                                                                            lineHeight: 1.4,
                                                                                            useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                ].divide(SizedBox(width: 8.0)),
                                                                              );
                                                                            }).divide(SizedBox(height: 8.0)),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ]
                                                                        .divide(SizedBox(
                                                                            height:
                                                                                8.0))
                                                                        .addToStart(SizedBox(
                                                                            height:
                                                                                12.0)),
                                                                  ),
                                                                ].divide(SizedBox(
                                                                    height:
                                                                        12.0)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        child: BackdropFilter(
                                                          filter:
                                                              ImageFilter.blur(
                                                            sigmaX: 12.0,
                                                            sigmaY: 12.0,
                                                          ),
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .white12,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          20.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    'ПОЛЕЗНЫЕ ССЫЛКИ',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context).titleSmallFamily,
                                                                          fontSize:
                                                                              17.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          useGoogleFonts:
                                                                              !FlutterFlowTheme.of(context).titleSmallIsCustom,
                                                                        ),
                                                                  ),
                                                                  Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      InkWell(
                                                                        splashColor:
                                                                            Colors.transparent,
                                                                        focusColor:
                                                                            Colors.transparent,
                                                                        hoverColor:
                                                                            Colors.transparent,
                                                                        highlightColor:
                                                                            Colors.transparent,
                                                                        onTap:
                                                                            () async {
                                                                          logFirebaseEvent(
                                                                              'EDUCATION_PAGE_PAGE_Row_7473qua9_ON_TAP');
                                                                          logFirebaseEvent(
                                                                              'Row_bottom_sheet');
                                                                          showModalBottomSheet(
                                                                            isScrollControlled:
                                                                                true,
                                                                            backgroundColor:
                                                                                Colors.transparent,
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return WebViewAware(
                                                                                child: GestureDetector(
                                                                                  onTap: () {
                                                                                    FocusScope.of(context).unfocus();
                                                                                    FocusManager.instance.primaryFocus?.unfocus();
                                                                                  },
                                                                                  child: Padding(
                                                                                    padding: MediaQuery.viewInsetsOf(context),
                                                                                    child: EducationNoteDialogWidget(
                                                                                      educationId: rowEducationRecord!.reference.id,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                          ).then((value) =>
                                                                              safeSetState(() {}));
                                                                        },
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Icon(
                                                                              FFIcons.kbook,
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              size: 24.0,
                                                                            ),
                                                                            Expanded(
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                                                                child: Text(
                                                                                  'Блокнот',
                                                                                  style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                        fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                                                                        fontSize: 15.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w500,
                                                                                        lineHeight: 1.4,
                                                                                        useGoogleFonts: !FlutterFlowTheme.of(context).titleSmallIsCustom,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Icon(
                                                                              FFIcons.kright3,
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              size: 24.0,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      InkWell(
                                                                        splashColor:
                                                                            Colors.transparent,
                                                                        focusColor:
                                                                            Colors.transparent,
                                                                        hoverColor:
                                                                            Colors.transparent,
                                                                        highlightColor:
                                                                            Colors.transparent,
                                                                        onTap:
                                                                            () async {
                                                                          logFirebaseEvent(
                                                                              'EDUCATION_PAGE_PAGE_Row_mh5uw4fr_ON_TAP');
                                                                          logFirebaseEvent(
                                                                              'Row_launch_u_r_l');
                                                                          await launchURL(
                                                                              getRemoteConfigString('supportTg'));
                                                                        },
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Icon(
                                                                              FFIcons.kheadphonesOff,
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              size: 24.0,
                                                                            ),
                                                                            Expanded(
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                                                                child: Text(
                                                                                  'Служба поддержки',
                                                                                  style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                        fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                                                                        fontSize: 15.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w500,
                                                                                        lineHeight: 1.4,
                                                                                        useGoogleFonts: !FlutterFlowTheme.of(context).titleSmallIsCustom,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Icon(
                                                                              FFIcons.kright3,
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              size: 24.0,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      InkWell(
                                                                        splashColor:
                                                                            Colors.transparent,
                                                                        focusColor:
                                                                            Colors.transparent,
                                                                        hoverColor:
                                                                            Colors.transparent,
                                                                        highlightColor:
                                                                            Colors.transparent,
                                                                        onTap:
                                                                            () async {
                                                                          logFirebaseEvent(
                                                                              'EDUCATION_PAGE_PAGE_Row_j1qe2kp5_ON_TAP');
                                                                          logFirebaseEvent(
                                                                              'Row_launch_u_r_l');
                                                                          unawaited(
                                                                            () async {
                                                                              await launchURL(rowEducationRecord!.newsChannelUrl);
                                                                            }(),
                                                                          );
                                                                        },
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Container(
                                                                              width: 24.0,
                                                                              height: 24.0,
                                                                              clipBehavior: Clip.antiAlias,
                                                                              decoration: BoxDecoration(
                                                                                shape: BoxShape.circle,
                                                                              ),
                                                                              child: Image.asset(
                                                                                'assets/images/Telegram.png',
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                                                                child: Text(
                                                                                  'Новостной канал',
                                                                                  style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                        fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                                                                        fontSize: 15.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w500,
                                                                                        lineHeight: 1.4,
                                                                                        useGoogleFonts: !FlutterFlowTheme.of(context).titleSmallIsCustom,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Icon(
                                                                              FFIcons.kright3,
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              size: 24.0,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      InkWell(
                                                                        splashColor:
                                                                            Colors.transparent,
                                                                        focusColor:
                                                                            Colors.transparent,
                                                                        hoverColor:
                                                                            Colors.transparent,
                                                                        highlightColor:
                                                                            Colors.transparent,
                                                                        onTap:
                                                                            () async {
                                                                          logFirebaseEvent(
                                                                              'EDUCATION_PAGE_PAGE_Row_wc4k7hdc_ON_TAP');
                                                                          logFirebaseEvent(
                                                                              'Row_launch_u_r_l');
                                                                          unawaited(
                                                                            () async {
                                                                              await launchURL(rowEducationRecord!.chatUrl);
                                                                            }(),
                                                                          );
                                                                        },
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Container(
                                                                              width: 24.0,
                                                                              height: 24.0,
                                                                              clipBehavior: Clip.antiAlias,
                                                                              decoration: BoxDecoration(
                                                                                shape: BoxShape.circle,
                                                                              ),
                                                                              child: Image.asset(
                                                                                'assets/images/Telegram.png',
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                                                                child: Text(
                                                                                  'Общий чат с участницами',
                                                                                  style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                        fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                                                                        fontSize: 15.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w500,
                                                                                        lineHeight: 1.4,
                                                                                        useGoogleFonts: !FlutterFlowTheme.of(context).titleSmallIsCustom,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Icon(
                                                                              FFIcons.kright3,
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              size: 24.0,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      InkWell(
                                                                        splashColor:
                                                                            Colors.transparent,
                                                                        focusColor:
                                                                            Colors.transparent,
                                                                        hoverColor:
                                                                            Colors.transparent,
                                                                        highlightColor:
                                                                            Colors.transparent,
                                                                        onTap:
                                                                            () async {
                                                                          logFirebaseEvent(
                                                                              'EDUCATION_PAGE_PAGE_Row_egbduxfc_ON_TAP');
                                                                          logFirebaseEvent(
                                                                              'Row_launch_u_r_l');
                                                                          unawaited(
                                                                            () async {
                                                                              await launchURL(rowEducationRecord!.vipChannelUrl);
                                                                            }(),
                                                                          );
                                                                        },
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Container(
                                                                              width: 24.0,
                                                                              height: 24.0,
                                                                              clipBehavior: Clip.antiAlias,
                                                                              decoration: BoxDecoration(
                                                                                shape: BoxShape.circle,
                                                                              ),
                                                                              child: Image.asset(
                                                                                'assets/images/Telegram.png',
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                                                                child: Text(
                                                                                  'VIP-группа',
                                                                                  style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                        fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                                                                        fontSize: 15.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w500,
                                                                                        lineHeight: 1.4,
                                                                                        useGoogleFonts: !FlutterFlowTheme.of(context).titleSmallIsCustom,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Icon(
                                                                              FFIcons.kright3,
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              size: 24.0,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ]
                                                                        .divide(SizedBox(
                                                                            height:
                                                                                16.0))
                                                                        .addToStart(SizedBox(
                                                                            height:
                                                                                12.0)),
                                                                  ),
                                                                ].divide(SizedBox(
                                                                    height:
                                                                        12.0)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        child: BackdropFilter(
                                                          filter:
                                                              ImageFilter.blur(
                                                            sigmaX: 12.0,
                                                            sigmaY: 12.0,
                                                          ),
                                                          child: FutureBuilder<
                                                              List<
                                                                  EducationScheduleRecord>>(
                                                            future:
                                                                queryEducationScheduleRecordOnce(
                                                              queryBuilder: (educationScheduleRecord) =>
                                                                  educationScheduleRecord
                                                                      .where(
                                                                        'educationId',
                                                                        isEqualTo: rowEducationRecord?.reference.id !=
                                                                                ''
                                                                            ? rowEducationRecord?.reference.id
                                                                            : null,
                                                                      )
                                                                      .where(
                                                                        'event_date',
                                                                        isGreaterThanOrEqualTo:
                                                                            getCurrentTimestamp,
                                                                      )
                                                                      .orderBy(
                                                                          'event_date'),
                                                            ),
                                                            builder: (context,
                                                                snapshot) {
                                                              // Customize what your widget looks like when it's loading.
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return Center(
                                                                  child:
                                                                      SizedBox(
                                                                    width: 40.0,
                                                                    height:
                                                                        40.0,
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      valueColor:
                                                                          AlwaysStoppedAnimation<
                                                                              Color>(
                                                                        Colors
                                                                            .transparent,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                              List<EducationScheduleRecord>
                                                                  containerEducationScheduleRecordList =
                                                                  snapshot
                                                                      .data!;

                                                              return Container(
                                                                width: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .white12,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.0),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              20.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        'Расписание',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                                                              fontSize: 17.0,
                                                                              letterSpacing: 0.0,
                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).titleSmallIsCustom,
                                                                            ),
                                                                      ),
                                                                      Builder(
                                                                        builder:
                                                                            (context) {
                                                                          final events =
                                                                              containerEducationScheduleRecordList.toList();

                                                                          return Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children:
                                                                                List.generate(events.length, (eventsIndex) {
                                                                              final eventsItem = events[eventsIndex];
                                                                              return Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                                        children: [
                                                                                          Icon(
                                                                                            Icons.access_time,
                                                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                                                            size: 24.0,
                                                                                          ),
                                                                                          Expanded(
                                                                                            child: AutoSizeText(
                                                                                              valueOrDefault<String>(
                                                                                                dateTimeFormat(
                                                                                                  "dd MMMM yyyy в H:m",
                                                                                                  eventsItem.eventDate,
                                                                                                  locale: FFLocalizations.of(context).languageCode,
                                                                                                ),
                                                                                                'undefined',
                                                                                              ),
                                                                                              maxLines: 1,
                                                                                              style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                    fontFamily: FlutterFlowTheme.of(context).bodyLargeFamily,
                                                                                                    fontSize: 17.0,
                                                                                                    letterSpacing: 0.0,
                                                                                                    lineHeight: 1.4,
                                                                                                    useGoogleFonts: !FlutterFlowTheme.of(context).bodyLargeIsCustom,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                        ].divide(SizedBox(width: 4.0)),
                                                                                      ),
                                                                                      Text(
                                                                                        valueOrDefault<String>(
                                                                                          eventsItem.eventTitle,
                                                                                          '-',
                                                                                        ),
                                                                                        maxLines: 2,
                                                                                        style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                              fontFamily: FlutterFlowTheme.of(context).labelLargeFamily,
                                                                                              fontSize: 15.0,
                                                                                              letterSpacing: 0.0,
                                                                                              lineHeight: 1.25,
                                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).labelLargeIsCustom,
                                                                                            ),
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                      ),
                                                                                    ].divide(SizedBox(height: 4.0)),
                                                                                  ),
                                                                                ].divide(SizedBox(height: 16.0)).addToStart(SizedBox(height: 12.0)),
                                                                              );
                                                                            }),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        height:
                                                                            12.0)),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ]
                                                        .divide(SizedBox(
                                                            height: 12.0))
                                                        .addToStart(SizedBox(
                                                            height: 20.0))
                                                        .addToEnd(SizedBox(
                                                            height: 20.0)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  wrapWithModel(
                    model: _model.navbarModel,
                    updateCallback: () => safeSetState(() {}),
                    child: NavbarWidget(
                      pageNum: 2.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
