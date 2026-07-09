// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class FFLiquidGlass extends StatefulWidget {
  const FFLiquidGlass({
    super.key,
    this.width,
    this.height,
    required this.radius,
    this.component,
    required this.glowColor,
    this.glowRadius,
  });

  final double? width;
  final double? height;
  final double radius;
  final Widget Function()? component;
  final Color glowColor;
  final double? glowRadius;

  @override
  State<FFLiquidGlass> createState() => _FFLiquidGlassState();
}

class _FFLiquidGlassState extends State<FFLiquidGlass> {
  @override
  Widget build(BuildContext context) {
    // Thin, transparent glass to match Figma reference
    final settings = LiquidGlassSettings(
      glassColor: const Color(0x1AFFFFFF), // subtle white tint
      thickness: 18.0, // perceived depth
      lightIntensity: 0.95, // specular highlight
      ambientStrength: 0.5, // ambient light
    );

    final shape = LiquidRoundedRectangle(
      borderRadius: Radius.circular(widget.radius),
    );

    // Use empty box if no component provided
    Widget child = const SizedBox.shrink();
    if (widget.component != null) {
      child = widget.component!();
    }

    final bool hasGlow = widget.glowRadius != null && widget.glowRadius! > 0;

    return Container(
      width: widget.width,
      height: widget.height,
      // Optional outer glow
      decoration: hasGlow
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(widget.radius),
              boxShadow: [
                BoxShadow(
                  color: widget.glowColor.withOpacity(0.35),
                  blurRadius: widget.glowRadius!,
                  spreadRadius: 0.0,
                ),
              ],
            )
          : null,
      child: LiquidGlass(
        shape: shape,
        glassContainsChild: false,
        settings: settings,
        child: child,
      ),
    );
  }
}
