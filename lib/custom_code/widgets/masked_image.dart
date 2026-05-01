// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/widgets/index.dart';
import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';

class MaskedImage extends StatefulWidget {
  const MaskedImage({
    super.key,
    this.width,
    this.height,
    this.imageUrl,
    this.topRadius = 20.0,
  });

  final double? width;
  final double? height;
  final String? imageUrl;
  final double topRadius;

  @override
  State<MaskedImage> createState() => _MaskedImageState();
}

class _MaskedImageState extends State<MaskedImage> {
  @override
  Widget build(BuildContext context) {
    final double w = widget.width ?? 375.0;
    final double h = widget.height ?? 376.0;

    final BorderRadius topBorderRadius = BorderRadius.only(
      topLeft: Radius.circular(widget.topRadius),
      topRight: Radius.circular(widget.topRadius),
    );

    return SizedBox(
      width: w,
      height: h,
      child: ClipRRect(
        borderRadius: topBorderRadius,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Layer 1: Image with TRUE alpha fade at bottom via ShaderMask
            // BlendMode.dstIn makes image pixels transparent where gradient is transparent
            ShaderMask(
              blendMode: BlendMode.dstIn,
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.white,
                    Color(0xAAFFFFFF),
                    Color(0x33FFFFFF),
                    Colors.transparent,
                  ],
                  stops: [0.0, 0.50, 0.72, 0.88, 1.0],
                ).createShader(bounds);
              },
              child: ClipRRect(
                borderRadius: topBorderRadius,
                child: _buildImage(w, h),
              ),
            ),
            // Layer 2: Top dark vignette
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x572A0001),
                    Color(0x00000000),
                  ],
                  stops: [0.0, 0.30],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(double w, double h) {
    final url = widget.imageUrl;

    // No url — show nothing
    if (url == null || url.isEmpty) {
      return const SizedBox.shrink();
    }

    return CachedNetworkImage(
      imageUrl: url,
      width: w,
      height: h,
      fit: BoxFit.cover,
      // Show nothing while loading — no placeholder flash
      placeholder: (context, url) => const SizedBox.shrink(),
      // On error — show nothing
      errorWidget: (context, url, error) => const SizedBox.shrink(),
    );
  }
}
