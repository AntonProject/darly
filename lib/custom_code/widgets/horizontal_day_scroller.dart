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

class HorizontalDayScroller extends StatefulWidget {
  const HorizontalDayScroller({
    super.key,
    this.width,
    this.height,
    required this.days,
    required this.selectedDay,
    required this.dayBuilder,
  });

  final double? width;
  final double? height;
  final List<DateTime> days;
  final DateTime selectedDay;
  final Widget Function(DateTime day) dayBuilder;

  @override
  State<HorizontalDayScroller> createState() => _HorizontalDayScrollerState();
}

class _HorizontalDayScrollerState extends State<HorizontalDayScroller> {
  final ScrollController _scrollController = ScrollController();

  // Day item width 44 + spacing 8 = 52
  static const double _itemTotalWidth = 52.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelected(widget.selectedDay);
    });
  }

  @override
  void didUpdateWidget(HorizontalDayScroller oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Scroll when selected day changes from outside
    if (oldWidget.selectedDay != widget.selectedDay) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToSelected(widget.selectedDay);
      });
    }
  }

  void _scrollToSelected(DateTime day) {
    if (!_scrollController.hasClients) return;

    // Retry if layout not ready yet
    if (_scrollController.position.maxScrollExtent == 0) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) _scrollToSelected(day);
      });
      return;
    }

    final index = widget.days.indexWhere(
        (d) => d.year == day.year && d.month == day.month && d.day == day.day);

    if (index == -1) return;

    final screenWidth = _scrollController.position.viewportDimension;

    // Scroll offset so selected day is centered on screen
    final itemOffset = index * _itemTotalWidth + 16.0;
    final centeredOffset =
        itemOffset - (screenWidth / 2) + (_itemTotalWidth / 2);
    final clampedOffset = centeredOffset.clamp(
      0.0,
      _scrollController.position.maxScrollExtent,
    );

    _scrollController.animateTo(
      clampedOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height ?? 80,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: widget.days
              .map((day) => widget.dayBuilder(day))
              .toList()
              .divide(const SizedBox(width: 8.0))
              .addToStart(const SizedBox(width: 16.0))
              .addToEnd(const SizedBox(width: 16.0)),
        ),
      ),
    );
  }
}
