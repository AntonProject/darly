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
import 'audio_category_model.dart';
export 'audio_category_model.dart';

class AudioCategoryWidget extends StatefulWidget {
  const AudioCategoryWidget({
    super.key,
    String? title,
    required this.selectedItem,
    required this.select,
  }) : this.title = title ?? 'Новое';

  final String title;
  final String? selectedItem;
  final Future Function(String? title)? select;

  @override
  State<AudioCategoryWidget> createState() => _AudioCategoryWidgetState();
}

class _AudioCategoryWidgetState extends State<AudioCategoryWidget>
    with TickerProviderStateMixin {
  late AudioCategoryModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AudioCategoryModel());

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
        logFirebaseEvent('AUDIO_CATEGORY_Container_myvnorji_ON_TAP');
        logFirebaseEvent('Container_haptic_feedback');
        HapticFeedback.lightImpact();
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
          color: valueOrDefault<Color>(
            widget!.selectedItem == widget!.title
                ? FlutterFlowTheme.of(context).primary
                : FlutterFlowTheme.of(context).white12,
            FlutterFlowTheme.of(context).white12,
          ),
          borderRadius: BorderRadius.circular(99.0),
          border: Border.all(
            color: Colors.transparent,
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
                      color: widget!.selectedItem == widget!.title
                          ? FlutterFlowTheme.of(context).info
                          : FlutterFlowTheme.of(context).primaryText,
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
