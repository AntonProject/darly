import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/web/profile_web_dialog/profile_web_dialog_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'navbar_web_model.dart';
export 'navbar_web_model.dart';

class NavbarWebWidget extends StatefulWidget {
  const NavbarWebWidget({
    super.key,
    required this.pageNum,
  });

  final double? pageNum;

  @override
  State<NavbarWebWidget> createState() => _NavbarWebWidgetState();
}

class _NavbarWebWidgetState extends State<NavbarWebWidget> {
  late NavbarWebModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NavbarWebModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: AlignmentDirectional(-1.0, 0.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(0.0),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 4.0,
                sigmaY: 4.0,
              ),
              child: Container(
                width: 260.0,
                height: MediaQuery.sizeOf(context).height * 1.0,
                constraints: BoxConstraints(
                  maxWidth: 260.0,
                ),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondary,
                ),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 40.0, 16.0, 40.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(0.0),
                                child: Image.asset(
                                  'assets/images/Frame_881234025.webp',
                                  width: 48.0,
                                  height: 48.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Woman',
                                  style: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
                                        fontFamily: 'LT Remark',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 32.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                            ].divide(SizedBox(width: 8.0)),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 40.0, 0.0, 40.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                logFirebaseEvent(
                                    'NAVBAR_WEB_Container_akxy2y75_ON_TAP');
                                logFirebaseEvent('Container_haptic_feedback');
                                HapticFeedback.lightImpact();
                                logFirebaseEvent('Container_navigate_to');

                                context.pushNamed(
                                  EducationPageWidget.routeName,
                                  extra: <String, dynamic>{
                                    '__transition_info__': TransitionInfo(
                                      hasTransition: true,
                                      transitionType: PageTransitionType.fade,
                                      duration: Duration(milliseconds: 0),
                                    ),
                                  },
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                height: 48.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).accent1,
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Builder(
                                      builder: (context) {
                                        if ((widget!.pageNum! >= 2.0) ||
                                            (widget!.pageNum! < 3.0)) {
                                          return Icon(
                                            FFIcons.khomeOn,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 27.0,
                                          );
                                        } else {
                                          return Icon(
                                            FFIcons.klessonOff,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 27.0,
                                          );
                                        }
                                      },
                                    ),
                                    Text(
                                      'ОБУЧЕНИЕ',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelMediumFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 15.0,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .labelMediumIsCustom,
                                          ),
                                    ),
                                  ]
                                      .divide(SizedBox(width: 8.0))
                                      .addToStart(SizedBox(width: 12.0))
                                      .addToEnd(SizedBox(width: 12.0)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 16.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(-1.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'NAVBAR_WEB_COMP_Text_riwp5fr4_ON_TAP');
                                    logFirebaseEvent('Text_haptic_feedback');
                                    HapticFeedback.lightImpact();
                                    logFirebaseEvent('Text_update_app_state');
                                    FFAppState().chatRef = null;
                                    safeSetState(() {});
                                    logFirebaseEvent('Text_navigate_to');

                                    context.pushNamed(
                                      ChatPageWidget.routeName,
                                      extra: <String, dynamic>{
                                        '__transition_info__': TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.fade,
                                          duration: Duration(milliseconds: 0),
                                        ),
                                      },
                                    );
                                  },
                                  child: Text(
                                    'ЧАТЫ',
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .titleMediumFamily,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .titleMediumIsCustom,
                                        ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: StreamBuilder<List<ChatsRecord>>(
                                  stream: queryChatsRecord(
                                    queryBuilder: (chatsRecord) => chatsRecord
                                        .where(
                                          'created_by',
                                          isEqualTo: currentUserUid,
                                        )
                                        .orderBy('created_at',
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
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    List<ChatsRecord> containerChatsRecordList =
                                        snapshot.data!;

                                    return Container(
                                      constraints: BoxConstraints(
                                        maxWidth: 600.0,
                                      ),
                                      decoration: BoxDecoration(),
                                      child: Builder(
                                        builder: (context) {
                                          final dates = containerChatsRecordList
                                              .unique((e) => dateTimeFormat(
                                                    "M/y",
                                                    e.createdAt!,
                                                    locale: FFLocalizations.of(
                                                            context)
                                                        .languageCode,
                                                  ))
                                              .toList();

                                          return SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: List.generate(
                                                  dates.length, (datesIndex) {
                                                final datesItem =
                                                    dates[datesIndex];
                                                return Container(
                                                  decoration: BoxDecoration(),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1.0, 0.0),
                                                        child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            dateTimeFormat(
                                                                      "M/y",
                                                                      datesItem
                                                                          .createdAt,
                                                                      locale: FFLocalizations.of(
                                                                              context)
                                                                          .languageCode,
                                                                    ) ==
                                                                    dateTimeFormat(
                                                                      "M/y",
                                                                      getCurrentTimestamp,
                                                                      locale: FFLocalizations.of(
                                                                              context)
                                                                          .languageCode,
                                                                    )
                                                                ? 'Последний месяц'
                                                                : ((String
                                                                    text) {
                                                                    return text
                                                                            .isEmpty
                                                                        ? ' '
                                                                        : text[0].toUpperCase() +
                                                                            text.substring(1);
                                                                  }(valueOrDefault<
                                                                    String>(
                                                                    dateTimeFormat(
                                                                      "LLLL yyyy",
                                                                      datesItem
                                                                          .createdAt,
                                                                      locale: FFLocalizations.of(
                                                                              context)
                                                                          .languageCode,
                                                                    ),
                                                                    'Последний месяц',
                                                                  ))),
                                                            'Последний месяц',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .labelSmall
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmallFamily,
                                                                fontSize: 15.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelSmallIsCustom,
                                                              ),
                                                        ),
                                                      ),
                                                      Builder(
                                                        builder: (context) {
                                                          final chats =
                                                              containerChatsRecordList
                                                                  .where((e) =>
                                                                      dateTimeFormat(
                                                                        "M/y",
                                                                        e.createdAt,
                                                                        locale:
                                                                            FFLocalizations.of(context).languageCode,
                                                                      ) ==
                                                                      dateTimeFormat(
                                                                        "M/y",
                                                                        datesItem
                                                                            .createdAt,
                                                                        locale:
                                                                            FFLocalizations.of(context).languageCode,
                                                                      ))
                                                                  .toList();

                                                          return Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children:
                                                                List.generate(
                                                                    chats
                                                                        .length,
                                                                    (chatsIndex) {
                                                              final chatsItem =
                                                                  chats[
                                                                      chatsIndex];
                                                              return Container(
                                                                decoration:
                                                                    BoxDecoration(),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    if (chatsIndex !=
                                                                        0)
                                                                      Divider(
                                                                        height:
                                                                            1.0,
                                                                        thickness:
                                                                            1.0,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .tertiary,
                                                                      ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          16.0,
                                                                          0.0,
                                                                          16.0),
                                                                      child:
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
                                                                              'NAVBAR_WEB_COMP_Row_xw695tlz_ON_TAP');
                                                                          logFirebaseEvent(
                                                                              'Row_update_app_state');
                                                                          FFAppState().chatRef =
                                                                              chatsItem.reference;
                                                                          safeSetState(
                                                                              () {});
                                                                          logFirebaseEvent(
                                                                              'Row_navigate_to');

                                                                          context
                                                                              .pushNamed(
                                                                            ChatPageWidget.routeName,
                                                                            extra: <String,
                                                                                dynamic>{
                                                                              '__transition_info__': TransitionInfo(
                                                                                hasTransition: true,
                                                                                transitionType: PageTransitionType.fade,
                                                                                duration: Duration(milliseconds: 0),
                                                                              ),
                                                                            },
                                                                          );
                                                                        },
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children:
                                                                              [
                                                                            Expanded(
                                                                              child: Text(
                                                                                (String text) {
                                                                                  return text.isEmpty ? ' ' : text[0].toUpperCase() + text.substring(1);
                                                                                }(valueOrDefault<String>(
                                                                                  chatsItem.title,
                                                                                  'unnamed',
                                                                                )),
                                                                                maxLines: 1,
                                                                                style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                      fontFamily: FlutterFlowTheme.of(context).labelLargeFamily,
                                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                                      letterSpacing: 0.0,
                                                                                      useGoogleFonts: !FlutterFlowTheme.of(context).labelLargeIsCustom,
                                                                                    ),
                                                                                overflow: TextOverflow.ellipsis,
                                                                              ),
                                                                            ),
                                                                          ].divide(SizedBox(width: 8.0)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            }),
                                                          );
                                                        },
                                                      ),
                                                    ].addToStart(
                                                        SizedBox(height: 16.0)),
                                                  ),
                                                );
                                              }).addToEnd(
                                                  SizedBox(height: 24.0)),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(),
                        child: Builder(
                          builder: (context) => Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 12.0, 0.0, 0.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                logFirebaseEvent(
                                    'NAVBAR_WEB_COMP_Row_esgs3rf3_ON_TAP');
                                logFirebaseEvent('Row_haptic_feedback');
                                HapticFeedback.lightImpact();
                                logFirebaseEvent('Row_update_component_state');
                                _model.showProfileDialog =
                                    !_model.showProfileDialog;
                                safeSetState(() {});
                                logFirebaseEvent('Row_alert_dialog');
                                await showAlignedDialog(
                                  barrierColor: Colors.transparent,
                                  context: context,
                                  isGlobal: false,
                                  avoidOverflow: true,
                                  targetAnchor: AlignmentDirectional(0.0, -1.0)
                                      .resolve(Directionality.of(context)),
                                  followerAnchor: AlignmentDirectional(0.0, 0.0)
                                      .resolve(Directionality.of(context)),
                                  builder: (dialogContext) {
                                    return Material(
                                      color: Colors.transparent,
                                      child: WebViewAware(
                                        child: ProfileWebDialogWidget(),
                                      ),
                                    );
                                  },
                                );

                                logFirebaseEvent('Row_update_component_state');
                                _model.showProfileDialog =
                                    !_model.showProfileDialog;
                                safeSetState(() {});
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 56.0,
                                    height: 56.0,
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).white24,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .white12,
                                        width: 2.0,
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
                                              fadeInDuration:
                                                  Duration(milliseconds: 500),
                                              fadeOutDuration:
                                                  Duration(milliseconds: 500),
                                              imageUrl: getCORSProxyUrl(
                                                currentUserPhoto,
                                              ),
                                              fit: BoxFit.cover,
                                              errorWidget: (context, error,
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
                                                AlignmentDirectional(0.0, 0.0),
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
                                                textAlign: TextAlign.center,
                                                style:
                                                    FlutterFlowTheme.of(context)
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
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleLargeIsCustom,
                                                        ),
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              'ПРОФИЛЬ',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        fontSize: 15.0,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMediumIsCustom,
                                                      ),
                                            ),
                                            Builder(
                                              builder: (context) {
                                                if (_model.showProfileDialog) {
                                                  return FaIcon(
                                                    FontAwesomeIcons.caretUp,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    size: 24.0,
                                                  );
                                                } else {
                                                  return FaIcon(
                                                    FontAwesomeIcons.caretDown,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    size: 24.0,
                                                  );
                                                }
                                              },
                                            ),
                                          ].divide(SizedBox(width: 8.0)),
                                        ),
                                        AuthUserStreamWidget(
                                          builder: (context) => Text(
                                            valueOrDefault<String>(
                                              valueOrDefault<bool>(
                                                functions.dateGreatherThanToday(
                                                    currentUserDocument
                                                        ?.subscriptionExpDate),
                                                false,
                                              )
                                                  ? 'Подписка активна'
                                                  : 'Подписка неактивна',
                                              'Подписка неактивна',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  fontSize: 13.0,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumIsCustom,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ].divide(SizedBox(width: 12.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ].divide(SizedBox(height: 4.0)),
                  ),
                ),
              ),
            ),
          ),
        ),
        VerticalDivider(
          width: 1.0,
          thickness: 1.0,
          color: FlutterFlowTheme.of(context).tertiary,
        ),
      ],
    );
  }
}
