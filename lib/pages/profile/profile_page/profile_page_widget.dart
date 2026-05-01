import '/auth/firebase_auth/auth_util.dart';
import '/components/dialogs/restore_purchase/restore_purchase_widget.dart';
import '/components/navbar/navbar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/payment/premium/premium_widget.dart';
import '/web/navbar_web/navbar_web_widget.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'profile_page_model.dart';
export 'profile_page_model.dart';

class ProfilePageWidget extends StatefulWidget {
  const ProfilePageWidget({super.key});

  static String routeName = 'ProfilePage';
  static String routePath = '/profilePage';

  @override
  State<ProfilePageWidget> createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget> {
  late ProfilePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfilePageModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'ProfilePage'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('PROFILE_ProfilePage_ON_INIT_STATE');
      logFirebaseEvent('ProfilePage_custom_action');
      unawaited(
        () async {
          await actions.closeKeyboard(
            context,
          );
        }(),
      );
      logFirebaseEvent('ProfilePage_custom_action');
      unawaited(
        () async {
          await actions.setStatusBarColor();
        }(),
      );
      logFirebaseEvent('ProfilePage_custom_action');
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
        title: 'ProfilePage',
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
              height: MediaQuery.sizeOf(context).height * 1.0,
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
                            pageNum: 0.0,
                          ),
                        ),
                      Expanded(
                        child: Align(
                          alignment: AlignmentDirectional(0.0, -1.0),
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: 600.0,
                            ),
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 0.0, 20.0, 0.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(99.0),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                          sigmaX: 12.0,
                                          sigmaY: 12.0,
                                        ),
                                        child: Container(
                                          width: 156.0,
                                          height: 294.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .white12,
                                            borderRadius:
                                                BorderRadius.circular(99.0),
                                            border: Border.all(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .white12,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 8.0, 0.0, 0.0),
                                                child: Container(
                                                  width: 140.0,
                                                  height: 140.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .white12,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .white12,
                                                    ),
                                                  ),
                                                  child: Builder(
                                                    builder: (context) {
                                                      if (currentUserPhoto !=
                                                              null &&
                                                          currentUserPhoto !=
                                                              '') {
                                                        return Container(
                                                          width: 140.0,
                                                          height: 140.0,
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child:
                                                              CachedNetworkImage(
                                                            fadeInDuration:
                                                                Duration(
                                                                    milliseconds:
                                                                        500),
                                                            fadeOutDuration:
                                                                Duration(
                                                                    milliseconds:
                                                                        500),
                                                            imageUrl:
                                                                getCORSProxyUrl(
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
                                                          child:
                                                              AuthUserStreamWidget(
                                                            builder:
                                                                (context) =>
                                                                    Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                functions.nameLettters(
                                                                    currentUserDisplayName,
                                                                    valueOrDefault(
                                                                        currentUserDocument
                                                                            ?.surname,
                                                                        '')),
                                                                'WN',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineLarge
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .headlineLargeFamily,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    lineHeight:
                                                                        1.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .headlineLargeIsCustom,
                                                                  ),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 16.0, 0.0, 0.0),
                                                child: AutoSizeText(
                                                  currentUserEmail,
                                                  maxLines: 1,
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumFamily,
                                                            fontSize: 13.0,
                                                            letterSpacing: 0.0,
                                                            lineHeight: 1.25,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumIsCustom,
                                                          ),
                                                  overflow: TextOverflow.fade,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 4.0, 0.0, 0.0),
                                                child: AuthUserStreamWidget(
                                                  builder: (context) =>
                                                      AutoSizeText(
                                                    valueOrDefault<String>(
                                                      functions.nameHome(
                                                          currentUserDisplayName,
                                                          valueOrDefault(
                                                              currentUserDocument
                                                                  ?.surname,
                                                              '')),
                                                      ' Unnamed',
                                                    ),
                                                    maxLines: 1,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .titleMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleMediumFamily,
                                                          fontSize: 20.0,
                                                          letterSpacing: 0.0,
                                                          lineHeight: 1.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleMediumIsCustom,
                                                        ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 16.0, 0.0, 16.0),
                                                child: FlutterFlowIconButton(
                                                  borderRadius: 99.0,
                                                  buttonSize: 56.0,
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                  icon: Icon(
                                                    FFIcons.keditIcon,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    size: 24.0,
                                                  ),
                                                  onPressed: () async {
                                                    logFirebaseEvent(
                                                        'PROFILE_PAGE_PAGE_editIcon_ICN_ON_TAP');
                                                    logFirebaseEvent(
                                                        'IconButton_haptic_feedback');
                                                    HapticFeedback
                                                        .mediumImpact();
                                                    logFirebaseEvent(
                                                        'IconButton_navigate_to');

                                                    context.pushNamed(
                                                        ProfileEditPageWidget
                                                            .routeName);
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
                                          0.0, 16.0, 0.0, 0.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                            sigmaX: 12.0,
                                            sigmaY: 12.0,
                                          ),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              logFirebaseEvent(
                                                  'PROFILE_Container_loevhawo_ON_TAP');
                                              logFirebaseEvent(
                                                  'Container_haptic_feedback');
                                              HapticFeedback.lightImpact();
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              constraints: BoxConstraints(
                                                minHeight: 82.0,
                                              ),
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .white12,
                                                borderRadius:
                                                    BorderRadius.circular(32.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .white12,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 0.0, 16.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      FFIcons.klock2,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      size: 28.0,
                                                    ),
                                                    Text(
                                                      'Тут скоро будет статистика',
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
                                                            lineHeight: 1.25,
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
                                            ),
                                          ),
                                        ),
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
                                            0.0, 16.0, 0.0, 0.0),
                                        child: AuthUserStreamWidget(
                                          builder: (context) => wrapWithModel(
                                            model: _model.premiumModel,
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            child: PremiumWidget(),
                                          ),
                                        ),
                                      ),
                                    if (() {
                                      if (isiOS) {
                                        return (!valueOrDefault<bool>(
                                              functions.checkVersionReview(
                                                  FFAppState().version,
                                                  getRemoteConfigString(
                                                      'appleReviewVersion')),
                                              false,
                                            ) &&
                                            valueOrDefault<bool>(
                                              functions.dateGreatherThanToday(
                                                  currentUserDocument
                                                      ?.subscriptionExpDate),
                                              false,
                                            ));
                                      } else if (isAndroid) {
                                        return (!valueOrDefault<bool>(
                                              functions.checkVersionReview(
                                                  FFAppState().version,
                                                  getRemoteConfigString(
                                                      'googleReviewVersion')),
                                              false,
                                            ) &&
                                            valueOrDefault<bool>(
                                              functions.dateGreatherThanToday(
                                                  currentUserDocument
                                                      ?.subscriptionExpDate),
                                              false,
                                            ));
                                      } else {
                                        return valueOrDefault<bool>(
                                          functions.dateGreatherThanToday(
                                              currentUserDocument
                                                  ?.subscriptionExpDate),
                                          false,
                                        );
                                      }
                                    }())
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 16.0, 0.0, 0.0),
                                        child: AuthUserStreamWidget(
                                          builder: (context) => ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                            child: BackdropFilter(
                                              filter: ImageFilter.blur(
                                                sigmaX: 12.0,
                                                sigmaY: 12.0,
                                              ),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  logFirebaseEvent(
                                                      'PROFILE_Container_y15zxd4s_ON_TAP');
                                                  logFirebaseEvent(
                                                      'Container_launch_u_r_l');
                                                  unawaited(
                                                    () async {
                                                      await launchURL(
                                                          FFAppConstants
                                                              .cloudCabinet);
                                                    }(),
                                                  );
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 58.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .white12,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            32.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .white12,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 0.0,
                                                                16.0, 0.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Icon(
                                                          FFIcons.kaward,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          size: 24.0,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            'Управление подпиской',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .titleMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMediumFamily,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  lineHeight:
                                                                      1.25,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleMediumIsCustom,
                                                                ),
                                                          ),
                                                        ),
                                                        Icon(
                                                          FFIcons.kright3,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          size: 24.0,
                                                        ),
                                                      ].divide(SizedBox(
                                                          width: 12.0)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 16.0, 0.0, 0.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                            sigmaX: 12.0,
                                            sigmaY: 12.0,
                                          ),
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .white12,
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .white12,
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(16.0),
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
                                                          'PROFILE_PAGE_PAGE_Row_6v0s00x4_ON_TAP');
                                                      logFirebaseEvent(
                                                          'Row_haptic_feedback');
                                                      HapticFeedback
                                                          .lightImpact();
                                                      logFirebaseEvent(
                                                          'Row_launch_u_r_l');
                                                      unawaited(
                                                        () async {
                                                          await launchURL(
                                                              getRemoteConfigString(
                                                                  'teamUrl'));
                                                        }(),
                                                      );
                                                    },
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Icon(
                                                          FFIcons.kiconTeam,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          size: 24.0,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            'Сообщество',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .titleMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMediumFamily,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  lineHeight:
                                                                      1.25,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleMediumIsCustom,
                                                                ),
                                                          ),
                                                        ),
                                                        Icon(
                                                          FFIcons.kright3,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          size: 24.0,
                                                        ),
                                                      ].divide(SizedBox(
                                                          width: 12.0)),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(16.0),
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
                                                          'PROFILE_PAGE_PAGE_Row_9wf2b36u_ON_TAP');
                                                      logFirebaseEvent(
                                                          'Row_haptic_feedback');
                                                      HapticFeedback
                                                          .lightImpact();
                                                      logFirebaseEvent(
                                                          'Row_navigate_to');

                                                      context.pushNamed(
                                                          SupportPageWidget
                                                              .routeName);
                                                    },
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Icon(
                                                          FFIcons
                                                              .kheadphonesOff,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          size: 24.0,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            'Служба заботы',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .titleMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMediumFamily,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  lineHeight:
                                                                      1.25,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleMediumIsCustom,
                                                                ),
                                                          ),
                                                        ),
                                                        Icon(
                                                          FFIcons.kright3,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          size: 24.0,
                                                        ),
                                                      ].divide(SizedBox(
                                                          width: 12.0)),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(16.0),
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
                                                          'PROFILE_PAGE_PAGE_Row_k5d721bx_ON_TAP');
                                                      logFirebaseEvent(
                                                          'Row_haptic_feedback');
                                                      HapticFeedback
                                                          .lightImpact();
                                                      logFirebaseEvent(
                                                          'Row_navigate_to');

                                                      context.pushNamed(
                                                          AboutAppPageWidget
                                                              .routeName);
                                                    },
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Icon(
                                                          FFIcons.kinfo,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          size: 24.0,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            'О приложении',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .titleMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMediumFamily,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  lineHeight:
                                                                      1.25,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleMediumIsCustom,
                                                                ),
                                                          ),
                                                        ),
                                                        Icon(
                                                          FFIcons.kright3,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          size: 24.0,
                                                        ),
                                                      ].divide(SizedBox(
                                                          width: 12.0)),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(16.0),
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
                                                          'PROFILE_PAGE_PAGE_Row_bxbcr5zz_ON_TAP');
                                                      logFirebaseEvent(
                                                          'Row_haptic_feedback');
                                                      HapticFeedback
                                                          .lightImpact();
                                                      logFirebaseEvent(
                                                          'Row_custom_action');
                                                      unawaited(
                                                        () async {
                                                          await actions
                                                              .openStoreListing();
                                                        }(),
                                                      );
                                                    },
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Icon(
                                                          FFIcons.kstar,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          size: 24.0,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            'Оценить приложение',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .titleMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMediumFamily,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  lineHeight:
                                                                      1.25,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleMediumIsCustom,
                                                                ),
                                                          ),
                                                        ),
                                                        Icon(
                                                          FFIcons.kright3,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          size: 24.0,
                                                        ),
                                                      ].divide(SizedBox(
                                                          width: 12.0)),
                                                    ),
                                                  ),
                                                ),
                                                if (valueOrDefault<bool>(
                                                  (isiOS &&
                                                          !valueOrDefault<bool>(
                                                            functions.checkVersionReview(
                                                                FFAppState()
                                                                    .version,
                                                                getRemoteConfigString(
                                                                    'appleReviewVersion')),
                                                            false,
                                                          )) ||
                                                      (isAndroid &&
                                                          !valueOrDefault<bool>(
                                                            functions.checkVersionReview(
                                                                FFAppState()
                                                                    .version,
                                                                getRemoteConfigString(
                                                                    'googleReviewVersion')),
                                                            false,
                                                          )) ||
                                                      isWeb,
                                                  false,
                                                ))
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(16.0),
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
                                                            'PROFILE_PAGE_PAGE_Row_mhh8vzvs_ON_TAP');
                                                        logFirebaseEvent(
                                                            'Row_haptic_feedback');
                                                        HapticFeedback
                                                            .lightImpact();
                                                        logFirebaseEvent(
                                                            'Row_bottom_sheet');
                                                        showModalBottomSheet(
                                                          isScrollControlled:
                                                              true,
                                                          backgroundColor:
                                                              Color(0x56000000),
                                                          isDismissible: false,
                                                          enableDrag: false,
                                                          context: context,
                                                          builder: (context) {
                                                            return WebViewAware(
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .unfocus();
                                                                  FocusManager
                                                                      .instance
                                                                      .primaryFocus
                                                                      ?.unfocus();
                                                                },
                                                                child: Padding(
                                                                  padding: MediaQuery
                                                                      .viewInsetsOf(
                                                                          context),
                                                                  child:
                                                                      RestorePurchaseWidget(),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ).then((value) =>
                                                            safeSetState(
                                                                () {}));
                                                      },
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Icon(
                                                            FFIcons.kshop,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            size: 24.0,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              'Восстановить покупки',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleMediumFamily,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    lineHeight:
                                                                        1.25,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .titleMediumIsCustom,
                                                                  ),
                                                            ),
                                                          ),
                                                          Icon(
                                                            FFIcons.kright3,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryText,
                                                            size: 24.0,
                                                          ),
                                                        ].divide(SizedBox(
                                                            width: 12.0)),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]
                                      .addToStart(SizedBox(height: 54.0))
                                      .addToEnd(SizedBox(height: 150.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: wrapWithModel(
                      model: _model.navbarModel,
                      updateCallback: () => safeSetState(() {}),
                      child: NavbarWidget(
                        pageNum: 5.0,
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
