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

import 'dart:math' as math;

class MessageLetterWidget extends StatefulWidget {
  const MessageLetterWidget({
    super.key,
    this.width,
    this.height,
    this.onCardTap,
    this.metaCards = const [],
    this.image = '',
    this.animationDuration = 1500,
    this.staggerDelay = 150,
    this.topOffset = 200.0,
  });

  final double? width;
  final double? height;
  final Future Function(MetaCardsRecord card)? onCardTap;
  final List<MetaCardsRecord> metaCards;
  // Single image URL used for all cards (card back)
  final String image;
  final int animationDuration;
  final int staggerDelay;
  final double topOffset;

  @override
  State<MessageLetterWidget> createState() => _MessageLetterWidgetState();
}

class _MessageLetterWidgetState extends State<MessageLetterWidget>
    with TickerProviderStateMixin {
  final List<AnimationController> _controllers = [];
  final List<Animation<double>> _fallAnimations = [];
  final List<Animation<double>> _rotationAnimations = [];
  final List<double> _randomRotations = [];
  final List<Offset> _randomOffsets = [];
  final math.Random _random = math.Random();

  static const double itemWidth = 90.0;
  static const double itemHeight = 160.0;
  static const double borderRadius = 8.0;
  static const int columns = 3;
  static const double horizontalSpacing = 12.0;
  static const double verticalSpacing = 8.0;

  int get itemsCount => widget.metaCards.length;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startStaggeredAnimations();
  }

  void _initializeAnimations() {
    for (int i = 0; i < itemsCount; i++) {
      final controller = AnimationController(
        duration: Duration(milliseconds: widget.animationDuration),
        vsync: this,
      );
      _controllers.add(controller);

      // Cards fall from above screen to final position
      final fallAnimation = Tween<double>(
        begin: -1.0,
        end: 0.0,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.bounceOut,
      ));
      _fallAnimations.add(fallAnimation);

      final randomRotation = _random.nextDouble() * 4 - 2;
      _randomRotations.add(randomRotation);

      final rotationAnimation = Tween<double>(
        begin: randomRotation * math.pi,
        end: 0.0,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ));
      _rotationAnimations.add(rotationAnimation);

      _randomOffsets.add(Offset(
        (_random.nextDouble() - 0.5) * 50,
        0,
      ));
    }
  }

  void _startStaggeredAnimations() {
    for (int i = 0; i < itemsCount; i++) {
      Future.delayed(Duration(milliseconds: i * widget.staggerDelay), () {
        if (mounted) _controllers[i].forward();
      });
    }
  }

  int _getRow(int index) => index ~/ columns;
  int _getColumn(int index) => index % columns;

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = widget.width != null && widget.width!.isFinite
        ? widget.width!
        : MediaQuery.of(context).size.width;
    final double screenHeight = widget.height != null && widget.height!.isFinite
        ? widget.height!
        : MediaQuery.of(context).size.height;

    final bool isSingleItem = itemsCount == 1;
    final int effectiveColumns = itemsCount < columns ? itemsCount : columns;

    final double totalItemsWidth = (itemWidth * effectiveColumns) +
        (horizontalSpacing * (effectiveColumns - 1));

    // Center grid horizontally
    final double startX = (screenWidth - totalItemsWidth) / 2;

    return Container(
      width: screenWidth,
      height: screenHeight,
      color: Colors.transparent,
      child: Stack(
        children: List.generate(itemsCount, (index) {
          final int column = isSingleItem ? 0 : _getColumn(index);
          final int row = isSingleItem ? 0 : _getRow(index);

          final double finalX =
              startX + (column * (itemWidth + horizontalSpacing));

          // First row lands at topOffset, next rows below
          final double finalY =
              widget.topOffset + (row * (itemHeight + verticalSpacing));

          final MetaCardsRecord card = widget.metaCards[index];

          return AnimatedBuilder(
            animation: _controllers[index],
            builder: (context, child) {
              final double fallProgress = _fallAnimations[index].value;
              final double rotation = _rotationAnimations[index].value;
              final Offset randomOffset = _randomOffsets[index];

              // fallProgress -1→0: card starts above screen, lands at finalY
              final double currentY = finalY +
                  (fallProgress * screenHeight) +
                  (randomOffset.dy * (1 - _controllers[index].value));
              final double currentX =
                  finalX + (randomOffset.dx * (1 - _controllers[index].value));

              return Positioned(
                left: currentX,
                top: currentY,
                child: Transform.rotate(
                  angle: rotation,
                  child: GestureDetector(
                    onTap: () async {
                      // Return tapped card document to FlutterFlow
                      if (widget.onCardTap != null) {
                        await widget.onCardTap!(card);
                      }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(borderRadius),
                      child: SizedBox(
                        width: itemWidth,
                        height: itemHeight,
                        child: widget.image.isNotEmpty
                            ? Image.network(
                                widget.image,
                                width: itemWidth,
                                height: itemHeight,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
