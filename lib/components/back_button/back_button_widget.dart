import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'back_button_model.dart';
export 'back_button_model.dart';

class BackButtonWidget extends StatefulWidget {
  const BackButtonWidget({
    super.key,
    required this.icon,
    required this.action,
  });

  final Widget? icon;
  final Future Function()? action;

  @override
  State<BackButtonWidget> createState() => _BackButtonWidgetState();
}

class _BackButtonWidgetState extends State<BackButtonWidget> {
  late BackButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BackButtonModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 4.0),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 12.0,
            sigmaY: 12.0,
          ),
          child: FlutterFlowIconButton(
            borderColor: FlutterFlowTheme.of(context).white12,
            borderRadius: 99.0,
            borderWidth: 1.0,
            buttonSize: 56.0,
            fillColor: FlutterFlowTheme.of(context).white12,
            icon: widget!.icon!,
            onPressed: () async {
              logFirebaseEvent('BACK_BUTTON_COMP__ICN_ON_TAP');
              logFirebaseEvent('IconButton_haptic_feedback');
              HapticFeedback.mediumImpact();
              logFirebaseEvent('IconButton_execute_callback');
              unawaited(
                () async {
                  await widget.action?.call();
                }(),
              );
            },
          ),
        ),
      ),
    );
  }
}
