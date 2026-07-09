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

import '/custom_code/widgets/index.dart';
import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:ui';

const String _kWheelNewsFallbackImageUrl =
    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/woman-103qa6/assets/v7p18mqzpgt4/logo34.webp';

/// Cylindrical news list widget for the home screen.
class WheelListHome extends StatefulWidget {
  const WheelListHome({
    Key? key,
    this.width,
    this.height,
    this.newsList,
    this.containerWidth = 94.0,
    this.containerHeight = 116.0,
    this.imageWidth = 88.0,
    this.imageHeight = 110.0,
    this.imageRadius = 12.0,
    this.borderRadius = 16.0,
    this.borderSize = 1.0,
    this.borderColor = const Color(0xFFCF8516),
    this.titleFontSize = 15.0,
    this.titleColor = const Color(0xFFEEE6D3),
    this.dateFontSize = 13.0,
    this.dateColor = const Color(0xFF969185),
    this.backgroundColor = const Color(0xFF131111),
    this.itemSpacing = 10.0,
    this.onScrollSelected,
    this.onTapCentralItem,
  }) : super(key: key);

  final double? width;
  final double? height;
  final List<NewsRecord>? newsList;
  final double? containerWidth;
  final double? containerHeight;
  final double? imageWidth;
  final double? imageHeight;
  final double? imageRadius;
  final double? borderRadius;
  final double? borderSize;
  final Color? borderColor;
  final double? titleFontSize;
  final Color? titleColor;
  final double? dateFontSize;
  final Color? dateColor;
  final Color? backgroundColor;
  final double? itemSpacing;
  final Future Function(NewsRecord? selectedItem)? onScrollSelected;
  final Future Function(NewsRecord? selectedItem)? onTapCentralItem;

  @override
  _WheelListHomeState createState() => _WheelListHomeState();
}

class _WheelListHomeState extends State<WheelListHome> {
  int _currentIndex = 0;
  late PageController _scrollController;
  bool _isImagesLoaded = false;
  int _loadedImagesCount = 0;

  @override
  void initState() {
    super.initState();
    if (widget.newsList != null && widget.newsList!.isNotEmpty) {
      final int listLength = widget.newsList!.length;

      if (listLength >= 3) {
        final int centerIndex = listLength ~/ 2;
        _currentIndex = centerIndex < 2 ? 2 : centerIndex;
      } else {
        _currentIndex = listLength - 1;
      }
    }

    if (widget.newsList != null && widget.newsList!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;

        final bool anyHasImage = widget.newsList!
            .any((news) => news.image != null && news.image!.isNotEmpty);

        if (!anyHasImage) {
          setState(() {
            _isImagesLoaded = true;
          });
          return;
        }

        for (var news in widget.newsList!) {
          if (news.image != null && news.image!.isNotEmpty) {
            precacheImage(
              CachedNetworkImageProvider(news.image!),
              context,
            );
          }
        }
      });
    }
  }

  void _onImageLoaded() {
    if (!_isImagesLoaded && _loadedImagesCount == 0) {
      setState(() {
        _loadedImagesCount++;
        _isImagesLoaded = true;
      });
    }
  }

  void _onItemTap(NewsRecord item, int index) {
    if (index == _currentIndex) {
      HapticFeedback.mediumImpact();
      if (widget.onTapCentralItem != null) {
        widget.onTapCentralItem!(item);
      }
    } else {
      HapticFeedback.lightImpact();
      _scrollController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    final formatter = DateFormat('dd MMMM yyyy');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.newsList == null || widget.newsList!.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: widget.height ?? 250.0,
        child: Center(
          child: Text(
            'No items',
            style: TextStyle(
              color: widget.titleColor?.withOpacity(0.5),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    final double totalHeight = widget.height ?? 250.0;

    return SizedBox(
      width: double.infinity,
      height: totalHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(color: widget.backgroundColor),

          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: widget.containerHeight! * 1.5,
            child: CylindricalScrollView(
              children: List.generate(
                widget.newsList!.length,
                (index) {
                  final item = widget.newsList![index];
                  final isCentral = index == _currentIndex;
                  return ItemCard(
                    item: item,
                    index: index,
                    isCentral: isCentral,
                    containerWidth: widget.containerWidth!,
                    containerHeight: widget.containerHeight!,
                    imageRadius: widget.imageRadius!,
                    borderRadius: widget.borderRadius!,
                    borderSize: widget.borderSize!,
                    borderColor: widget.borderColor!,
                    onTap: _onItemTap,
                    onImageLoaded: _onImageLoaded,
                  );
                },
              ),
              itemWidth: widget.containerWidth!,
              itemSpacing: widget.itemSpacing!,
              radius: 100.0,
              perspective: -0.002,
              sideVisibleCount: 1.3,
              initialPage: _currentIndex,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
                if (widget.onScrollSelected != null) {
                  widget.onScrollSelected!(widget.newsList![index]);
                }
              },
              onControllerReady: (controller) {
                _scrollController = controller;
              },
            ),
          ),

          // Текст — плавно появляется после загрузки первой картинки
          Positioned(
            left: 0,
            right: 0,
            top: widget.containerHeight! * 1.25,
            bottom: 8,
            child: AnimatedOpacity(
              opacity: _isImagesLoaded ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOut,
              child: _buildTextSection(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextSection() {
    if (widget.newsList == null ||
        widget.newsList!.isEmpty ||
        _currentIndex >= widget.newsList!.length) {
      return const SizedBox.shrink();
    }

    final currentItem = widget.newsList![_currentIndex];

    String title = currentItem.title ?? '';
    if (title.length > 100) {
      title = '${title.substring(0, 100)}...';
    }

    final maxTextWidth =
        (widget.containerWidth! * 3) + (widget.itemSpacing! * 2);

    return Center(
      child: Container(
        width: maxTextWidth,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          title.toUpperCase(),
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: widget.titleFontSize,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.75,
            height: 1.2,
            color: widget.titleColor?.withOpacity(0.96),
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final NewsRecord item;
  final int index;
  final bool isCentral;
  final double containerWidth;
  final double containerHeight;
  final double imageRadius;
  final double borderRadius;
  final double borderSize;
  final Color borderColor;
  final Function(NewsRecord, int) onTap;
  final VoidCallback onImageLoaded;

  const ItemCard({
    Key? key,
    required this.item,
    required this.index,
    required this.isCentral,
    required this.containerWidth,
    required this.containerHeight,
    required this.imageRadius,
    required this.borderRadius,
    required this.borderSize,
    required this.borderColor,
    required this.onTap,
    required this.onImageLoaded,
  }) : super(key: key);

  void _notifyImageHandled() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onImageLoaded();
    });
  }

  Widget _buildResolvedImage(ImageProvider imageProvider) {
    _notifyImageHandled();
    return Image(
      image: imageProvider,
      fit: BoxFit.cover,
    );
  }

  Widget _buildEmptyImage() {
    _notifyImageHandled();
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    // Паддинг и радиус ВСЕГДА одинаковые — layout не прыгает
    final effectivePadding =
        isCentral ? const EdgeInsets.all(2.0) : EdgeInsets.zero;
    final effectiveRadius = isCentral ? imageRadius : borderRadius - borderSize;

    final bool hasImage = item.image != null && item.image!.isNotEmpty;

    return GestureDetector(
      onTap: () => onTap(item, index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        width: containerWidth,
        height: containerHeight,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: isCentral ? borderColor : const Color(0x33FFD6AA),
            width: borderSize,
          ),
          boxShadow: isCentral
              ? [
                  BoxShadow(
                    color: borderColor.withOpacity(0.7),
                    blurRadius: 20,
                    spreadRadius: 0,
                  ),
                ]
              : null,
        ),
        padding: effectivePadding,
        child: hasImage
            ? ClipRRect(
                borderRadius: BorderRadius.circular(effectiveRadius),
                child: CachedNetworkImage(
                  imageUrl: item.image!,
                  fit: BoxFit.cover,
                  memCacheHeight: (containerHeight * 1.5).toInt(),
                  memCacheWidth: (containerWidth * 1.5).toInt(),
                  placeholder: (context, url) => const SizedBox.shrink(),
                  errorWidget: (context, url, error) => _buildEmptyImage(),
                  fadeInDuration: const Duration(milliseconds: 800),
                  fadeInCurve: Curves.easeOut,
                  imageBuilder: (context, imageProvider) =>
                      _buildResolvedImage(imageProvider),
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(effectiveRadius),
                child: CachedNetworkImage(
                  imageUrl: _kWheelNewsFallbackImageUrl,
                  fit: BoxFit.cover,
                  width: containerWidth,
                  height: containerHeight,
                  placeholder: (context, url) => const SizedBox.shrink(),
                  errorWidget: (context, url, error) => const SizedBox.shrink(),
                  fadeInDuration: const Duration(milliseconds: 800),
                  fadeInCurve: Curves.easeOut,
                  imageBuilder: (context, imageProvider) =>
                      _buildResolvedImage(imageProvider),
                ),
              ),
      ),
    );
  }
}

class CylindricalScrollView extends StatefulWidget {
  const CylindricalScrollView({
    Key? key,
    required this.children,
    this.itemWidth = 160.0,
    this.itemSpacing = 10.0,
    this.radius = 140.0,
    this.perspective = -0.002,
    this.sideVisibleCount = 1.0,
    this.initialPage = 0,
    this.onPageChanged,
    this.onControllerReady,
  }) : super(key: key);

  final List<Widget> children;
  final double itemWidth;
  final double itemSpacing;
  final double radius;
  final double perspective;
  final double sideVisibleCount;
  final int initialPage;
  final Function(int)? onPageChanged;
  final Function(PageController)? onControllerReady;

  @override
  State<CylindricalScrollView> createState() => _CylindricalScrollViewState();
}

class _CylindricalScrollViewState extends State<CylindricalScrollView> {
  late final PageController _pageController;
  double _currentPage = 0.0;
  int _lastReportedPage = 0;
  bool _isInitialized = false;
  int _lastHapticPage = -1;
  bool _isScrolling = false;

  @override
  void initState() {
    super.initState();
    final double baseFraction = 1.0 / (1 + 2 * widget.sideVisibleCount);
    final double safety = 1.0 / 1.12;
    final double vp = (baseFraction * safety).clamp(0.12, 0.95);
    _pageController = PageController(
      viewportFraction: vp,
      initialPage: widget.initialPage,
    );
    _currentPage = widget.initialPage.toDouble();
    _lastReportedPage = widget.initialPage;
    _lastHapticPage = widget.initialPage;

    if (widget.onControllerReady != null) {
      widget.onControllerReady!(_pageController);
    }

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page ?? 0.0;
      });

      _isScrolling = true;

      final int nearestPage = _currentPage.round();
      final double distanceFromNearest = (_currentPage - nearestPage).abs();

      if (nearestPage != _lastHapticPage && distanceFromNearest < 0.3) {
        _lastHapticPage = nearestPage;
        HapticFeedback.selectionClick();
      }

      final int currentPageInt = _currentPage.round();
      if (currentPageInt != _lastReportedPage) {
        _lastReportedPage = currentPageInt;
        if (widget.onPageChanged != null) {
          widget.onPageChanged!(currentPageInt);
        }
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollEndNotification) {
          _isScrolling = false;
          if (_pageController.page != null) {
            final int finalPage = _pageController.page!.round();
            if (finalPage == _currentPage.round()) {
              HapticFeedback.lightImpact();
            }
          }
        } else if (notification is ScrollStartNotification) {
          _isScrolling = true;
        }
        return false;
      },
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.children.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildCylindricalItem(index);
        },
      ),
    );
  }

  Widget _buildCylindricalItem(int index) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _pageController,
        child: widget.children[index],
        builder: (BuildContext context, Widget? child) {
          double deltaFromCurrent = 0.0;
          if (_pageController.position.haveDimensions && _isInitialized) {
            deltaFromCurrent = (_currentPage - index);
          } else {
            deltaFromCurrent = (widget.initialPage.toDouble() - index);
          }

          if (deltaFromCurrent.isNaN || deltaFromCurrent.isInfinite) {
            deltaFromCurrent = 0.0;
          }

          final double absDistance = deltaFromCurrent.abs();
          final double scale = 1.0 + (0.04 * absDistance * absDistance);
          final double angle = deltaFromCurrent * 0.3;
          final double zOffset = absDistance * widget.radius * 0.3;

          final Matrix4 transform = Matrix4.identity()
            ..setEntry(3, 2, widget.perspective)
            ..translate(0.0, 0.0, zOffset)
            ..rotateY(angle)
            ..scale(scale);

          final double horizontalMargin = widget.itemSpacing / 2;

          double blurSigma = (absDistance - 0.5).clamp(0.0, 1.0) * 1.2;
          if (blurSigma.isNaN || blurSigma.isInfinite) blurSigma = 0.0;

          double opacity = (1.0 - (absDistance - 0.5).clamp(0.0, 2.0) * 0.15)
              .clamp(0.5, 1.0);
          if (opacity.isNaN || opacity.isInfinite) opacity = 1.0;

          Widget cardContent = Container(
            margin:
                EdgeInsets.symmetric(horizontal: horizontalMargin, vertical: 0),
            child: child,
          );

          if (blurSigma >= 0.5) {
            cardContent = ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: blurSigma,
                sigmaY: blurSigma,
                tileMode: TileMode.decal,
              ),
              child: cardContent,
            );
          }

          if (opacity < 0.99) {
            cardContent = Opacity(
              opacity: opacity,
              child: cardContent,
            );
          }

          return Align(
            alignment: Alignment.center,
            child: Transform(
              alignment: Alignment.center,
              transform: transform,
              child: cardContent,
            ),
          );
        },
      ),
    );
  }
}
