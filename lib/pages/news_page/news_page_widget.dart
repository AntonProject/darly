import '/backend/backend.dart';
import '/components/back_button/back_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'news_page_model.dart';
export 'news_page_model.dart';

class NewsPageWidget extends StatefulWidget {
  const NewsPageWidget({
    super.key,
    required this.news,
  });

  final NewsRecord? news;

  static String routeName = 'NewsPage';
  static String routePath = '/newsPage';

  @override
  State<NewsPageWidget> createState() => _NewsPageWidgetState();
}

class _NewsPageWidgetState extends State<NewsPageWidget> {
  late NewsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewsPageModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'NewsPage'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('NEWS_PAGE_PAGE_NewsPage_ON_INIT_STATE');
      logFirebaseEvent('NewsPage_custom_action');
      unawaited(
        () async {
          await actions.setStatusBarColor();
        }(),
      );
      logFirebaseEvent('NewsPage_custom_action');
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
        title: 'NewsPage',
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
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.0, -1.0),
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: 600.0,
                            ),
                            decoration: BoxDecoration(),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0.0, 1.0),
                                    child: Stack(
                                      alignment:
                                          AlignmentDirectional(0.0, -1.0),
                                      children: [
                                        if (widget!.news?.image != null &&
                                            widget!.news?.image != '')
                                          Container(
                                            width: double.infinity,
                                            height: 320.0,
                                            child: custom_widgets.MaskedImage(
                                              width: double.infinity,
                                              height: 320.0,
                                              imageUrl: widget!.news?.image,
                                              topRadius: 20.0,
                                            ),
                                          ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0,
                                                  valueOrDefault<double>(
                                                    widget!.news?.image !=
                                                                null &&
                                                            widget!.news
                                                                    ?.image !=
                                                                ''
                                                        ? 250.0
                                                        : 0.0,
                                                    0.0,
                                                  ),
                                                  20.0,
                                                  0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget!.news!.title
                                                    .toUpperCase(),
                                                maxLines: 5,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineMediumFamily,
                                                          letterSpacing: 0.0,
                                                          lineHeight: 1.2,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineMediumIsCustom,
                                                        ),
                                              ),
                                              Text(
                                                widget!.news!.text,
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyLarge
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyLargeFamily,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary80,
                                                      fontSize: 17.0,
                                                      letterSpacing: 0.0,
                                                      lineHeight: 1.4,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyLargeIsCustom,
                                                    ),
                                              ),
                                            ].divide(SizedBox(height: 8.0)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]
                                    .addToStart(SizedBox(height: 120.0))
                                    .addToEnd(SizedBox(height: 120.0)),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, 1.0),
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: 600.0,
                            ),
                            decoration: BoxDecoration(),
                            child: Visibility(
                              visible: widget!.news?.url != null &&
                                  widget!.news?.url != '',
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 12.0, 20.0, 34.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    logFirebaseEvent(
                                        'NEWS_PAGE_PAGE__BTN_ON_TAP');
                                    logFirebaseEvent('Button_haptic_feedback');
                                    HapticFeedback.mediumImpact();
                                    logFirebaseEvent('Button_launch_u_r_l');
                                    unawaited(
                                      () async {
                                        await launchURL(widget!.news!.url);
                                      }(),
                                    );
                                  },
                                  text: valueOrDefault<String>(
                                    widget!.news?.buttonText,
                                    'ПОДРОБНЕЕ',
                                  ),
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 56.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).primary,
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
                                      color: Colors.transparent,
                                    ),
                                    borderRadius: BorderRadius.circular(56.0),
                                  ),
                                  showLoadingIndicator: false,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(0.0),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 1.0,
                              sigmaY: 3.0,
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 54.0, 12.0, 4.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  wrapWithModel(
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
                                            'NEWS_Container_ve6qgt2r_CALLBACK');
                                        logFirebaseEvent(
                                            'backButton_navigate_back');
                                        context.safePop();
                                      },
                                    ),
                                  ),
                                  Text(
                                    dateTimeFormat(
                                      "d MMMM",
                                      widget!.news!.date!,
                                      locale: FFLocalizations.of(context)
                                          .languageCode,
                                    ),
                                    maxLines: 1,
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
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Container(
                                    width: 56.0,
                                    height: 56.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
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
            ),
          ),
        ));
  }
}
