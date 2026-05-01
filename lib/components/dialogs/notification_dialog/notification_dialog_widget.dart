import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'notification_dialog_model.dart';
export 'notification_dialog_model.dart';

class NotificationDialogWidget extends StatefulWidget {
  const NotificationDialogWidget({
    super.key,
    required this.notifComp,
  });

  final NotificationsRecord? notifComp;

  @override
  State<NotificationDialogWidget> createState() =>
      _NotificationDialogWidgetState();
}

class _NotificationDialogWidgetState extends State<NotificationDialogWidget> {
  late NotificationDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotificationDialogModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('NOTIFICATION_DIALOG_NotificationDialog_O');
      if (!widget!.notifComp!.readingUsers.contains(currentUserUid)) {
        logFirebaseEvent('NotificationDialog_backend_call');
        unawaited(
          () async {
            await widget!.notifComp!.reference.update({
              ...mapToFirestore(
                {
                  'readingUsers': FieldValue.arrayUnion([currentUserUid]),
                },
              ),
            });
          }(),
        );
      }
    });

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
        logFirebaseEvent('NOTIFICATION_DIALOG_Column_3m270nr2_ON_T');
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
                logFirebaseEvent('NOTIFICATION_DIALOG_Container_e34i35n2_O');
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
          Flexible(
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
                    minHeight: MediaQuery.sizeOf(context).height * 0.4,
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
                  child: Stack(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(1.0, -1.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 16.0, 0.0),
                              child: ClipOval(
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
                                          'NOTIFICATION_DIALOG_Container_66ublyj9_O');
                                      logFirebaseEvent(
                                          'Container_bottom_sheet');
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
                                        color: FlutterFlowTheme.of(context)
                                            .white24,
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
                                            if (MediaQuery.sizeOf(context)
                                                    .width <
                                                kBreakpointSmall) {
                                              return 24.0;
                                            } else if (MediaQuery.sizeOf(
                                                        context)
                                                    .width <
                                                kBreakpointMedium) {
                                              return 24.0;
                                            } else if (MediaQuery.sizeOf(
                                                        context)
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
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 0.0, 20.0, 0.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    if (widget!.notifComp?.image != null &&
                                        widget!.notifComp?.image != '')
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 16.0),
                                        child: Container(
                                          width: double.infinity,
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.4,
                                          child: custom_widgets.MaskedImage(
                                            width: double.infinity,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.4,
                                            imageUrl: widget!.notifComp?.image,
                                            topRadius: 20.0,
                                          ),
                                        ),
                                      ),
                                    if (widget!.notifComp?.title != null &&
                                        widget!.notifComp?.title != '')
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, 0.0),
                                        child: Text(
                                          widget!.notifComp!.title
                                              .maybeHandleOverflow(
                                            maxChars: 150,
                                            replacement: '…',
                                          ),
                                          maxLines: 3,
                                          style: FlutterFlowTheme.of(context)
                                              .headlineSmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineSmallFamily,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                                lineHeight: 1.2,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .headlineSmallIsCustom,
                                              ),
                                        ),
                                      ),
                                    if (widget!.notifComp?.text != null &&
                                        widget!.notifComp?.text != '')
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, 0.0),
                                        child: Text(
                                          widget!.notifComp!.text,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLargeFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                fontSize: 17.0,
                                                letterSpacing: 0.0,
                                                lineHeight: 1.4,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyLargeIsCustom,
                                              ),
                                        ),
                                      ),
                                  ]
                                      .addToStart(SizedBox(height: 16.0))
                                      .addToEnd(SizedBox(height: 150.0)),
                                ),
                              ),
                            ),
                          ),
                        ].addToStart(SizedBox(height: 28.0)),
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
                                    'NOTIFICATION_DIALOG_cancelButton_ON_TAP');
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
                    ],
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
