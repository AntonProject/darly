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

import '/custom_code/widgets/index.dart';
import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

class TypewriterLoop extends StatefulWidget {
  const TypewriterLoop({
    super.key,
    this.width,
    this.height,
    required this.text,
    this.typingSpeed = 50,
    this.pauseAfterComplete = 600,
  });

  final double? width;
  final double? height;
  final String text;
  final int typingSpeed; // ms per character
  final int pauseAfterComplete; // ms pause before restart (600ms)

  @override
  State<TypewriterLoop> createState() => _TypewriterLoopState();
}

class _TypewriterLoopState extends State<TypewriterLoop>
    with SingleTickerProviderStateMixin {
  String _displayedText = '';
  bool _running = true;

  @override
  void initState() {
    super.initState();
    _startLoop();
  }

  void _startLoop() async {
    while (_running && mounted) {
      // Type characters one by one
      for (int i = 0; i <= widget.text.length; i++) {
        if (!mounted || !_running) return;
        setState(() {
          _displayedText = widget.text.substring(0, i);
        });
        await Future.delayed(Duration(milliseconds: widget.typingSpeed));
      }

      // Pause after fully typed
      await Future.delayed(Duration(milliseconds: widget.pauseAfterComplete));

      // Clear text instantly
      if (mounted && _running) {
        setState(() {
          _displayedText = '';
        });
      }

      // Small pause before restarting
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  @override
  void dispose() {
    _running = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Text(
        _displayedText,
        style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
              fontSize: 15.0,
              letterSpacing: 0.0,
              lineHeight: 1.25,
              useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
            ),
      ),
    );
  }
}
