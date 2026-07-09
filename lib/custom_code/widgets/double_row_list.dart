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

class DoubleRowList extends StatefulWidget {
  const DoubleRowList({
    super.key,
    this.width,
    this.height,
    this.list,
    required this.itemBuilder,
    this.offset,
    this.startEndSpacing,
  });

  final double? width;
  final double? height;
  final List<String>? list;
  final Widget Function(String item) itemBuilder;
  final double? offset;
  final double? startEndSpacing;

  @override
  State<DoubleRowList> createState() => _DoubleRowListState();
}

class _DoubleRowListState extends State<DoubleRowList> {
  late final ScrollController _topController;
  late final ScrollController _botController;

  double get _offset => widget.offset ?? 0.0;
  double get _startEndSpacing => widget.startEndSpacing ?? 20.0;

  @override
  void initState() {
    super.initState();
    _topController = ScrollController(initialScrollOffset: _offset);
    _botController = ScrollController(initialScrollOffset: _offset);
  }

  @override
  void didUpdateWidget(covariant DoubleRowList oldWidget) {
    super.didUpdateWidget(oldWidget);

    final oldOffset = oldWidget.offset ?? 0.0;
    final newOffset = widget.offset ?? 0.0;

    if (oldOffset != newOffset) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_topController.hasClients || !_botController.hasClients) return;

        final topTarget = newOffset.clamp(
          0.0,
          _topController.position.maxScrollExtent,
        );
        final botTarget = newOffset.clamp(
          0.0,
          _botController.position.maxScrollExtent,
        );

        _topController.jumpTo(topTarget);
        _botController.jumpTo(botTarget);
      });
    }
  }

  @override
  void dispose() {
    _topController.dispose();
    _botController.dispose();
    super.dispose();
  }

  Widget _buildRow(List<String> items, ScrollController controller) {
    return SizedBox(
      height: 36.0,
      child: ListView.separated(
        controller: controller,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: _startEndSpacing),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8.0),
        itemBuilder: (context, index) => widget.itemBuilder(items[index]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.list ?? [];
    if (items.isEmpty) return const SizedBox.shrink();

    final half = (items.length / 2).ceil();
    final topRow = items.sublist(0, half);
    final botRow = items.sublist(half);

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildRow(topRow, _topController),
          if (botRow.isNotEmpty) ...[
            const SizedBox(height: 12.0),
            _buildRow(botRow, _botController),
          ],
        ],
      ),
    );
  }
}
