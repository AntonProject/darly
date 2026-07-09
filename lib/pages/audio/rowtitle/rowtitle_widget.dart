import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'rowtitle_model.dart';
export 'rowtitle_model.dart';

class RowtitleWidget extends StatefulWidget {
  const RowtitleWidget({
    super.key,
    String? title,
    required this.select,
  }) : this.title = title ?? 'Новое';

  final String title;
  final Future Function(String? title)? select;

  @override
  State<RowtitleWidget> createState() => _RowtitleWidgetState();
}

class _RowtitleWidgetState extends State<RowtitleWidget>
    with TickerProviderStateMixin {
  late RowtitleModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RowtitleModel());

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 1500.0.ms,
            duration: 600.0.ms,
            color: FlutterFlowTheme.of(context).primary16,
            angle: 0.524,
          ),
        ],
      ),
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
        logFirebaseEvent('ROWTITLE_COMP_Container_0wgg8xvp_ON_TAP');
        logFirebaseEvent('Container_haptic_feedback');
        HapticFeedback.lightImpact();
        logFirebaseEvent('Container_update_app_state');
        FFAppState().pressetChat = widget!.title;
        safeSetState(() {});
        logFirebaseEvent('Container_execute_callback');
        await widget.select?.call(
          widget!.title,
        );
      },
      child: Container(
        height: 36.0,
        constraints: BoxConstraints(
          minWidth: 60.0,
        ),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).white12,
          borderRadius: BorderRadius.circular(99.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).white12,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget!.title,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 15.0,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                    ),
              ),
            ],
          ),
        ),
      ),
    ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!);
  }
}
