import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/back_button/back_button_widget.dart';
import '/components/notif_comp/notif_comp_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'notification_page_model.dart';
export 'notification_page_model.dart';

class NotificationPageWidget extends StatefulWidget {
  const NotificationPageWidget({super.key});

  static String routeName = 'NotificationPage';
  static String routePath = '/notificationPage';

  @override
  State<NotificationPageWidget> createState() => _NotificationPageWidgetState();
}

class _NotificationPageWidgetState extends State<NotificationPageWidget> {
  late NotificationPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotificationPageModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'NotificationPage'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('NOTIFICATION_NotificationPage_ON_INIT_ST');
      logFirebaseEvent('NotificationPage_custom_action');
      unawaited(
        () async {
          await actions.setStatusBarColor();
        }(),
      );
      logFirebaseEvent('NotificationPage_custom_action');
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
        title: 'NotificationPage',
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
                  Align(
                    alignment: AlignmentDirectional(0.0, -1.0),
                    child: Padding(
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
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                action: () async {
                                  logFirebaseEvent(
                                      'NOTIFICATION_Container_md6gevh0_CALLBACK');
                                  logFirebaseEvent('backButton_navigate_back');
                                  context.safePop();
                                },
                              ),
                            ),
                          ),
                          Text(
                            'Уведомления',
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
                              width: 56.0,
                              height: 0.0,
                              decoration: BoxDecoration(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<List<NotificationsRecord>>(
                      future: queryNotificationsRecordOnce(
                        queryBuilder: (notificationsRecord) =>
                            notificationsRecord.orderBy('created_at',
                                descending: true),
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 20.0,
                              height: 20.0,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                          );
                        }
                        List<NotificationsRecord>
                            containerNotificationsRecordList = snapshot.data!;

                        return Container(
                          constraints: BoxConstraints(
                            maxWidth: 600.0,
                          ),
                          decoration: BoxDecoration(),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 8.0, 20.0, 0.0),
                            child: Builder(
                              builder: (context) {
                                final dates = containerNotificationsRecordList
                                    .where((e) =>
                                        (e.userId == currentUserUid) ||
                                        (e.userId == null || e.userId == ''))
                                    .toList()
                                    .unique((e) => e.createdAt!)
                                    .toList();

                                return ListView.separated(
                                  padding: EdgeInsets.fromLTRB(
                                    0,
                                    16.0,
                                    0,
                                    48.0,
                                  ),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: dates.length,
                                  separatorBuilder: (_, __) =>
                                      SizedBox(height: 16.0),
                                  itemBuilder: (context, datesIndex) {
                                    final datesItem = dates[datesIndex];
                                    return Container(
                                      decoration: BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-1.0, 0.0),
                                            child: Text(
                                              dateTimeFormat(
                                                "d MMMM",
                                                datesItem.createdAt!,
                                                locale:
                                                    FFLocalizations.of(context)
                                                        .languageCode,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
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
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .titleMediumIsCustom,
                                                  ),
                                            ),
                                          ),
                                          Builder(
                                            builder: (context) {
                                              final notificatons =
                                                  containerNotificationsRecordList
                                                      .where((e) =>
                                                          (dateTimeFormat(
                                                                "d/M/y",
                                                                e.createdAt,
                                                                locale: FFLocalizations.of(
                                                                        context)
                                                                    .languageCode,
                                                              ) ==
                                                              dateTimeFormat(
                                                                "d/M/y",
                                                                datesItem
                                                                    .createdAt,
                                                                locale: FFLocalizations.of(
                                                                        context)
                                                                    .languageCode,
                                                              )) &&
                                                          ((e.userId ==
                                                                  currentUserUid) ||
                                                              (e.userId ==
                                                                      null ||
                                                                  e.userId ==
                                                                      '')))
                                                      .toList()
                                                      .sortedList(
                                                          keyOf: (e) =>
                                                              e.createdAt!,
                                                          desc: true)
                                                      .toList();

                                              return Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: List.generate(
                                                    notificatons.length,
                                                    (notificatonsIndex) {
                                                  final notificatonsItem =
                                                      notificatons[
                                                          notificatonsIndex];
                                                  return Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 8.0,
                                                                0.0, 0.0),
                                                    child: NotifCompWidget(
                                                      key: Key(
                                                          'Key9vf_${notificatonsIndex}_of_${notificatons.length}'),
                                                      notifComp:
                                                          notificatonsItem,
                                                    ),
                                                  );
                                                }),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
