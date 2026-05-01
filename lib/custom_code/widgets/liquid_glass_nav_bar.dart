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

import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class LiquidGlassNavBar extends StatefulWidget {
  const LiquidGlassNavBar({
    super.key,
    this.width,
    this.height,
    required this.pageNum,
    this.homeTab,
    this.educationTab,
    this.chatTab,
    this.audioTab,
    this.profileTab,
    required this.onHomeTabTap,
    required this.onEducationTabTap,
    required this.onChatTabTap,
    required this.onAudioTabTap,
    required this.onProfileTabTap,
  });

  final double? width;
  final double? height;
  final double pageNum;
  final Widget Function()? homeTab;
  final Widget Function()? educationTab;
  final Widget Function()? chatTab;
  final Widget Function()? audioTab;
  final Widget Function()? profileTab;
  final Future Function() onHomeTabTap;
  final Future Function() onEducationTabTap;
  final Future Function() onChatTabTap;
  final Future Function() onAudioTabTap;
  final Future Function() onProfileTabTap;

  @override
  State<LiquidGlassNavBar> createState() => _LiquidGlassNavBarState();
}

class _LiquidGlassNavBarState extends State<LiquidGlassNavBar>
    with TickerProviderStateMixin {
  late final List<AnimationController> _scaleControllers;
  late final List<Animation<double>> _scaleAnimations;

  late final AnimationController _pillController;
  Animation<double>? _pillScale;

  late final AnimationController _blobController;
  late final Animation<double> _blobScale;
  late final Animation<double> _blobOpacity;

  late final AnimationController _navScaleController;
  late final Animation<double> _navScale;

  late final AnimationController _tapBlobController;
  late final Animation<double> _tapBlobScale;
  late final Animation<double> _tapBlobOpacity;
  Animation<double>? _tapBlobLeft;

  int? _dragIndex;
  Offset? _blobGlobalPos;
  bool _longPressActive = false;

  int? _tapIndex;
  int? _tapFromIndex;
  bool _tapActive = false;

  OverlayEntry? _overlayEntry;

  final GlobalKey _rowKey = GlobalKey();
  final GlobalKey _navKey = GlobalKey();

  static const double _navHeight = 64.0;
  static const double _tabHeight = 54.0;
  static const double _blobHeight = 70.0;
  static const double _tabOverflow = 6.0;

  @override
  void initState() {
    super.initState();

    _scaleControllers = List.generate(
      5,
      (_) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 90),
        reverseDuration: const Duration(milliseconds: 140),
      ),
    );
    _scaleAnimations = _scaleControllers.map((ctrl) {
      return Tween<double>(begin: 1.0, end: 0.93).animate(
        CurvedAnimation(parent: ctrl, curve: Curves.easeOutCubic),
      );
    }).toList();

    _pillController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _pillScale = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _pillController, curve: Curves.easeOutBack),
    );
    _pillController.value = 1.0;

    _blobController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _blobScale = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _blobController, curve: Curves.easeOutBack),
    );
    _blobOpacity = CurvedAnimation(
      parent: _blobController,
      curve: Curves.easeOut,
    );

    _tapBlobController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 340),
      reverseDuration: const Duration(milliseconds: 240),
    );
    _tapBlobScale = Tween<double>(begin: 0.72, end: 1.0).animate(
      CurvedAnimation(parent: _tapBlobController, curve: Curves.easeOutBack),
    );
    _tapBlobOpacity = CurvedAnimation(
      parent: _tapBlobController,
      curve: Curves.easeOut,
    );

    _navScaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 160),
      reverseDuration: const Duration(milliseconds: 180),
    );
    _navScale = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _navScaleController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _removeOverlay();
    for (final c in _scaleControllers) {
      c.dispose();
    }
    _pillController.dispose();
    _blobController.dispose();
    _tapBlobController.dispose();
    _navScaleController.dispose();
    super.dispose();
  }

  int get _selectedIndex => (widget.pageNum.floor() - 1).clamp(0, 4);

  List<Widget Function()?> get _tabs => [
        widget.homeTab,
        widget.educationTab,
        widget.chatTab,
        widget.audioTab,
        widget.profileTab,
      ];

  List<Future Function()> get _actions => [
        widget.onHomeTabTap,
        widget.onEducationTabTap,
        widget.onChatTabTap,
        widget.onAudioTabTap,
        widget.onProfileTabTap,
      ];

  RenderBox? get _rowBox =>
      _rowKey.currentContext?.findRenderObject() as RenderBox?;

  int _indexFromGlobalX(double globalX) {
    final box = _rowBox;
    if (box == null) return 0;
    final local = box.globalToLocal(Offset(globalX, 0));
    final slotWidth = box.size.width / 5;
    return (local.dx / slotWidth).floor().clamp(0, 4);
  }

  double _slotWidth() {
    final box = _rowBox;
    if (box == null) return 70.0;
    return box.size.width / 5;
  }

  double _slotLeftInNav(int index) {
    return 4.0 + _slotWidth() * index - _tabOverflow;
  }

  double _navCentreY() {
    final box = _navKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return 0;
    final pos = box.localToGlobal(Offset.zero);
    return pos.dy + box.size.height / 2;
  }

  void _configureTapBlobAnimation({
    required int fromIndex,
    required int toIndex,
  }) {
    _tapBlobLeft = Tween<double>(
      begin: _slotLeftInNav(fromIndex),
      end: _slotLeftInNav(toIndex),
    ).animate(
      CurvedAnimation(
        parent: _tapBlobController,
        curve: Curves.easeOutCubic,
      ),
    );
  }

  void _showOverlay() {
    _overlayEntry = OverlayEntry(builder: (_) => _BlobOverlay(state: this));
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _updateOverlay() => _overlayEntry?.markNeedsBuild();

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _startPressVisual(int index) {
    if (_longPressActive) return;

    final fromIndex = _selectedIndex;
    _tapIndex = index;
    _tapFromIndex = fromIndex;
    _tapActive = true;

    _configureTapBlobAnimation(fromIndex: fromIndex, toIndex: index);

    _navScaleController.forward();
    _tapBlobController.forward(from: 0.0);
    _scaleControllers[index].forward(from: 0.0);
    HapticFeedback.selectionClick();
    setState(() {});
  }

  Future<void> _endPressVisual(int index) async {
    if (_longPressActive) return;

    _scaleControllers[index].reverse();
    _navScaleController.reverse();

    await Future.delayed(const Duration(milliseconds: 130));

    if (!mounted || _longPressActive) return;

    await _tapBlobController.reverse();

    if (!mounted) return;

    _tapActive = false;
    _tapIndex = null;
    _tapFromIndex = null;
    setState(() {});
  }

  Future<void> _handleTap(int index) async {
    HapticFeedback.mediumImpact();
    _pillController.forward(from: 0.0);
    await _actions[index]();
  }

  void _onLongPressStart(LongPressStartDetails details) {
    final idx = _indexFromGlobalX(details.globalPosition.dx);
    HapticFeedback.mediumImpact();
    _dragIndex = idx;
    _blobGlobalPos = details.globalPosition;
    _longPressActive = true;
    _tapActive = false;
    _tapIndex = null;
    _tapFromIndex = null;

    _navScaleController.forward();

    setState(() {});
    _showOverlay();
    _blobController.forward().then((_) => _updateOverlay());
    _updateOverlay();
  }

  void _onLongPressMoveUpdate(LongPressMoveUpdateDetails details) {
    final idx = _indexFromGlobalX(details.globalPosition.dx);
    if (idx != _dragIndex) HapticFeedback.selectionClick();
    _dragIndex = idx;
    _blobGlobalPos = details.globalPosition;
    _updateOverlay();
  }

  Future<void> _onLongPressEnd(LongPressEndDetails details) async {
    final idx = _dragIndex;
    _blobController.reverse();
    _longPressActive = false;
    _dragIndex = null;
    _blobGlobalPos = null;
    setState(() {});
    _removeOverlay();
    _blobController.reset();

    if (idx != null) {
      HapticFeedback.heavyImpact();
      _pillController.forward(from: 0.0);
      await _actions[idx]();
    }

    _navScaleController.reverse();
  }

  static Widget _navGlass({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(99.0),
      child: LiquidGlass(
        shape: LiquidRoundedRectangle(
          borderRadius: const Radius.circular(99.0),
        ),
        settings: LiquidGlassSettings(
          glassColor: const Color(0x1AFFFFFF),
          thickness: 18.0,
          lightIntensity: 0.5,
          ambientStrength: 0.3,
        ),
        glassContainsChild: false,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0x1FFFFFFF),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(99.0),
          ),
          child: child,
        ),
      ),
    );
  }

  static Widget _tabGlass({
    required Widget child,
    required double height,
    double? width,
  }) {
    return LiquidGlass(
      shape: LiquidRoundedRectangle(
        borderRadius: const Radius.circular(99.0),
      ),
      settings: LiquidGlassSettings(
        glassColor: const Color(0x33FFFFFF),
        thickness: 12.0,
        lightIntensity: 0.5,
        ambientStrength: 0.3,
      ),
      glassContainsChild: false,
      child: SizedBox(
        width: width,
        height: height,
        child: child,
      ),
    );
  }

  static Widget blobGlass({
    required Widget child,
    required double height,
    required double width,
  }) {
    return Material(
      type: MaterialType.transparency,
      child: LiquidGlass(
        shape: LiquidRoundedRectangle(
          borderRadius: const Radius.circular(99.0),
        ),
        settings: LiquidGlassSettings(
          glassColor: const Color(0x44FFFFFF),
          thickness: 32.0,
          lightIntensity: 1.0,
          ambientStrength: 0.75,
        ),
        glassContainsChild: false,
        child: SizedBox(
          width: width,
          height: height,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _navScale,
      child: SizedBox(
        key: _navKey,
        width: widget.width ?? double.infinity,
        height: _navHeight,
        child: GestureDetector(
          onLongPressStart: _onLongPressStart,
          onLongPressMoveUpdate: _onLongPressMoveUpdate,
          onLongPressEnd: _onLongPressEnd,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(99.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
                  child: Container(
                    width: double.infinity,
                    height: _navHeight - 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(99.0),
                    ),
                  ),
                ),
              ),
              _navGlass(
                child: SizedBox(
                  height: _navHeight,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned.fill(
                          child: IgnorePointer(
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                if (_tapActive &&
                                    _tapIndex != null &&
                                    _tapFromIndex != null &&
                                    !_longPressActive)
                                  AnimatedBuilder(
                                    animation: _tapBlobController,
                                    builder: (context, child) {
                                      final slotW = _slotWidth();
                                      final blobW = slotW + _tabOverflow * 2;
                                      final left = _tapBlobLeft?.value ??
                                          _slotLeftInNav(_tapIndex!);

                                      return Positioned(
                                        left: left,
                                        top: -(_tabOverflow / 2),
                                        child: FadeTransition(
                                          opacity: _tapBlobOpacity,
                                          child: ScaleTransition(
                                            scale: _tapBlobScale,
                                            child: blobGlass(
                                              width: blobW,
                                              height: _blobHeight,
                                              child: const SizedBox.shrink(),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          key: _rowKey,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: List.generate(5, (i) {
                            return Expanded(
                              child: ScaleTransition(
                                scale: _scaleAnimations[i],
                                child: Listener(
                                  behavior: HitTestBehavior.opaque,
                                  onPointerDown: (_) => _startPressVisual(i),
                                  onPointerUp: (_) {
                                    _endPressVisual(i);
                                  },
                                  onPointerCancel: (_) {
                                    _endPressVisual(i);
                                  },
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () => _handleTap(i),
                                    child: _buildTabItem(context, i),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem(BuildContext context, int index) {
    final isSelected = _selectedIndex == index && !_longPressActive;
    final tabBuilder = _tabs[index];
    if (tabBuilder == null) return const SizedBox.shrink();

    final tabWidget = tabBuilder();

    if (isSelected) {
      return ScaleTransition(
        scale: _pillScale ?? const AlwaysStoppedAnimation(1.0),
        child: _tabGlass(
          height: _tabHeight,
          width: double.infinity,
          child: SizedBox(
            height: _tabHeight,
            width: double.infinity,
            child: tabWidget,
          ),
        ),
      );
    }

    return SizedBox(
      height: _tabHeight,
      width: double.infinity,
      child: tabWidget,
    );
  }
}

class _BlobOverlay extends StatelessWidget {
  const _BlobOverlay({required this.state});

  final _LiquidGlassNavBarState state;

  @override
  Widget build(BuildContext context) {
    final idx = state._dragIndex;
    final globalPos = state._blobGlobalPos;
    if (idx == null || globalPos == null) return const SizedBox.shrink();

    final slotW = state._slotWidth();
    final blobW = slotW + _LiquidGlassNavBarState._tabOverflow * 2;
    final blobH = _LiquidGlassNavBarState._blobHeight;

    final rowBox = state._rowBox;
    double centreX = globalPos.dx;
    if (rowBox != null) {
      final rowGlobal = rowBox.localToGlobal(Offset.zero);
      final overflow = _LiquidGlassNavBarState._tabOverflow;
      centreX = globalPos.dx.clamp(
        rowGlobal.dx + blobW / 2 - overflow,
        rowGlobal.dx + rowBox.size.width - blobW / 2 + overflow,
      );
    }

    final left = centreX - blobW / 2;
    final overflow = _LiquidGlassNavBarState._tabOverflow;
    final top = state._navCentreY() - blobH / 2 - overflow / 2;

    return Positioned(
      left: left,
      top: top,
      child: IgnorePointer(
        child: FadeTransition(
          opacity: state._blobOpacity,
          child: ScaleTransition(
            scale: state._blobScale,
            child: _LiquidGlassNavBarState.blobGlass(
              width: blobW,
              height: blobH,
              child: const SizedBox.shrink(),
            ),
          ),
        ),
      ),
    );
  }
}
