import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'support_button_model.dart';
export 'support_button_model.dart';

class SupportButtonWidget extends StatefulWidget {
  const SupportButtonWidget({super.key});

  @override
  State<SupportButtonWidget> createState() => _SupportButtonWidgetState();
}

class _SupportButtonWidgetState extends State<SupportButtonWidget> {
  late SupportButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SupportButtonModel());

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
      padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 4.0),
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
            icon: Icon(
              FFIcons.kheadphonesOff,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            onPressed: () async {
              logFirebaseEvent('SUPPORT_BUTTON_headphonesOff_ICN_ON_TAP');
              logFirebaseEvent('IconButton_haptic_feedback');
              HapticFeedback.mediumImpact();
              logFirebaseEvent('IconButton_navigate_to');

              context.pushNamed(SupportPageWidget.routeName);
            },
          ),
        ),
      ),
    );
  }
}
