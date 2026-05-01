import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'navbar_copy_model.dart';
export 'navbar_copy_model.dart';

class NavbarCopyWidget extends StatefulWidget {
  const NavbarCopyWidget({
    super.key,
    double? pageNum,
  }) : this.pageNum = pageNum ?? 1.0;

  final double pageNum;

  @override
  State<NavbarCopyWidget> createState() => _NavbarCopyWidgetState();
}

class _NavbarCopyWidgetState extends State<NavbarCopyWidget> {
  late NavbarCopyModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NavbarCopyModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Visibility(
      visible: responsiveVisibility(
        context: context,
        tabletLandscape: false,
        desktop: false,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
            16.0,
            0.0,
            16.0,
            valueOrDefault<double>(
              isAndroid ? 54.0 : 34.0,
              34.0,
            )),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(99.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 12.0,
              sigmaY: 12.0,
            ),
            child: Material(
              color: Colors.transparent,
              elevation: 1.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(99.0),
              ),
              child: Container(
                width: double.infinity,
                height: 64.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).white12,
                  borderRadius: BorderRadius.circular(99.0),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).white12,
                    width: 1.0,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (!valueOrDefault<bool>(
                        isWeb,
                        false,
                      ))
                        Expanded(
                          child: Builder(
                            builder: (context) {
                              if (widget!.pageNum == 1.0) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(99.0),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 12.0,
                                      sigmaY: 12.0,
                                    ),
                                    child: Container(
                                      height: 54.0,
                                      constraints: BoxConstraints(
                                        minWidth: 70.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .white12,
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .white12,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            FFIcons.khomeOn,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 28.0,
                                          ),
                                          AutoSizeText(
                                            'Главная',
                                            maxLines: 1,
                                            style: FlutterFlowTheme.of(context)
                                                .labelSmall
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelSmallFamily,
                                                  color: valueOrDefault<Color>(
                                                    widget!.pageNum == 1.0
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryText,
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                  ),
                                                  fontSize: 10.0,
                                                  letterSpacing: 0.0,
                                                  lineHeight: 1.4,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .labelSmallIsCustom,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'NAVBAR_COPY_COMP_Column_u50caux1_ON_TAP');
                                    logFirebaseEvent('Column_haptic_feedback');
                                    HapticFeedback.mediumImpact();
                                    if (widget!.pageNum != 1.0) {
                                      logFirebaseEvent('Column_navigate_to');

                                      context.pushNamed(
                                        HomePageWidget.routeName,
                                        extra: <String, dynamic>{
                                          '__transition_info__': TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.fade,
                                            duration: Duration(milliseconds: 0),
                                          ),
                                        },
                                      );
                                    }
                                    logFirebaseEvent('Column_custom_action');
                                    unawaited(
                                      () async {
                                        await actions.closeKeyboard(
                                          context,
                                        );
                                      }(),
                                    );
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        FFIcons.khomeOn,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 28.0,
                                      ),
                                      AutoSizeText(
                                        'Главная',
                                        maxLines: 1,
                                        style: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmallFamily,
                                              color: valueOrDefault<Color>(
                                                widget!.pageNum == 1.0
                                                    ? FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText
                                                    : FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                              ),
                                              fontSize: 10.0,
                                              letterSpacing: 0.0,
                                              lineHeight: 1.4,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .labelSmallIsCustom,
                                            ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      Expanded(
                        child: Builder(
                          builder: (context) {
                            if (widget!.pageNum == 2.0) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(99.0),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 12.0,
                                    sigmaY: 12.0,
                                  ),
                                  child: Container(
                                    height: 54.0,
                                    constraints: BoxConstraints(
                                      minWidth: 70.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).white12,
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .white12,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          FFIcons.klessonOn,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 28.0,
                                        ),
                                        AutoSizeText(
                                          'Обучение',
                                          maxLines: 1,
                                          style: FlutterFlowTheme.of(context)
                                              .labelSmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmallFamily,
                                                color: valueOrDefault<Color>(
                                                  widget!.pageNum == 1.0
                                                      ? FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryText,
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                                ),
                                                fontSize: 10.0,
                                                letterSpacing: 0.0,
                                                lineHeight: 1.4,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .labelSmallIsCustom,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  logFirebaseEvent(
                                      'NAVBAR_COPY_COMP_Column_us5c0grr_ON_TAP');
                                  logFirebaseEvent('Column_haptic_feedback');
                                  HapticFeedback.mediumImpact();
                                  if (widget!.pageNum != 2.0) {
                                    logFirebaseEvent('Column_navigate_to');

                                    context.pushNamed(
                                      EducationPageWidget.routeName,
                                      extra: <String, dynamic>{
                                        '__transition_info__': TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.fade,
                                          duration: Duration(milliseconds: 0),
                                        ),
                                      },
                                    );
                                  }
                                  logFirebaseEvent('Column_custom_action');
                                  unawaited(
                                    () async {
                                      await actions.closeKeyboard(
                                        context,
                                      );
                                    }(),
                                  );
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      FFIcons.klessonOn,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 28.0,
                                    ),
                                    AutoSizeText(
                                      'Обучение',
                                      maxLines: 1,
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmallFamily,
                                            color: valueOrDefault<Color>(
                                              widget!.pageNum == 1.0
                                                  ? FlutterFlowTheme.of(context)
                                                      .primaryText
                                                  : FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                            ),
                                            fontSize: 10.0,
                                            letterSpacing: 0.0,
                                            lineHeight: 1.4,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .labelSmallIsCustom,
                                          ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      Expanded(
                        child: Builder(
                          builder: (context) {
                            if (widget!.pageNum == 3.0) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(99.0),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 12.0,
                                    sigmaY: 12.0,
                                  ),
                                  child: Container(
                                    height: 54.0,
                                    constraints: BoxConstraints(
                                      minWidth: 70.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).white12,
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .white12,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          FFIcons.kchatIcon,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 28.0,
                                        ),
                                        AutoSizeText(
                                          'Чат',
                                          maxLines: 1,
                                          style: FlutterFlowTheme.of(context)
                                              .labelSmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmallFamily,
                                                color: valueOrDefault<Color>(
                                                  widget!.pageNum == 1.0
                                                      ? FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryText,
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                                ),
                                                fontSize: 10.0,
                                                letterSpacing: 0.0,
                                                lineHeight: 1.4,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .labelSmallIsCustom,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  logFirebaseEvent(
                                      'NAVBAR_COPY_COMP_Column_myqk1ucy_ON_TAP');
                                  logFirebaseEvent('Column_haptic_feedback');
                                  HapticFeedback.mediumImpact();
                                  if (widget!.pageNum != 3.0) {
                                    logFirebaseEvent('Column_update_app_state');
                                    FFAppState().chatRef = null;
                                    _model.updatePage(() {});
                                    logFirebaseEvent('Column_navigate_to');

                                    context.pushNamed(
                                      ChatPageWidget.routeName,
                                      queryParameters: {
                                        'chat': serializeParam(
                                          FFAppState().chatRef,
                                          ParamType.DocumentReference,
                                        ),
                                      }.withoutNulls,
                                      extra: <String, dynamic>{
                                        '__transition_info__': TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.fade,
                                          duration: Duration(milliseconds: 0),
                                        ),
                                      },
                                    );
                                  }
                                  logFirebaseEvent('Column_custom_action');
                                  unawaited(
                                    () async {
                                      await actions.closeKeyboard(
                                        context,
                                      );
                                    }(),
                                  );
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      FFIcons.kchatIcon,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 28.0,
                                    ),
                                    AutoSizeText(
                                      'Чат',
                                      maxLines: 1,
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmallFamily,
                                            color: valueOrDefault<Color>(
                                              widget!.pageNum == 1.0
                                                  ? FlutterFlowTheme.of(context)
                                                      .primaryText
                                                  : FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                            ),
                                            fontSize: 10.0,
                                            letterSpacing: 0.0,
                                            lineHeight: 1.4,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .labelSmallIsCustom,
                                          ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      if (!valueOrDefault<bool>(
                        isWeb,
                        false,
                      ))
                        Expanded(
                          child: Builder(
                            builder: (context) {
                              if (widget!.pageNum == 4.0) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(99.0),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 12.0,
                                      sigmaY: 12.0,
                                    ),
                                    child: Container(
                                      height: 54.0,
                                      constraints: BoxConstraints(
                                        minWidth: 70.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .white12,
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .white12,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            FFIcons.kheadphonesOn,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 28.0,
                                          ),
                                          AutoSizeText(
                                            'Слушать',
                                            maxLines: 1,
                                            style: FlutterFlowTheme.of(context)
                                                .labelSmall
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelSmallFamily,
                                                  color: valueOrDefault<Color>(
                                                    widget!.pageNum == 1.0
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryText,
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                  ),
                                                  fontSize: 10.0,
                                                  letterSpacing: 0.0,
                                                  lineHeight: 1.4,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .labelSmallIsCustom,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'NAVBAR_COPY_COMP_Column_0hoyk1ln_ON_TAP');
                                    logFirebaseEvent('Column_haptic_feedback');
                                    HapticFeedback.mediumImpact();
                                    if (widget!.pageNum != 4.0) {
                                      logFirebaseEvent('Column_navigate_to');

                                      context.pushNamed(
                                        AudioPageWidget.routeName,
                                        extra: <String, dynamic>{
                                          '__transition_info__': TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.fade,
                                            duration: Duration(milliseconds: 0),
                                          ),
                                        },
                                      );
                                    }
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        FFIcons.kheadphonesOn,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 28.0,
                                      ),
                                      AutoSizeText(
                                        'Слушать',
                                        maxLines: 1,
                                        style: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmallFamily,
                                              color: valueOrDefault<Color>(
                                                widget!.pageNum == 1.0
                                                    ? FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText
                                                    : FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                              ),
                                              fontSize: 10.0,
                                              letterSpacing: 0.0,
                                              lineHeight: 1.4,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .labelSmallIsCustom,
                                            ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      Expanded(
                        flex: 1,
                        child: Builder(
                          builder: (context) {
                            if (widget!.pageNum == 5.0) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(99.0),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 12.0,
                                    sigmaY: 12.0,
                                  ),
                                  child: Container(
                                    height: 54.0,
                                    constraints: BoxConstraints(
                                      minWidth: 70.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).white12,
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .white12,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          FFIcons.kuserOn,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 28.0,
                                        ),
                                        AutoSizeText(
                                          'Профиль',
                                          maxLines: 1,
                                          style: FlutterFlowTheme.of(context)
                                              .labelSmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmallFamily,
                                                color: valueOrDefault<Color>(
                                                  widget!.pageNum == 1.0
                                                      ? FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryText,
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                                ),
                                                fontSize: 10.0,
                                                letterSpacing: 0.0,
                                                lineHeight: 1.4,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .labelSmallIsCustom,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  logFirebaseEvent(
                                      'NAVBAR_COPY_COMP_Column_p48crnst_ON_TAP');
                                  logFirebaseEvent('Column_haptic_feedback');
                                  HapticFeedback.mediumImpact();
                                  if (widget!.pageNum != 5.0) {
                                    logFirebaseEvent('Column_navigate_to');

                                    context.pushNamed(
                                      ProfilePageWidget.routeName,
                                      extra: <String, dynamic>{
                                        '__transition_info__': TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.fade,
                                          duration: Duration(milliseconds: 0),
                                        ),
                                      },
                                    );
                                  }
                                  logFirebaseEvent('Column_custom_action');
                                  unawaited(
                                    () async {
                                      await actions.closeKeyboard(
                                        context,
                                      );
                                    }(),
                                  );
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      FFIcons.kuserOn,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 28.0,
                                    ),
                                    AutoSizeText(
                                      'Профиль',
                                      maxLines: 1,
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmallFamily,
                                            color: valueOrDefault<Color>(
                                              widget!.pageNum == 1.0
                                                  ? FlutterFlowTheme.of(context)
                                                      .primaryText
                                                  : FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                            ),
                                            fontSize: 10.0,
                                            letterSpacing: 0.0,
                                            lineHeight: 1.4,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .labelSmallIsCustom,
                                          ),
                                    ),
                                  ],
                                ),
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
          ),
        ),
      ),
    );
  }
}
