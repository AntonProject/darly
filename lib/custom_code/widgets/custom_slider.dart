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

import 'dart:ui';

class CustomSlider extends StatefulWidget {
  const CustomSlider({
    super.key,
    this.width,
    this.height,
    this.action,
    this.buttonColor,
    this.borderColor,
    this.icon,
    this.text,
    this.textSize,
  });

  final double? width;
  final double? height;
  final Future Function()? action;
  final Color? buttonColor;
  final Color? borderColor;
  final Widget? icon;
  final String? text;
  final double? textSize;

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double _dragPosition = 0.0;
  bool _isDragging = false;
  bool _isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double containerWidth = constraints.maxWidth;
        // Figma: height 56px
        final double containerHeight = widget.height ?? 56.0;
        // Figma: padding 4px between border and button
        const double padding = 4.0;
        final double textSize = widget.textSize ?? 15.0;

        // Figma: button rgba(255,255,255,0.24)
        final Color buttonColor = widget.buttonColor ?? const Color(0x3DFFFFFF);
        // Figma: border rgba(255,255,255,0.12)
        final Color borderColor = widget.borderColor ?? const Color(0x1FFFFFFF);

        return ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: BackdropFilter(
            // Figma: backdrop-filter blur(12px)
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              width: containerWidth,
              height: containerHeight,
              decoration: BoxDecoration(
                // Figma: linear-gradient(rgba(0,0,0,0.2), rgba(0,0,0,0.2)) + rgba(255,255,255,0.12)
                // Combined: darkened frosted glass
                color: const Color(0x1FFFFFFF),
                border: Border.all(color: borderColor, width: 1),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Stack(
                children: [
                  // Dark overlay to match Figma gradient(rgba(0,0,0,0.2))
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0x33000000),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(padding),
                    child: LayoutBuilder(
                      builder: (context, innerConstraints) {
                        final double innerWidth = innerConstraints.maxWidth;
                        final double innerHeight = innerConstraints.maxHeight;
                        // Figma: button size 48x48
                        final double buttonSize = innerHeight;
                        final double maxDragDistance = innerWidth - buttonSize;
                        final double clampedDragPosition =
                            _dragPosition.clamp(0.0, maxDragDistance);
                        final double completionThreshold =
                            maxDragDistance * 0.9;

                        return Stack(
                          children: [
                            // Figma: text centered in full width but offset +19.47px right
                            // We shift the text area to account for button + offset
                            if (widget.text != null && widget.text!.isNotEmpty)
                              Positioned.fill(
                                child: Center(
                                  child: Transform.translate(
                                    // Figma: left: calc(50% - 167px/2 + 19.47px)
                                    // Shift text slightly right so it's not behind button
                                    offset: Offset(buttonSize / 2, 0),
                                    child: Text(
                                      widget.text!,
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: textSize,
                                        height: 1.33,
                                        letterSpacing: -0.06 * textSize,
                                        // Figma: rgba(255,214,170,0.64)
                                        color: const Color(0xA3FFD6AA),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            // Blur trail behind sliding button
                            Positioned(
                              left: 0,
                              top: 0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                                  child: Container(
                                    width: buttonSize + clampedDragPosition,
                                    height: buttonSize,
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                            ),

                            // Draggable button circle
                            Positioned(
                              left: clampedDragPosition,
                              top: 0,
                              child: GestureDetector(
                                onHorizontalDragStart: (_) {
                                  if (!_isCompleted) {
                                    setState(() => _isDragging = true);
                                  }
                                },
                                onHorizontalDragUpdate: (details) {
                                  if (!_isCompleted) {
                                    setState(() {
                                      _dragPosition += details.delta.dx;
                                      _dragPosition = _dragPosition.clamp(
                                          0.0, maxDragDistance);
                                    });
                                  }
                                },
                                onHorizontalDragEnd: (details) async {
                                  setState(() => _isDragging = false);
                                  if (_dragPosition >= completionThreshold &&
                                      !_isCompleted) {
                                    setState(() {
                                      _isCompleted = true;
                                      _dragPosition = maxDragDistance;
                                    });
                                    if (widget.action != null) {
                                      await widget.action!();
                                    }
                                    await Future.delayed(
                                        const Duration(milliseconds: 300));
                                    if (mounted) {
                                      setState(() {
                                        _dragPosition = 0.0;
                                        _isCompleted = false;
                                      });
                                    }
                                  } else {
                                    setState(() => _dragPosition = 0.0);
                                  }
                                },
                                child: AnimatedContainer(
                                  duration: _isDragging
                                      ? Duration.zero
                                      : const Duration(milliseconds: 300),
                                  curve: Curves.easeOut,
                                  width: buttonSize,
                                  height: buttonSize,
                                  decoration: BoxDecoration(
                                    // Figma: rgba(255,255,255,0.24)
                                    color: buttonColor,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: widget.icon != null
                                      ? widget.icon!
                                      : Center(
                                          child: CustomPaint(
                                            size: const Size(17.49, 13.54),
                                            painter: ArrowChevronPainter(),
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Two chevrons — Figma: rgba(255,214,170,0.88)
class ArrowChevronPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xE1FFD6AA)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Left chevron
    final leftPath = Path()
      ..moveTo(4.5, 6.48)
      ..lineTo(4.5 + 5.52, 6.48 + 11.04 / 2)
      ..lineTo(4.5, 6.48 + 11.04);
    canvas.drawPath(leftPath, paint);

    // Right chevron
    final rightPath = Path()
      ..moveTo(13.98, 6.48)
      ..lineTo(13.98 + 5.52, 6.48 + 11.04 / 2)
      ..lineTo(13.98, 6.48 + 11.04);
    canvas.drawPath(rightPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
