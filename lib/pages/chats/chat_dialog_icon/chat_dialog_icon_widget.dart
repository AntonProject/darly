import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'chat_dialog_icon_model.dart';
export 'chat_dialog_icon_model.dart';

class ChatDialogIconWidget extends StatefulWidget {
  const ChatDialogIconWidget({super.key});

  @override
  State<ChatDialogIconWidget> createState() => _ChatDialogIconWidgetState();
}

class _ChatDialogIconWidgetState extends State<ChatDialogIconWidget> {
  late ChatDialogIconModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatDialogIconModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        logFirebaseEvent('CHAT_DIALOG_ICON_Column_aqm82nec_ON_TAP');
        logFirebaseEvent('Column_bottom_sheet');
        Navigator.pop(context);
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 48.0, 0.0, 8.0),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                logFirebaseEvent('CHAT_DIALOG_ICON_Container_g7yb8wy4_ON_T');
                logFirebaseEvent('Container_haptic_feedback');
                HapticFeedback.mediumImpact();
                logFirebaseEvent('Container_bottom_sheet');
                Navigator.pop(context);
              },
              child: Container(
                width: 48.0,
                height: 6.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).accent2,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0.0, 1.0),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.0),
                topRight: Radius.circular(32.0),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 24.0,
                  sigmaY: 24.0,
                ),
                child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    maxWidth: 600.0,
                    maxHeight: MediaQuery.sizeOf(context).height * 0.9,
                  ),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).dialog,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(1.0, -1.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 16.0, 0.0),
                                child: Container(
                                  width: 32.0,
                                  height: 0.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-1.0, 0.0),
                              child: Text(
                                'ВАЖНО❤️',
                                maxLines: 3,
                                style: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .titleMediumFamily,
                                      fontSize: 17.0,
                                      letterSpacing: 0.0,
                                      lineHeight: 1.2,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .titleMediumIsCustom,
                                    ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(1.0, -1.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 16.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'CHAT_DIALOG_ICON_Container_pls8p1tq_ON_T');
                                    logFirebaseEvent('Container_bottom_sheet');
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: valueOrDefault<double>(
                                      () {
                                        if (MediaQuery.sizeOf(context).width <
                                            kBreakpointSmall) {
                                          return 32.0;
                                        } else if (MediaQuery.sizeOf(context)
                                                .width <
                                            kBreakpointMedium) {
                                          return 32.0;
                                        } else if (MediaQuery.sizeOf(context)
                                                .width <
                                            kBreakpointLarge) {
                                          return 48.0;
                                        } else {
                                          return 48.0;
                                        }
                                      }(),
                                      48.0,
                                    ),
                                    height: valueOrDefault<double>(
                                      () {
                                        if (MediaQuery.sizeOf(context).width <
                                            kBreakpointSmall) {
                                          return 32.0;
                                        } else if (MediaQuery.sizeOf(context)
                                                .width <
                                            kBreakpointMedium) {
                                          return 32.0;
                                        } else if (MediaQuery.sizeOf(context)
                                                .width <
                                            kBreakpointLarge) {
                                          return 48.0;
                                        } else {
                                          return 48.0;
                                        }
                                      }(),
                                      48.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).white24,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    child: Icon(
                                      FFIcons.kcloseIcon,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: valueOrDefault<double>(
                                        () {
                                          if (MediaQuery.sizeOf(context).width <
                                              kBreakpointSmall) {
                                            return 24.0;
                                          } else if (MediaQuery.sizeOf(context)
                                                  .width <
                                              kBreakpointMedium) {
                                            return 24.0;
                                          } else if (MediaQuery.sizeOf(context)
                                                  .width <
                                              kBreakpointLarge) {
                                            return 32.0;
                                          } else {
                                            return 32.0;
                                          }
                                        }(),
                                        32.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 24.0),
                          child: Text(
                            ' Я не даю медицинских и юридических рекомендаций 🙏\n Я не ставлю диагнозы, не назначаю лечение и не заменяю консультацию врача.\n\nТакже я не отвечаю на вопросы, связанные с:\n- здоровьем и симптомами заболеваний\n приемом лекарств и лечением\n- юридическими вопросами и законами\n финансовыми и инвестиционными рекомендациями\n- любыми опасными или запрещенными темами\n\nЕсли тебе нужна помощь в этих сферах, то лучше обратиться к профильному специалисту 🤍\n',
                            style: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyLargeFamily,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  fontSize: 17.0,
                                  letterSpacing: 0.0,
                                  lineHeight: 1.4,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .bodyLargeIsCustom,
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 12.0, 20.0, 48.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(56.0),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 12.0,
                              sigmaY: 12.0,
                            ),
                            child: FFButtonWidget(
                              onPressed: () async {
                                logFirebaseEvent(
                                    'CHAT_DIALOG_ICON_cancelButton_ON_TAP');
                                logFirebaseEvent(
                                    'cancelButton_haptic_feedback');
                                HapticFeedback.mediumImpact();
                                logFirebaseEvent('cancelButton_bottom_sheet');
                                Navigator.pop(context);
                              },
                              text: 'ЗАКРЫТЬ',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 56.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).accent1,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
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
                                  color: FlutterFlowTheme.of(context).white12,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(56.0),
                              ),
                              showLoadingIndicator: false,
                            ),
                          ),
                        ),
                      ),
                    ].addToStart(SizedBox(height: 28.0)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
