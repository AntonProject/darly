import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/dialogs/notification_dialog/notification_dialog_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'notif_comp_model.dart';
export 'notif_comp_model.dart';

class NotifCompWidget extends StatefulWidget {
  const NotifCompWidget({
    super.key,
    required this.notifComp,
  });

  final NotificationsRecord? notifComp;

  @override
  State<NotifCompWidget> createState() => _NotifCompWidgetState();
}

class _NotifCompWidgetState extends State<NotifCompWidget> {
  late NotifCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotifCompModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
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
            logFirebaseEvent('NOTIF_Container_v07qxw28_ON_TAP');
            logFirebaseEvent('Container_haptic_feedback');
            HapticFeedback.lightImpact();
            logFirebaseEvent('Container_bottom_sheet');
            showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              useSafeArea: true,
              context: context,
              builder: (context) {
                return WebViewAware(
                  child: Padding(
                    padding: MediaQuery.viewInsetsOf(context),
                    child: NotificationDialogWidget(
                      notifComp: widget!.notifComp!,
                    ),
                  ),
                );
              },
            ).then((value) => safeSetState(() {}));
          },
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(
              maxWidth: 600.0,
            ),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).white12,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional(1.0, -1.0),
                        children: [
                          Icon(
                            FFIcons.knotif,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                          if (!valueOrDefault<bool>(
                            widget!.notifComp?.readingUsers
                                ?.contains(currentUserUid),
                            false,
                          ))
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 2.0, 0.0),
                              child: Container(
                                width: 8.0,
                                height: 8.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).primary,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: FlutterFlowTheme.of(context).primary,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      Expanded(
                        child: Text(
                          widget!.notifComp!.title.maybeHandleOverflow(
                            maxChars: 50,
                            replacement: '…',
                          ),
                          maxLines: 1,
                          style: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleMediumFamily,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .titleMediumIsCustom,
                              ),
                        ),
                      ),
                      Icon(
                        FFIcons.kright3,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 24.0,
                      ),
                    ].divide(SizedBox(width: 8.0)),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(32.0, 4.0, 0.0, 0.0),
                      child: Text(
                        widget!.notifComp!.text.maybeHandleOverflow(
                          maxChars: 300,
                          replacement: '…',
                        ),
                        maxLines: 3,
                        style:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelMediumFamily,
                                  fontSize: 13.0,
                                  letterSpacing: 0.0,
                                  lineHeight: 1.4,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelMediumIsCustom,
                                ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
