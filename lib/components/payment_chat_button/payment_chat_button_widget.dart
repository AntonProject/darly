import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/payment/premium_chat_dialog/premium_chat_dialog_widget.dart';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'payment_chat_button_model.dart';
export 'payment_chat_button_model.dart';

class PaymentChatButtonWidget extends StatefulWidget {
  const PaymentChatButtonWidget({super.key});

  @override
  State<PaymentChatButtonWidget> createState() =>
      _PaymentChatButtonWidgetState();
}

class _PaymentChatButtonWidgetState extends State<PaymentChatButtonWidget> {
  late PaymentChatButtonModel _model;

  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PaymentChatButtonModel());

    if (!isWeb) {
      _keyboardVisibilitySubscription =
          KeyboardVisibilityController().onChange.listen((bool visible) {
        safeSetState(() {
          _isKeyboardVisible = visible;
        });
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    if (!isWeb) {
      _keyboardVisibilitySubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(0.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 2.0,
          sigmaY: 4.0,
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
              20.0,
              0.0,
              20.0,
              valueOrDefault<double>(
                () {
                  if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                    return valueOrDefault<double>(
                      (isWeb
                              ? MediaQuery.viewInsetsOf(context).bottom > 0
                              : _isKeyboardVisible)
                          ? 12.0
                          : 120.0,
                      120.0,
                    );
                  } else if (MediaQuery.sizeOf(context).width <
                      kBreakpointMedium) {
                    return valueOrDefault<double>(
                      (isWeb
                              ? MediaQuery.viewInsetsOf(context).bottom > 0
                              : _isKeyboardVisible)
                          ? 12.0
                          : 120.0,
                      120.0,
                    );
                  } else if (MediaQuery.sizeOf(context).width <
                      kBreakpointLarge) {
                    return 24.0;
                  } else {
                    return 24.0;
                  }
                }(),
                120.0,
              )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 10.0),
                child: Text(
                  'Вы достигли лимита. 10 сообщений в день. С подпиской лимита на сообщения нет',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).labelMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).labelMediumFamily,
                        fontSize: 15.0,
                        letterSpacing: 0.0,
                        lineHeight: 1.25,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).labelMediumIsCustom,
                      ),
                ),
              ),
              FFButtonWidget(
                onPressed: () async {
                  logFirebaseEvent('PAYMENT_CHAT_BUTTON_COMP___BTN_ON_TAP');
                  logFirebaseEvent('Button_haptic_feedback');
                  HapticFeedback.mediumImpact();
                  logFirebaseEvent('Button_bottom_sheet');
                  showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    isDismissible: false,
                    enableDrag: false,
                    context: context,
                    builder: (context) {
                      return WebViewAware(
                        child: Padding(
                          padding: MediaQuery.viewInsetsOf(context),
                          child: PremiumChatDialogWidget(),
                        ),
                      );
                    },
                  ).then((value) => safeSetState(() {}));
                },
                text: 'ОФОРМИТЬ ПОДПИСКУ',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 56.0,
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).titleSmallFamily,
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 17.0,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).titleSmallIsCustom,
                      ),
                  elevation: 0.0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(56.0),
                ),
                showLoadingIndicator: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
