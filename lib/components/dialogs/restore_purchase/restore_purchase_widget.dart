import '/auth/firebase_auth/auth_util.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/backend/schema/structs/index.dart';
import '/components/loader/loader_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'restore_purchase_model.dart';
export 'restore_purchase_model.dart';

class RestorePurchaseWidget extends StatefulWidget {
  const RestorePurchaseWidget({super.key});

  @override
  State<RestorePurchaseWidget> createState() => _RestorePurchaseWidgetState();
}

class _RestorePurchaseWidgetState extends State<RestorePurchaseWidget> {
  late RestorePurchaseModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RestorePurchaseModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('RESTORE_PURCHASE_restorePurchase_ON_INIT');
      logFirebaseEvent('restorePurchase_cloud_function');
      try {
        final result =
            await FirebaseFunctions.instanceFor(region: 'europe-west6')
                .httpsCallable('restorePurchase')
                .call({
          "userId": currentUserUid,
          "subsId": valueOrDefault(currentUserDocument?.subscriptionId, ''),
        });
        _model.restore = RestorePurchaseCloudFunctionCallResponse(
          data: result.data,
          succeeded: true,
          resultAsString: result.data.toString(),
          jsonBody: result.data,
        );
      } on FirebaseFunctionsException catch (error) {
        _model.restore = RestorePurchaseCloudFunctionCallResponse(
          errorCode: error.code,
          succeeded: false,
        );
      }

      if (_model.restore!.succeeded!) {
        if (_model.restore?.data == true) {
          logFirebaseEvent('restorePurchase_update_component_state');
          _model.result = 'success';
          safeSetState(() {});
          logFirebaseEvent('restorePurchase_haptic_feedback');
          HapticFeedback.lightImpact();
        } else {
          logFirebaseEvent('restorePurchase_update_component_state');
          _model.result = 'error';
          safeSetState(() {});
          logFirebaseEvent('restorePurchase_haptic_feedback');
          HapticFeedback.vibrate();
        }
      } else {
        logFirebaseEvent('restorePurchase_update_component_state');
        _model.result = 'error';
        safeSetState(() {});
        logFirebaseEvent('restorePurchase_haptic_feedback');
        HapticFeedback.vibrate();
      }

      logFirebaseEvent('restorePurchase_wait__delay');
      await Future.delayed(
        Duration(
          milliseconds: 1500,
        ),
      );
      logFirebaseEvent('restorePurchase_bottom_sheet');
      Navigator.pop(context);
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
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Builder(
        builder: (context) {
          if (_model.result == 'error') {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  FFIcons.kcloseIcon,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 64.0,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
                  child: Text(
                    'НЕ НАШЛИ ПОКУПОК',
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).headlineSmallFamily,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          lineHeight: 1.2,
                          useGoogleFonts: !FlutterFlowTheme.of(context)
                              .headlineSmallIsCustom,
                        ),
                  ),
                ),
              ],
            );
          } else if (_model.result == 'success') {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_outlined,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 64.0,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
                  child: Text(
                    'ПОКУПКИ ВОССТАНОВЛЕНЫ',
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).headlineSmallFamily,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          lineHeight: 1.2,
                          useGoogleFonts: !FlutterFlowTheme.of(context)
                              .headlineSmallIsCustom,
                        ),
                  ),
                ),
              ],
            );
          } else {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                wrapWithModel(
                  model: _model.loaderModel,
                  updateCallback: () => safeSetState(() {}),
                  updateOnChange: true,
                  child: LoaderWidget(
                    size: 64.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
                  child: Text(
                    'ДАЙТЕ НАМ ПАРУ СЕКУНД',
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).headlineSmallFamily,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          lineHeight: 1.2,
                          useGoogleFonts: !FlutterFlowTheme.of(context)
                              .headlineSmallIsCustom,
                        ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
