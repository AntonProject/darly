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

import 'package:video_player/video_player.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class FullScreenVideo extends StatefulWidget {
  const FullScreenVideo({
    Key? key,
    this.width,
    this.height,
    required this.videoUrl,
    this.looping = true,
    this.autoPlay = true,
    required this.onVideoEnd,
    this.radius = 0.0,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String videoUrl;
  final bool looping;
  final bool autoPlay;
  final Future Function() onVideoEnd;
  final double radius;

  @override
  State<FullScreenVideo> createState() => _FullScreenVideoState();
}

class _FullScreenVideoState extends State<FullScreenVideo> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  Future<void> _initVideo() async {
    try {
      final fileInfo =
          await DefaultCacheManager().getFileFromCache(widget.videoUrl);
      VideoPlayerController controller;

      if (fileInfo != null) {
        controller = VideoPlayerController.file(fileInfo.file);
      } else {
        final file = await DefaultCacheManager().getSingleFile(widget.videoUrl);
        controller = VideoPlayerController.file(file);
      }

      await controller.initialize();
      if (!mounted) return;

      controller.setLooping(widget.looping);
      controller.setVolume(0);

      if (widget.autoPlay) {
        controller.play();
      }

      if (!widget.looping) {
        controller.addListener(() {
          if (controller.value.isInitialized &&
              !controller.value.isPlaying &&
              controller.value.position >= controller.value.duration) {
            controller.removeListener(() {});
            widget.onVideoEnd();
          }
        });
      }

      setState(() {
        _controller = controller;
      });
    } catch (e) {
      final controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
      );
      await controller.initialize();
      if (!mounted) return;

      controller.setLooping(widget.looping);
      controller.setVolume(0);

      if (widget.autoPlay) controller.play();

      setState(() {
        _controller = controller;
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    if (controller == null || !controller.value.isInitialized) {
      return const SizedBox.shrink();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.radius),
      child: SizedBox(
        width: widget.width ?? double.infinity,
        height: widget.height ?? double.infinity,
        child: FittedBox(
          fit: BoxFit.cover,
          clipBehavior: Clip.hardEdge,
          child: SizedBox(
            width: controller.value.size.width,
            height: controller.value.size.height,
            child: VideoPlayer(controller),
          ),
        ),
      ),
    );
  }
}
