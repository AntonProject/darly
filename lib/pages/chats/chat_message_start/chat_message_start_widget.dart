import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/chats/chat_dialog/chat_dialog_widget.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'chat_message_start_model.dart';
export 'chat_message_start_model.dart';

class ChatMessageStartWidget extends StatefulWidget {
  const ChatMessageStartWidget({super.key});

  @override
  State<ChatMessageStartWidget> createState() => _ChatMessageStartWidgetState();
}

class _ChatMessageStartWidgetState extends State<ChatMessageStartWidget> {
  late ChatMessageStartModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatMessageStartModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 800.0,
      ),
      decoration: BoxDecoration(),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 60.0, 0.0, 0.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0.0),
                child: Image.asset(
                  'assets/images/logo34.webp',
                  height: MediaQuery.sizeOf(context).height * 0.37,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
              child: AuthUserStreamWidget(
                builder: (context) => Text(
                  valueOrDefault<String>(
                    'ПРИВЕТ${currentUserDisplayName != null && currentUserDisplayName != '' ? ', ${currentUserDisplayName}!' : '!'}',
                    'Привет',
                  ).toUpperCase(),
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).headlineMediumFamily,
                        letterSpacing: 0.0,
                        lineHeight: 1.0,
                        useGoogleFonts: !FlutterFlowTheme.of(context)
                            .headlineMediumIsCustom,
                      ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 16.0),
              child: Text(
                'Я твой персональный ассистент — Дарли!',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).labelLarge.override(
                      fontFamily: FlutterFlowTheme.of(context).labelLargeFamily,
                      letterSpacing: 0.0,
                      lineHeight: 1.4,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).labelLargeIsCustom,
                    ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(56.0),
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
                        'CHAT_MESSAGE_START_Container_3jxaptw9_ON');
                    logFirebaseEvent('Container_bottom_sheet');
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return WebViewAware(
                          child: Padding(
                            padding: MediaQuery.viewInsetsOf(context),
                            child: ChatDialogWidget(),
                          ),
                        );
                      },
                    ).then((value) => safeSetState(() {}));
                  },
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: 40.0,
                    ),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).white24,
                      borderRadius: BorderRadius.circular(56.0),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).white12,
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            FFIcons.kinfo,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                          Text(
                            'ЧТО Я УМЕЮ',
                            style: FlutterFlowTheme.of(context)
                                .titleLarge
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .titleLargeFamily,
                                  fontSize: 17.0,
                                  letterSpacing: 0.0,
                                  lineHeight: 1.25,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .titleLargeIsCustom,
                                ),
                          ),
                        ].divide(SizedBox(width: 4.0)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
