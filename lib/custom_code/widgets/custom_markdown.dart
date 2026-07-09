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

import 'index.dart'; // Imports other custom widgets

import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class CustomMarkdown extends StatefulWidget {
  const CustomMarkdown({
    super.key,
    this.width,
    this.height,
    this.textSize,
    this.textWeight,
    this.boldTextSize,
    this.boldTextWeight,
    this.textColor,
    this.role,
    required this.text,
  });

  final double? width;
  final double? height;
  final double? textSize;
  final double? textWeight;
  final double? boldTextSize;
  final double? boldTextWeight;
  final Color? textColor;
  final String? role;
  final String text;

  @override
  State<CustomMarkdown> createState() => _CustomMarkdownState();
}

class _CustomMarkdownState extends State<CustomMarkdown> {
  FontWeight _getFontWeight(double weight) {
    int roundedWeight = (weight / 100).round() * 100;

    switch (roundedWeight) {
      case 100:
        return FontWeight.w100;
      case 200:
        return FontWeight.w200;
      case 300:
        return FontWeight.w300;
      case 400:
        return FontWeight.w400;
      case 500:
        return FontWeight.w500;
      case 600:
        return FontWeight.w600;
      case 700:
        return FontWeight.w700;
      case 800:
        return FontWeight.w800;
      case 900:
        return FontWeight.w900;
      default:
        return FontWeight.w400;
    }
  }

  @override
  Widget build(BuildContext context) {
    final normalFontWeight = _getFontWeight(widget.textWeight ?? 400.0);
    final boldFontWeight = _getFontWeight(widget.boldTextWeight ?? 600.0);

    final textColor =
        widget.textColor ?? FlutterFlowTheme.of(context).primaryText;

    // Определяем выравнивание текста
    final textAlign =
        (widget.role ?? 'user') == 'user' ? TextAlign.right : TextAlign.left;

    return SelectionArea(
      child: MarkdownBody(
        data: widget.text,
        styleSheet: MarkdownStyleSheet(
          textAlign: WrapAlignment.start,
          p: TextStyle(
            fontSize: widget.textSize,
            fontWeight: normalFontWeight,
            fontFamily: FlutterFlowTheme.of(context).bodySmall.fontFamily,
            color: textColor,
            height: 1.25,
            letterSpacing: 0.0,
          ),
          strong: TextStyle(
            fontSize: widget.boldTextSize,
            fontWeight: boldFontWeight,
            fontFamily: FlutterFlowTheme.of(context).titleSmall.fontFamily,
            color: textColor,
            height: 1.25,
            letterSpacing: 0.0,
          ),
          em: TextStyle(
            fontSize: widget.textSize,
            fontStyle: FontStyle.italic,
            fontWeight: normalFontWeight,
            fontFamily: FlutterFlowTheme.of(context).bodySmall.fontFamily,
            color: textColor,
            height: 1.25,
            letterSpacing: 0.0,
          ),
          h1: TextStyle(
            fontSize: (widget.textSize ?? 16.0) + 8,
            fontWeight: boldFontWeight,
            fontFamily: FlutterFlowTheme.of(context).bodySmall.fontFamily,
            color: textColor,
            height: 1.25,
            letterSpacing: 0.0,
          ),
          h2: TextStyle(
            fontSize: (widget.textSize ?? 16.0) + 6,
            fontWeight: boldFontWeight,
            fontFamily: FlutterFlowTheme.of(context).bodySmall.fontFamily,
            color: textColor,
            height: 1.25,
            letterSpacing: 0.0,
          ),
          h3: TextStyle(
            fontSize: (widget.textSize ?? 16.0) + 4,
            fontWeight: boldFontWeight,
            fontFamily: FlutterFlowTheme.of(context).bodySmall.fontFamily,
            color: textColor,
            height: 1.25,
            letterSpacing: 0.0,
          ),
          blockSpacing: 8.0,
          listBullet: TextStyle(
            fontSize: widget.textSize,
            fontFamily: FlutterFlowTheme.of(context).bodySmall.fontFamily,
            color: textColor,
            height: 1.25,
            letterSpacing: 0.0,
          ),
          listIndent: 20.0,
          textScaleFactor: 1.0,
        ),
        shrinkWrap: true,
        fitContent: true,
        extensionSet: md.ExtensionSet(
          md.ExtensionSet.commonMark.blockSyntaxes,
          [
            md.EmojiSyntax(),
            ...md.ExtensionSet.commonMark.inlineSyntaxes,
          ],
        ),
        selectable: false,
      ),
    );
  }
}
