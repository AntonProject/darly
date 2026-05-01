import '/backend/backend.dart';
import '/components/back_button/back_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'meta_card_select_page_model.dart';
export 'meta_card_select_page_model.dart';

class MetaCardSelectPageWidget extends StatefulWidget {
  const MetaCardSelectPageWidget({
    super.key,
    required this.cards,
  });

  final List<MetaCardsRecord>? cards;

  static String routeName = 'MetaCardSelectPage';
  static String routePath = '/metaCardSelectPage';

  @override
  State<MetaCardSelectPageWidget> createState() =>
      _MetaCardSelectPageWidgetState();
}

class _MetaCardSelectPageWidgetState extends State<MetaCardSelectPageWidget> {
  late MetaCardSelectPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MetaCardSelectPageModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'MetaCardSelectPage'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('META_CARD_SELECT_MetaCardSelectPage_ON_I');
      logFirebaseEvent('MetaCardSelectPage_custom_action');
      unawaited(
        () async {
          await actions.setStatusBarColor();
        }(),
      );
      logFirebaseEvent('MetaCardSelectPage_custom_action');
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
        title: 'MetaCardSelectPage',
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
              child: Container(
                width: double.infinity,
                height: double.infinity,
                constraints: BoxConstraints(
                  maxWidth: 600.0,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: Image.asset(
                      'assets/images/Background.webp',
                    ).image,
                  ),
                ),
                child: Container(
                  height: MediaQuery.sizeOf(context).height * 1.0,
                  child: Stack(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.sizeOf(context).height * 1.0,
                        child: custom_widgets.MessageLetterWidget(
                          width: double.infinity,
                          height: MediaQuery.sizeOf(context).height * 1.0,
                          animationDuration: 1800,
                          staggerDelay: 50,
                          topOffset: 200.0,
                          metaCards: widget!.cards!,
                          image:
                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/woman-103qa6/assets/4h5xqbhg7mj2/cardFront.webp',
                          onCardTap: (card) async {
                            logFirebaseEvent(
                                'META_CARD_SELECT_Container_5ul15hnu_CALL');
                            logFirebaseEvent('MessageLetterWidget_navigate_to');
                            if (Navigator.of(context).canPop()) {
                              context.pop();
                            }
                            context.pushNamed(
                              MetaCardPageWidget.routeName,
                              queryParameters: {
                                'metaCard': serializeParam(
                                  card,
                                  ParamType.Document,
                                ),
                              }.withoutNulls,
                              extra: <String, dynamic>{
                                'metaCard': card,
                              },
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, -1.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 54.0, 0.0, 5.0),
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
                                          'META_CARD_SELECT_Container_phir7o9h_CALL');
                                      logFirebaseEvent(
                                          'backButton_navigate_back');
                                      context.safePop();
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 16.0, 0.0, 0.0),
                              child: Text(
                                'ВЫБЕРИ КАРТУ',
                                style: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .headlineMediumFamily,
                                      letterSpacing: 0.0,
                                      lineHeight: 1.2,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .headlineMediumIsCustom,
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
            ),
          ),
        ));
  }
}
