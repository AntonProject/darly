import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/audio_day_home/audio_day_home_widget.dart';
import '/components/back_button/back_button_widget.dart';
import '/components/empty_list/empty_list_widget.dart';
import '/components/navbar/navbar_widget.dart';
import '/components/video_home_comp/video_home_comp_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/audio/rowtitle/rowtitle_widget.dart';
import '/pages/payment/premium/premium_widget.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  static String routeName = 'HomePage';
  static String routePath = '/homePage';

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'HomePage'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('HOME_PAGE_PAGE_HomePage_ON_INIT_STATE');
      logFirebaseEvent('HomePage_custom_action');
      unawaited(
        () async {
          await actions.closeKeyboard(
            context,
          );
        }(),
      );
      if (isWeb) {
        logFirebaseEvent('HomePage_navigate_to');

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
      logFirebaseEvent('HomePage_custom_action');
      unawaited(
        () async {
          await actions.setStatusBarColor();
        }(),
      );
      logFirebaseEvent('HomePage_custom_action');
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
        title: 'HomePage',
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
              child: Stack(
                alignment: AlignmentDirectional(0.0, 1.0),
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: Image.asset(
                          'assets/images/Background.webp',
                        ).image,
                      ),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: 600.0,
                        ),
                        decoration: BoxDecoration(),
                        child: Stack(
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 8.0, 0.0, 0.0),
                                    child: AuthUserStreamWidget(
                                      builder: (context) =>
                                          FutureBuilder<List<NewsRecord>>(
                                        future: FFAppState().news(
                                          uniqueQueryKey:
                                              '${currentUserUid}${valueOrDefault<String>(
                                            FFAppState()
                                                .refreshDate
                                                ?.toString(),
                                            '0',
                                          )}${valueOrDefault<String>(
                                            currentUserDocument?.lastLoginAt
                                                ?.toString(),
                                            '0',
                                          )}',
                                          requestFn: () => queryNewsRecordOnce(
                                            queryBuilder: (newsRecord) =>
                                                newsRecord
                                                    .where(
                                                      'hide',
                                                      isNotEqualTo: true,
                                                    )
                                                    .orderBy('hide')
                                                    .orderBy('index'),
                                          ),
                                        ),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 50,
                                                height: 50,
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
                                          List<NewsRecord>
                                              newsHomeNewsRecordList =
                                              snapshot.data!;

                                          return Container(
                                            width: double.infinity,
                                            height: 220.0,
                                            child: custom_widgets.WheelListHome(
                                              width: double.infinity,
                                              height: 220.0,
                                              containerWidth: 130.0,
                                              containerHeight: 116.0,
                                              borderRadius: 16.0,
                                              borderSize: 1.0,
                                              borderColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              newsList: newsHomeNewsRecordList,
                                              imageWidth: 114.0,
                                              imageHeight: 126.0,
                                              imageRadius: 12.0,
                                              titleFontSize: 15.0,
                                              titleColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              dateFontSize: 15.0,
                                              dateColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              backgroundColor:
                                                  Colors.transparent,
                                              itemSpacing: 12.0,
                                              onScrollSelected:
                                                  (selectedItem) async {},
                                              onTapCentralItem:
                                                  (selectedItem) async {
                                                logFirebaseEvent(
                                                    'HOME_PAGE_PAGE_NewsHome_CALLBACK');
                                                logFirebaseEvent(
                                                    'NewsHome_navigate_to');

                                                context.pushNamed(
                                                  NewsPageWidget.routeName,
                                                  queryParameters: {
                                                    'news': serializeParam(
                                                      selectedItem,
                                                      ParamType.Document,
                                                    ),
                                                  }.withoutNulls,
                                                  extra: <String, dynamic>{
                                                    'news': selectedItem,
                                                  },
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 32.0),
                                    child: wrapWithModel(
                                      model: _model.audioDayHomeModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: AudioDayHomeWidget(),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 0.0, 20.0, 0.0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 335.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .white12,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: Image.asset(
                                            'assets/images/Widget_-_Message_of_the_Day13.webp',
                                          ).image,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .white12,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 24.0, 16.0, 16.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              'ПОСЛАНИЕ ДНЯ',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineMediumFamily,
                                                        letterSpacing: 0.0,
                                                        lineHeight: 1.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .headlineMediumIsCustom,
                                                      ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 4.0, 0.0, 0.0),
                                                child: Text(
                                                  'Каждый день получай уникальное послание от Darly',
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                            fontSize: 15.0,
                                                            letterSpacing: 0.0,
                                                            lineHeight: 1.2,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumIsCustom,
                                                          ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height: 56.0,
                                              child:
                                                  custom_widgets.CustomSlider(
                                                width: double.infinity,
                                                height: 56.0,
                                                borderColor:
                                                    FlutterFlowTheme.of(context)
                                                        .white24,
                                                icon: Icon(
                                                  FFIcons.krightDouble,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  size: 24.0,
                                                ),
                                                text:
                                                    'Проведите, чтобы открыть',
                                                buttonColor:
                                                    FlutterFlowTheme.of(context)
                                                        .white24,
                                                textSize: 15.0,
                                                action: () async {
                                                  logFirebaseEvent(
                                                      'HOME_Container_cow825tq_CALLBACK');
                                                  logFirebaseEvent(
                                                      'CustomSlider_haptic_feedback');
                                                  HapticFeedback.lightImpact();
                                                  if ((dateTimeFormat(
                                                            "d/M/y",
                                                            currentUserDocument
                                                                ?.messageLetterDate,
                                                            locale: FFLocalizations
                                                                    .of(context)
                                                                .languageCode,
                                                          ) ==
                                                          dateTimeFormat(
                                                            "d/M/y",
                                                            getCurrentTimestamp,
                                                            locale: FFLocalizations
                                                                    .of(context)
                                                                .languageCode,
                                                          )) &&
                                                      (valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.messageLetterDayImage,
                                                                  '') !=
                                                              null &&
                                                          valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.messageLetterDayImage,
                                                                  '') !=
                                                              '') &&
                                                      (valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.messageLetterDay,
                                                                  '') !=
                                                              null &&
                                                          valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.messageLetterDay,
                                                                  '') !=
                                                              '')) {
                                                    logFirebaseEvent(
                                                        'CustomSlider_navigate_to');

                                                    context.pushNamed(
                                                      MessageLetterPageWidget
                                                          .routeName,
                                                      queryParameters: {
                                                        'message':
                                                            serializeParam(
                                                          valueOrDefault(
                                                              currentUserDocument
                                                                  ?.messageLetterDay,
                                                              ''),
                                                          ParamType.String,
                                                        ),
                                                        'messageImg':
                                                            serializeParam(
                                                          valueOrDefault(
                                                              currentUserDocument
                                                                  ?.messageLetterDayImage,
                                                              ''),
                                                          ParamType.String,
                                                        ),
                                                      }.withoutNulls,
                                                      extra: <String, dynamic>{
                                                        '__transition_info__':
                                                            TransitionInfo(
                                                          hasTransition: true,
                                                          transitionType:
                                                              PageTransitionType
                                                                  .fade,
                                                        ),
                                                      },
                                                    );
                                                  } else {
                                                    logFirebaseEvent(
                                                        'CustomSlider_navigate_to');

                                                    context.pushNamed(
                                                      MessageLetterPageStartWidget
                                                          .routeName,
                                                      extra: <String, dynamic>{
                                                        '__transition_info__':
                                                            TransitionInfo(
                                                          hasTransition: true,
                                                          transitionType:
                                                              PageTransitionType
                                                                  .fade,
                                                        ),
                                                      },
                                                    );
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 32.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 0.0, 20.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.asset(
                                                  'assets/images/logo34.webp',
                                                  width: 72.0,
                                                  height: 80.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'ПРИВЕТ, Я ДАРЛИ!',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .titleMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMediumFamily,
                                                            fontSize: 20.0,
                                                            letterSpacing: 0.0,
                                                            lineHeight: 1.2,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMediumIsCustom,
                                                          ),
                                                    ),
                                                    Text(
                                                      'Помогу ответить на твои вопросы и получить поддержку в любой момент',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .labelMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumFamily,
                                                            fontSize: 15.0,
                                                            letterSpacing: 0.0,
                                                            lineHeight: 1.2,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumIsCustom,
                                                          ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 4.0)),
                                                ),
                                              ),
                                            ].divide(SizedBox(width: 8.0)),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 12.0, 0.0, 0.0),
                                          child: Container(
                                            width: double.infinity,
                                            height: null,
                                            child: custom_widgets.DoubleRowList(
                                              width: double.infinity,
                                              height: null,
                                              list: functions.pressets(),
                                              offset: 60.0,
                                              startEndSpacing: 20.0,
                                              itemBuilder: (String item) =>
                                                  RowtitleWidget(
                                                title: item,
                                                select: (title) async {
                                                  logFirebaseEvent(
                                                      'HOME_Container_4l10qzs2_CALLBACK');
                                                  logFirebaseEvent(
                                                      'DoubleRowList_haptic_feedback');
                                                  HapticFeedback.mediumImpact();
                                                  logFirebaseEvent(
                                                      'DoubleRowList_update_app_state');
                                                  FFAppState().chatRef = null;
                                                  FFAppState().chatId = '';
                                                  FFAppState().pressetChat =
                                                      title!;
                                                  FFAppState().update(() {});
                                                  logFirebaseEvent(
                                                      'DoubleRowList_navigate_to');

                                                  context.pushNamed(
                                                    ChatPageWidget.routeName,
                                                    queryParameters: {
                                                      'presset': serializeParam(
                                                        title,
                                                        ParamType.String,
                                                      ),
                                                      'chat': serializeParam(
                                                        FFAppState().chatRef,
                                                        ParamType
                                                            .DocumentReference,
                                                      ),
                                                    }.withoutNulls,
                                                    extra: <String, dynamic>{
                                                      '__transition_info__':
                                                          TransitionInfo(
                                                        hasTransition: true,
                                                        transitionType:
                                                            PageTransitionType
                                                                .fade,
                                                        duration: Duration(
                                                            milliseconds: 0),
                                                      ),
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 20.0, 20.0, 0.0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              logFirebaseEvent(
                                                  'HOME_PAGE_PAGE____BTN_ON_TAP');
                                              logFirebaseEvent(
                                                  'Button_haptic_feedback');
                                              HapticFeedback.mediumImpact();
                                              logFirebaseEvent(
                                                  'Button_navigate_to');

                                              context.pushNamed(
                                                ChatPageWidget.routeName,
                                                queryParameters: {
                                                  'chat': serializeParam(
                                                    FFAppState().chatRef,
                                                    ParamType.DocumentReference,
                                                  ),
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  '__transition_info__':
                                                      TransitionInfo(
                                                    hasTransition: true,
                                                    transitionType:
                                                        PageTransitionType.fade,
                                                    duration: Duration(
                                                        milliseconds: 0),
                                                  ),
                                                },
                                              );
                                            },
                                            text: 'ПЕРЕЙТИ В ЧАТ',
                                            options: FFButtonOptions(
                                              width: double.infinity,
                                              height: 56.0,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 0.0, 16.0, 0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              textStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmallFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    fontSize: 17.0,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmallIsCustom,
                                                  ),
                                              elevation: 0.0,
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(56.0),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 32.0, 0.0, 0.0),
                                    child: FutureBuilder<int>(
                                      future: queryVideosRecordCount(
                                        queryBuilder: (videosRecord) =>
                                            videosRecord.where(
                                          'hide',
                                          isEqualTo: false,
                                        ),
                                      ),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 0.01,
                                              height: 0.01,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  Colors.transparent,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        int videoCount = snapshot.data!;

                                        return Container(
                                          decoration: BoxDecoration(),
                                          child: Visibility(
                                            visible: videoCount > 0,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          20.0, 0.0, 20.0, 8.0),
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
                                                          'HOME_PAGE_PAGE_Row_mbystb5m_ON_TAP');
                                                      logFirebaseEvent(
                                                          'Row_haptic_feedback');
                                                      HapticFeedback
                                                          .lightImpact();
                                                      logFirebaseEvent(
                                                          'Row_navigate_to');

                                                      context.pushNamed(
                                                          VideoPageWidget
                                                              .routeName);
                                                    },
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            'ВИДЕО',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .titleMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMediumFamily,
                                                                  fontSize:
                                                                      20.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  lineHeight:
                                                                      1.0,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleMediumIsCustom,
                                                                ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      4.0,
                                                                      0.0),
                                                          child: Text(
                                                            'Все',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .titleMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMediumFamily,
                                                                  fontSize:
                                                                      17.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  lineHeight:
                                                                      1.4,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleMediumIsCustom,
                                                                ),
                                                          ),
                                                        ),
                                                        Icon(
                                                          FFIcons.krightCircle,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          size: 24.0,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: FutureBuilder<
                                                      List<VideosRecord>>(
                                                    future: FFAppState().videos(
                                                      uniqueQueryKey:
                                                          '${currentUserUid}${FFAppState().refreshDate?.toString()}',
                                                      requestFn: () =>
                                                          queryVideosRecordOnce(
                                                        queryBuilder:
                                                            (videosRecord) =>
                                                                videosRecord
                                                                    .where(
                                                                      'hide',
                                                                      isEqualTo:
                                                                          false,
                                                                    )
                                                                    .orderBy(
                                                                        'index'),
                                                        limit: 5,
                                                      ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Center(
                                                          child: SizedBox(
                                                            width: 50,
                                                            height: 50,
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
                                                      List<VideosRecord>
                                                          videoRowVideosRecordList =
                                                          snapshot.data!;
                                                      if (videoRowVideosRecordList
                                                          .isEmpty) {
                                                        return Center(
                                                          child:
                                                              EmptyListWidget(),
                                                        );
                                                      }

                                                      return SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: List.generate(
                                                                  videoRowVideosRecordList
                                                                      .length,
                                                                  (videoRowIndex) {
                                                            final videoRowVideosRecord =
                                                                videoRowVideosRecordList[
                                                                    videoRowIndex];
                                                            return VideoHomeCompWidget(
                                                              key: Key(
                                                                  'Keyhl6_${videoRowIndex}_of_${videoRowVideosRecordList.length}'),
                                                              videoDoc:
                                                                  videoRowVideosRecord,
                                                            );
                                                          })
                                                              .divide(SizedBox(
                                                                  width: 12.0))
                                                              .addToStart(
                                                                  SizedBox(
                                                                      width:
                                                                          20.0))
                                                              .addToEnd(SizedBox(
                                                                  width: 20.0)),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 32.0, 20.0, 0.0),
                                    child: FutureBuilder<List<MetaCardsRecord>>(
                                      future: queryMetaCardsRecordOnce(),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 20.0,
                                              height: 20.0,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        List<MetaCardsRecord>
                                            metaCardMetaCardsRecordList =
                                            snapshot.data!;

                                        return Container(
                                          width: double.infinity,
                                          height: 335.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .white12,
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                            border: Border.all(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .white12,
                                            ),
                                          ),
                                          child: Container(
                                            width: double.infinity,
                                            height: double.infinity,
                                            child: Stack(
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 335.0,
                                                    child: custom_widgets
                                                        .FullScreenVideo(
                                                      width: double.infinity,
                                                      height: 335.0,
                                                      videoUrl:
                                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/woman-103qa6/assets/bbsgnt9e39ot/Woman-ezgif.com-gif-maker_(1).mp4',
                                                      looping: true,
                                                      autoPlay: true,
                                                      radius: 24.0,
                                                      onVideoEnd: () async {},
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16.0, 24.0,
                                                          16.0, 16.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              'МЕТАФОРИЧЕСКИЕ \nКАРТЫ',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .headlineSmallFamily,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    lineHeight:
                                                                        1.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .headlineSmallIsCustom,
                                                                  ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          4.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Text(
                                                                'Вытяни карту, чтобы прояснить мысли и чувства',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      fontSize:
                                                                          15.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.2,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .bodyMediumIsCustom,
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        height: 56.0,
                                                        child: custom_widgets
                                                            .CustomSlider(
                                                          width:
                                                              double.infinity,
                                                          height: 56.0,
                                                          borderColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .white24,
                                                          icon: Icon(
                                                            FFIcons
                                                                .krightDouble,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            size: 24.0,
                                                          ),
                                                          text:
                                                              'Проведите, чтобы открыть',
                                                          buttonColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .white24,
                                                          textSize: 15.0,
                                                          action: () async {
                                                            logFirebaseEvent(
                                                                'HOME_Container_g05v5qqg_CALLBACK');
                                                            logFirebaseEvent(
                                                                'CustomSlider_haptic_feedback');
                                                            HapticFeedback
                                                                .lightImpact();
                                                            logFirebaseEvent(
                                                                'CustomSlider_navigate_to');

                                                            context.pushNamed(
                                                              MetaCardSelectPageWidget
                                                                  .routeName,
                                                              queryParameters: {
                                                                'cards':
                                                                    serializeParam(
                                                                  metaCardMetaCardsRecordList,
                                                                  ParamType
                                                                      .Document,
                                                                  isList: true,
                                                                ),
                                                              }.withoutNulls,
                                                              extra: <String,
                                                                  dynamic>{
                                                                'cards':
                                                                    metaCardMetaCardsRecordList,
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 8.0)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
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
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 32.0, 20.0, 0.0),
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
                                        20.0, 32.0, 20.0, 0.0),
                                    child: FutureBuilder<List<CalendarRecord>>(
                                      future: queryCalendarRecordOnce(
                                        queryBuilder: (calendarRecord) =>
                                            calendarRecord.where(
                                          'created_by',
                                          isEqualTo: currentUserUid,
                                        ),
                                        singleRecord: true,
                                      ),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 20.0,
                                              height: 20.0,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        List<CalendarRecord>
                                            containerCalendarRecordList =
                                            snapshot.data!;
                                        final containerCalendarRecord =
                                            containerCalendarRecordList
                                                    .isNotEmpty
                                                ? containerCalendarRecordList
                                                    .first
                                                : null;

                                        return Container(
                                          decoration: BoxDecoration(),
                                          child: Container(
                                            width: double.infinity,
                                            height: 335.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .white12,
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: Image.asset(
                                                  'assets/images/calendar2.webp',
                                                ).image,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .white12,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Spacer(flex: 10),
                                                  Text(
                                                    valueOrDefault<String>(
                                                      containerCalendarRecord !=
                                                              null
                                                          ? valueOrDefault<
                                                              String>(
                                                              valueOrDefault<
                                                                          int>(
                                                                        functions.cycleDay(
                                                                            getCurrentTimestamp,
                                                                            containerCalendarRecord!.monthCycles.toList()),
                                                                        1,
                                                                      ) >
                                                                      0
                                                                  ? '${valueOrDefault<String>(
                                                                      functions
                                                                          .cycleDay(
                                                                              getCurrentTimestamp,
                                                                              containerCalendarRecord!.monthCycles.toList())
                                                                          .toString(),
                                                                      '1',
                                                                    )} ДЕНЬ ЦИКЛА'
                                                                  : 'КАЛЕНДАРЬ ЦИКЛА',
                                                              'ЗАПОЛНИТЬ',
                                                            )
                                                          : 'КАЛЕНДАРЬ ЦИКЛА',
                                                      'КАЛЕНДАРЬ ЦИКЛА',
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .headlineMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineMediumFamily,
                                                          letterSpacing: 0.0,
                                                          lineHeight: 1.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineMediumIsCustom,
                                                        ),
                                                  ),
                                                  if (valueOrDefault<bool>(
                                                    containerCalendarRecord !=
                                                            null
                                                        ? valueOrDefault<bool>(
                                                            valueOrDefault<int>(
                                                                  functions.cycleDay(
                                                                      getCurrentTimestamp,
                                                                      containerCalendarRecord!
                                                                          .monthCycles
                                                                          .toList()),
                                                                  1,
                                                                ) >
                                                                0,
                                                            false,
                                                          )
                                                        : false,
                                                    false,
                                                  ))
                                                    Text(
                                                      functions.phaseBannerText(
                                                          functions.cyclePhase(
                                                              containerCalendarRecord
                                                                  ?.monthCycles
                                                                  ?.toList(),
                                                              getCurrentTimestamp)),
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 3,
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
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  Spacer(),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 16.0,
                                                                0.0, 0.0),
                                                    child: FFButtonWidget(
                                                      onPressed: () async {
                                                        logFirebaseEvent(
                                                            'HOME_PAGE_PAGE_Button_9kzl89nm_ON_TAP');
                                                        var _shouldSetState =
                                                            false;
                                                        logFirebaseEvent(
                                                            'Button_haptic_feedback');
                                                        HapticFeedback
                                                            .mediumImpact();
                                                        if (!(containerCalendarRecord !=
                                                            null)) {
                                                          logFirebaseEvent(
                                                              'Button_backend_call');

                                                          var calendarRecordReference =
                                                              CalendarRecord
                                                                  .collection
                                                                  .doc();
                                                          await calendarRecordReference
                                                              .set(
                                                                  createCalendarRecordData(
                                                            createdAt:
                                                                getCurrentTimestamp,
                                                            createdBy:
                                                                currentUserUid,
                                                          ));
                                                          _model.newCalend = CalendarRecord
                                                              .getDocumentFromData(
                                                                  createCalendarRecordData(
                                                                    createdAt:
                                                                        getCurrentTimestamp,
                                                                    createdBy:
                                                                        currentUserUid,
                                                                  ),
                                                                  calendarRecordReference);
                                                          _shouldSetState =
                                                              true;
                                                          logFirebaseEvent(
                                                              'Button_navigate_to');

                                                          context.pushNamed(
                                                            CalendarStartWidget
                                                                .routeName,
                                                            queryParameters: {
                                                              'calendar':
                                                                  serializeParam(
                                                                _model.newCalend
                                                                    ?.reference,
                                                                ParamType
                                                                    .DocumentReference,
                                                              ),
                                                            }.withoutNulls,
                                                          );
                                                        } else {
                                                          if (valueOrDefault<
                                                              bool>(
                                                            (containerCalendarRecord!
                                                                        .monthCycles
                                                                        .length >
                                                                    0) &&
                                                                (containerCalendarRecord !=
                                                                    null),
                                                            false,
                                                          )) {
                                                            if (functions.currentMonthInCalendarExist(
                                                                containerCalendarRecord!
                                                                    .monthCycles
                                                                    .toList())) {
                                                              logFirebaseEvent(
                                                                  'Button_navigate_to');

                                                              context.pushNamed(
                                                                CalendarPageWidget
                                                                    .routeName,
                                                                queryParameters:
                                                                    {
                                                                  'calendarUser':
                                                                      serializeParam(
                                                                    containerCalendarRecord
                                                                        ?.reference,
                                                                    ParamType
                                                                        .DocumentReference,
                                                                  ),
                                                                }.withoutNulls,
                                                              );

                                                              if (_shouldSetState)
                                                                safeSetState(
                                                                    () {});
                                                              return;
                                                            }
                                                          }
                                                          logFirebaseEvent(
                                                              'Button_navigate_to');

                                                          context.pushNamed(
                                                            CalendarStartWidget
                                                                .routeName,
                                                            queryParameters: {
                                                              'calendar':
                                                                  serializeParam(
                                                                containerCalendarRecord
                                                                    ?.reference,
                                                                ParamType
                                                                    .DocumentReference,
                                                              ),
                                                            }.withoutNulls,
                                                          );
                                                        }

                                                        if (_shouldSetState)
                                                          safeSetState(() {});
                                                      },
                                                      text: valueOrDefault<
                                                          String>(
                                                        (containerCalendarRecord !=
                                                                    null) &&
                                                                valueOrDefault<
                                                                    bool>(
                                                                  containerCalendarRecord
                                                                              ?.monthCycles !=
                                                                          null &&
                                                                      (containerCalendarRecord
                                                                              ?.monthCycles)!
                                                                          .isNotEmpty,
                                                                  false,
                                                                )
                                                            ? 'ПОДРОБНЕЕ'
                                                            : 'ЗАПОЛНИТЬ',
                                                        'ПОДРОБНЕЕ',
                                                      ),
                                                      options: FFButtonOptions(
                                                        height: 40.0,
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    20.0,
                                                                    0.0,
                                                                    20.0,
                                                                    0.0),
                                                        iconPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmallFamily,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmallIsCustom,
                                                                ),
                                                        elevation: 0.0,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(56.0),
                                                      ),
                                                    ),
                                                  ),
                                                ].divide(SizedBox(height: 4.0)),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ]
                                    .addToStart(SizedBox(height: 120.0))
                                    .addToEnd(SizedBox(height: 120.0)),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0.0),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 3.0,
                                  sigmaY: 6.0,
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 54.0, 20.0, 4.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          logFirebaseEvent(
                                              'HOME_PAGE_PAGE_Container_53cdnk0n_ON_TAP');
                                          logFirebaseEvent(
                                              'Container_haptic_feedback');
                                          HapticFeedback.mediumImpact();
                                          logFirebaseEvent(
                                              'Container_navigate_to');

                                          context.pushNamed(
                                            ProfilePageWidget.routeName,
                                            extra: <String, dynamic>{
                                              '__transition_info__':
                                                  TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType.fade,
                                                duration:
                                                    Duration(milliseconds: 0),
                                              ),
                                            },
                                          );
                                        },
                                        child: Container(
                                          width: 56.0,
                                          height: 56.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .white12,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .white12,
                                            ),
                                          ),
                                          child: Builder(
                                            builder: (context) {
                                              if (currentUserPhoto != null &&
                                                  currentUserPhoto != '') {
                                                return Container(
                                                  width: 56.0,
                                                  height: 56.0,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: CachedNetworkImage(
                                                    fadeInDuration: Duration(
                                                        milliseconds: 500),
                                                    fadeOutDuration: Duration(
                                                        milliseconds: 500),
                                                    imageUrl: getCORSProxyUrl(
                                                      currentUserPhoto,
                                                    ),
                                                    fit: BoxFit.cover,
                                                    errorWidget: (context,
                                                            error,
                                                            stackTrace) =>
                                                        Image.asset(
                                                      'assets/images/error_image.jpg',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: AuthUserStreamWidget(
                                                    builder: (context) => Text(
                                                      valueOrDefault<String>(
                                                        functions.nameLettters(
                                                            currentUserDisplayName,
                                                            valueOrDefault(
                                                                currentUserDocument
                                                                    ?.surname,
                                                                '')),
                                                        'WN',
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .titleLarge
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLargeFamily,
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.0,
                                                            lineHeight: 1.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLargeIsCustom,
                                                          ),
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            valueOrDefault<String>(
                                              functions.dateTextNow(),
                                              'Доброе утро! ☀️',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .titleMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMediumFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  letterSpacing: 0.0,
                                                  lineHeight: 1.25,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .titleMediumIsCustom,
                                                ),
                                          ),
                                          if ((currentUserDisplayName != null &&
                                                  currentUserDisplayName !=
                                                      '') ||
                                              (valueOrDefault(
                                                          currentUserDocument
                                                              ?.surname,
                                                          '') ==
                                                      null ||
                                                  valueOrDefault(
                                                          currentUserDocument
                                                              ?.surname,
                                                          '') ==
                                                      ''))
                                            AuthUserStreamWidget(
                                              builder: (context) => Text(
                                                valueOrDefault<String>(
                                                  functions.nameHome(
                                                      currentUserDisplayName,
                                                      valueOrDefault(
                                                          currentUserDocument
                                                              ?.surname,
                                                          '')),
                                                  'МИЛАЯ',
                                                ),
                                                maxLines: 1,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleMediumFamily,
                                                          fontSize: 24.0,
                                                          letterSpacing: 0.0,
                                                          lineHeight: 1.2,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleMediumIsCustom,
                                                        ),
                                              ),
                                            ),
                                        ].divide(SizedBox(height: 4.0)),
                                      ),
                                      wrapWithModel(
                                        model: _model.backButtonModel,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: BackButtonWidget(
                                          icon: Icon(
                                            FFIcons.khomeNotificationIcon,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 24.0,
                                          ),
                                          action: () async {
                                            logFirebaseEvent(
                                                'HOME_Container_j4vsnwvk_CALLBACK');
                                            logFirebaseEvent(
                                                'backButton_haptic_feedback');
                                            HapticFeedback.mediumImpact();
                                            logFirebaseEvent(
                                                'backButton_navigate_to');

                                            context.pushNamed(
                                                NotificationPageWidget
                                                    .routeName);
                                          },
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 8.0)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  wrapWithModel(
                    model: _model.navbarModel,
                    updateCallback: () => safeSetState(() {}),
                    child: NavbarWidget(
                      pageNum: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
