import '/backend/backend.dart';
import '/components/back_button/back_button_widget.dart';
import '/components/empty_list/empty_list_widget.dart';
import '/components/video_comp/video_comp_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'video_page_model.dart';
export 'video_page_model.dart';

class VideoPageWidget extends StatefulWidget {
  const VideoPageWidget({super.key});

  static String routeName = 'VideoPage';
  static String routePath = '/videoPage';

  @override
  State<VideoPageWidget> createState() => _VideoPageWidgetState();
}

class _VideoPageWidgetState extends State<VideoPageWidget> {
  late VideoPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VideoPageModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'VideoPage'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('VIDEO_PAGE_PAGE_VideoPage_ON_INIT_STATE');
      logFirebaseEvent('VideoPage_custom_action');
      unawaited(
        () async {
          await actions.setStatusBarColor();
        }(),
      );
      logFirebaseEvent('VideoPage_custom_action');
      unawaited(
        () async {
          await actions.unlockLandscapeMode();
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
        title: 'VideoPage',
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
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 54.0, 0.0, 4.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    'VIDEO_Container_th1rvhrz_CALLBACK');
                                logFirebaseEvent('backButton_navigate_back');
                                context.safePop();
                              },
                            ),
                          ),
                        ),
                        Text(
                          'Видео',
                          style: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleMediumFamily,
                                fontSize: 17.0,
                                letterSpacing: 0.0,
                                lineHeight: 1.2,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .titleMediumIsCustom,
                              ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 12.0, 0.0),
                          child: Container(
                            width: 48.0,
                            height: 0.0,
                            decoration: BoxDecoration(),
                          ),
                        ),
                      ],
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
                        child: PagedListView<DocumentSnapshot<Object?>?,
                            VideosRecord>.separated(
                          pagingController: _model.setListViewController(
                            VideosRecord.collection
                                .where(
                                  'hide',
                                  isEqualTo: false,
                                )
                                .orderBy('index'),
                          ),
                          padding: EdgeInsets.fromLTRB(
                            0,
                            20.0,
                            0,
                            48.0,
                          ),
                          shrinkWrap: true,
                          reverse: false,
                          scrollDirection: Axis.vertical,
                          separatorBuilder: (_, __) => SizedBox(height: 20.0),
                          builderDelegate:
                              PagedChildBuilderDelegate<VideosRecord>(
                            // Customize what your widget looks like when it's loading the first page.
                            firstPageProgressIndicatorBuilder: (_) => Center(
                              child: SizedBox(
                                width: 20.0,
                                height: 20.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    FlutterFlowTheme.of(context).primary,
                                  ),
                                ),
                              ),
                            ),
                            // Customize what your widget looks like when it's loading another page.
                            newPageProgressIndicatorBuilder: (_) => Center(
                              child: SizedBox(
                                width: 20.0,
                                height: 20.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    FlutterFlowTheme.of(context).primary,
                                  ),
                                ),
                              ),
                            ),
                            noItemsFoundIndicatorBuilder: (_) => Center(
                              child: EmptyListWidget(),
                            ),
                            itemBuilder: (context, _, listViewIndex) {
                              final listViewVideosRecord = _model
                                  .listViewPagingController!
                                  .itemList![listViewIndex];
                              return VideoCompWidget(
                                key: Key(
                                    'Key9l3_${listViewIndex}_of_${_model.listViewPagingController!.itemList!.length}'),
                                videoDoc: listViewVideosRecord,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
