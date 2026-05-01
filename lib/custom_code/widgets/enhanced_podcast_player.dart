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

import 'dart:async';
import 'dart:math';
import 'package:audio_session/audio_session.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rxdart/rxdart.dart';

class EnhancedPodcastPlayer extends StatefulWidget {
  const EnhancedPodcastPlayer({
    super.key,
    this.width,
    this.height,
    this.currentTrack,
    this.playlist,
    required this.kplay,
    required this.kpause,
    required this.kRepeatOff,
    required this.kRepeatOne,
    required this.kPrevious,
    required this.kNext,
    required this.shareIcon,
    required this.wishOn,
    required this.wishOff,
    required this.onShare,
    required this.onWish,
    required this.userWishlist,
    this.playBtnColor,
    this.progressColor,
    this.trackColor,
    this.titleColor,
    this.authorColor,
    this.timeColor,
    this.speedColor,
    this.speedSize,
  });

  final double? width;
  final double? height;
  final AudioRecord? currentTrack;
  final List<AudioRecord>? playlist;
  final Widget kplay;
  final Widget kpause;
  final Widget kRepeatOff;
  final Widget kRepeatOne;
  final Widget kPrevious;
  final Widget kNext;
  final Widget shareIcon;
  final Widget wishOn;
  final Widget wishOff;
  final Future Function() onShare;
  final Future Function(AudioRecord currentTrack) onWish;
  final List<String> userWishlist;
  final Color? playBtnColor;
  final Color? progressColor;
  final Color? trackColor;
  final Color? titleColor;
  final Color? authorColor;
  final Color? timeColor;
  final Color? speedColor;
  final double? speedSize;

  @override
  State<EnhancedPodcastPlayer> createState() => _EnhancedPodcastPlayerState();
}

class _EnhancedPodcastPlayerState extends State<EnhancedPodcastPlayer> {
  late final AudioPlayer player;

  String? cache;
  double? drag;
  bool repeatOne = false;
  double speed = 1;

  String? _currentTrackUrl;
  String? _loadedSourceKey;

  bool _isLoadingTrack = false;
  bool _isPrecaching = false;

  int _currentIndex = 0;
  int _loadToken = 0;

  List<AudioRecord> get _effectivePlaylist {
    if (widget.playlist != null && widget.playlist!.isNotEmpty) {
      return widget.playlist!;
    }
    if (widget.currentTrack != null) {
      return [widget.currentTrack!];
    }
    return [];
  }

  AudioRecord? get _currentTrack {
    final playlist = _effectivePlaylist;
    if (playlist.isEmpty) return null;
    if (_currentIndex < 0 || _currentIndex >= playlist.length) return null;
    return playlist[_currentIndex];
  }

  String _normalizeTitle(String? value) {
    final raw = value?.trim() ?? '';
    return raw.isEmpty ? 'Untitled' : raw;
  }

  String _normalizeCategory(String? value) {
    final raw = value?.trim() ?? '';
    return raw.isEmpty ? 'UNCATEGORIZED' : raw;
  }

  String _normalizeArtist(String? value) {
    final raw = value?.trim() ?? '';
    return raw.isEmpty ? 'Unknown Artist' : raw;
  }

  String get _displayTitle =>
      _normalizeTitle(_currentTrack?.audioTitle).toUpperCase();

  String get _displayCategory =>
      _normalizeCategory(_currentTrack?.category).toUpperCase();

  bool get _isCurrentTrackWished {
    final track = _currentTrack;
    if (track == null || track.reference == null) return false;
    return widget.userWishlist.contains(track.reference!.id);
  }

  bool get _allTracksHaveIndex {
    final playlist = _effectivePlaylist;
    if (playlist.isEmpty) return false;
    return playlist.every((track) => track.hasIndex());
  }

  int? get _minIndex {
    final playlist = _effectivePlaylist;
    if (playlist.isEmpty) return null;
    if (_allTracksHaveIndex) {
      final indexes = playlist.map((track) => track.index).toList();
      return indexes.reduce((a, b) => a < b ? a : b);
    }
    return 0;
  }

  int? get _maxIndex {
    final playlist = _effectivePlaylist;
    if (playlist.isEmpty) return null;
    if (_allTracksHaveIndex) {
      final indexes = playlist.map((track) => track.index).toList();
      return indexes.reduce((a, b) => a > b ? a : b);
    }
    return playlist.length - 1;
  }

  bool get _isFirstTrack {
    final playlist = _effectivePlaylist;
    if (playlist.isEmpty) return true;
    final minIdx = _minIndex;
    if (minIdx == null) return true;
    if (_allTracksHaveIndex &&
        _currentTrack != null &&
        _currentTrack!.hasIndex()) {
      final currentDocIndex = _currentTrack!.index;
      if (currentDocIndex != minIdx) return false;
      int firstIndexInList = -1;
      for (int i = 0; i < playlist.length; i++) {
        if (playlist[i].hasIndex() && playlist[i].index == minIdx) {
          firstIndexInList = i;
          break;
        }
      }
      return _currentIndex == firstIndexInList;
    }
    return _currentIndex <= 0;
  }

  bool get _isLastTrack {
    final playlist = _effectivePlaylist;
    if (playlist.isEmpty) return true;
    final maxIdx = _maxIndex;
    if (maxIdx == null) return true;
    if (_allTracksHaveIndex &&
        _currentTrack != null &&
        _currentTrack!.hasIndex()) {
      final currentDocIndex = _currentTrack!.index;
      if (currentDocIndex != maxIdx) return false;
      int lastIndexInList = -1;
      for (int i = 0; i < playlist.length; i++) {
        if (playlist[i].hasIndex() && playlist[i].index == maxIdx) {
          lastIndexInList = i;
        }
      }
      return _currentIndex == lastIndexInList;
    }
    return _currentIndex >= playlist.length - 1;
  }

  bool get _isPreviousDisabled =>
      _effectivePlaylist.length <= 1 || _isFirstTrack || _isLoadingTrack;

  bool get _isNextDisabled =>
      _effectivePlaylist.length <= 1 || _isLastTrack || _isLoadingTrack;

  AudioRecord? get _nextTrack {
    final playlist = _effectivePlaylist;
    if (playlist.length <= 1 || _isLastTrack) return null;
    final nextIndex = _currentIndex + 1;
    if (nextIndex >= 0 && nextIndex < playlist.length) {
      return playlist[nextIndex];
    }
    return null;
  }

  AudioRecord? get _previousTrack {
    final playlist = _effectivePlaylist;
    if (playlist.length <= 1 || _isFirstTrack) return null;
    final prevIndex = _currentIndex - 1;
    if (prevIndex >= 0 && prevIndex < playlist.length) {
      return playlist[prevIndex];
    }
    return null;
  }

  void _switchToNextTrack() {
    final playlist = _effectivePlaylist;
    if (playlist.length <= 1) return;

    if (_allTracksHaveIndex &&
        _currentTrack != null &&
        _currentTrack!.hasIndex()) {
      final currentDocIndex = _currentTrack!.index;

      for (int i = _currentIndex + 1; i < playlist.length; i++) {
        final track = playlist[i];
        if (track.hasIndex() && track.index == currentDocIndex) {
          _currentIndex = i;
          _currentTrackUrl = track.audioPath;
          _reload();
          return;
        }
      }

      AudioRecord? nextTrack;
      int? nextTrackListIndex;
      int? minNextIndex;
      for (int i = 0; i < playlist.length; i++) {
        final track = playlist[i];
        if (track.hasIndex() && track.index > currentDocIndex) {
          if (minNextIndex == null || track.index < minNextIndex) {
            minNextIndex = track.index;
            nextTrack = track;
            nextTrackListIndex = i;
          }
        }
      }

      if (nextTrack != null && nextTrackListIndex != null) {
        _currentIndex = nextTrackListIndex;
        _currentTrackUrl = nextTrack.audioPath;
        _reload();
        return;
      }
    }

    _currentIndex = (_currentIndex + 1) % playlist.length;
    _currentTrackUrl = _currentTrack?.audioPath;
    _reload();
  }

  void _switchToPreviousTrack() {
    final playlist = _effectivePlaylist;
    if (playlist.length <= 1) return;

    if (_allTracksHaveIndex &&
        _currentTrack != null &&
        _currentTrack!.hasIndex()) {
      final currentDocIndex = _currentTrack!.index;

      for (int i = _currentIndex - 1; i >= 0; i--) {
        final track = playlist[i];
        if (track.hasIndex() && track.index == currentDocIndex) {
          _currentIndex = i;
          _currentTrackUrl = track.audioPath;
          _reload();
          return;
        }
      }

      AudioRecord? prevTrack;
      int? prevTrackListIndex;
      int? maxPrevIndex;
      for (int i = 0; i < playlist.length; i++) {
        final track = playlist[i];
        if (track.hasIndex() && track.index < currentDocIndex) {
          if (maxPrevIndex == null || track.index > maxPrevIndex) {
            maxPrevIndex = track.index;
            prevTrack = track;
            prevTrackListIndex = i;
          }
        }
      }

      if (prevTrack != null && prevTrackListIndex != null) {
        _currentIndex = prevTrackListIndex;
        _currentTrackUrl = prevTrack.audioPath;
        _reload();
        return;
      }
    }

    _currentIndex = (_currentIndex - 1 + playlist.length) % playlist.length;
    _currentTrackUrl = _currentTrack?.audioPath;
    _reload();
  }

  void _manualSwitchToNextTrack() {
    if (_isNextDisabled) return;
    _switchToNextTrack();
  }

  void _manualSwitchToPreviousTrack() {
    if (_isPreviousDisabled) return;
    _switchToPreviousTrack();
  }

  @override
  void initState() {
    super.initState();

    player = AudioPlayer();

    final playlist = _effectivePlaylist;
    if (playlist.isNotEmpty && widget.currentTrack != null) {
      final currentPath = widget.currentTrack!.audioPath;
      for (int i = 0; i < playlist.length; i++) {
        if (playlist[i].audioPath == currentPath) {
          _currentIndex = i;
          break;
        }
      }
    }

    _currentTrackUrl = _currentTrack?.audioPath;
    _init();
  }

  @override
  void didUpdateWidget(EnhancedPodcastPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    final newUrl = widget.currentTrack?.audioPath;
    if (newUrl != null && newUrl.isNotEmpty && newUrl != _currentTrackUrl) {
      if (widget.playlist != null) {
        for (int i = 0; i < widget.playlist!.length; i++) {
          if (widget.playlist![i].audioPath == newUrl) {
            _currentIndex = i;
            break;
          }
        }
      }
      _currentTrackUrl = newUrl;
      _reload();
    }
  }

  Future<void> _init() async {
    player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        if (repeatOne) {
          player
              .seek(Duration.zero)
              .then((_) => player.play().catchError((_) {}));
        } else {
          _switchToNextTrack();
        }
      }
    });

    player.durationStream.listen((_) {
      if (mounted) setState(() {});
    });

    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());

    await _reload(autoPlay: true, preservePosition: false);
  }

  Future<void> _precacheAroundTracks() async {
    if (_isPrecaching) return;
    _isPrecaching = true;

    try {
      final urls = <String>{};
      final prevUrl = _previousTrack?.audioPath;
      final nextUrl = _nextTrack?.audioPath;

      if (prevUrl != null &&
          prevUrl.isNotEmpty &&
          prevUrl != _loadedSourceKey) {
        urls.add(prevUrl);
      }
      if (nextUrl != null &&
          nextUrl.isNotEmpty &&
          nextUrl != _loadedSourceKey) {
        urls.add(nextUrl);
      }

      for (final url in urls) {
        try {
          await DefaultCacheManager().getSingleFile(url);
        } catch (_) {}
      }
    } finally {
      _isPrecaching = false;
    }
  }

  Future<void> _reload({
    bool autoPlay = true,
    bool preservePosition = false,
  }) async {
    final track = _currentTrack;
    if (track == null) return;

    final url = track.audioPath ?? '';
    if (url.isEmpty) return;

    final int token = ++_loadToken;

    if (mounted) {
      setState(() => _isLoadingTrack = true);
    } else {
      _isLoadingTrack = true;
    }

    try {
      final sourceChanged = _loadedSourceKey != url;

      if (sourceChanged) {
        cache = null;
        await player.stop();

        final loaded = await _loadForToken(token, track);
        if (!loaded || token != _loadToken) return;

        _loadedSourceKey = url;
      }

      if (token != _loadToken) return;

      if (!preservePosition) {
        await player.seek(Duration.zero);
      }

      if (token != _loadToken) return;

      if (autoPlay) {
        unawaited(player.play());

        await player.playerStateStream.firstWhere(
          (state) =>
              state.playing ||
              state.processingState == ProcessingState.ready ||
              state.processingState == ProcessingState.completed,
        );
      } else {
        await player.playerStateStream.firstWhere(
          (state) => state.processingState == ProcessingState.ready,
        );
      }

      if (token != _loadToken) return;

      unawaited(_precacheAroundTracks());
    } catch (_) {
    } finally {
      if (token == _loadToken) {
        if (mounted) {
          setState(() => _isLoadingTrack = false);
        } else {
          _isLoadingTrack = false;
        }
      }
    }
  }

  Future<bool> _loadForToken(int token, AudioRecord track) async {
    final url = track.audioPath ?? '';
    if (url.isEmpty) return false;

    String? localCache;

    try {
      final file = await DefaultCacheManager().getSingleFile(url);
      localCache = file.path;
    } catch (_) {
      localCache = null;
    }

    if (token != _loadToken) return false;

    final title = _normalizeTitle(track.audioTitle);
    final artist = _normalizeArtist(track.authorTitle);

    final source = AudioSource.uri(
      localCache != null ? Uri.file(localCache) : Uri.parse(url),
      tag: MediaItem(
        id: 'id$url',
        album: artist,
        title: title,
        artUri: track.image != null && track.image!.isNotEmpty
            ? Uri.parse(track.image!)
            : null,
      ),
    );

    await player.setAudioSource(source);

    if (token != _loadToken) return false;

    cache = localCache;
    return true;
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Stream<PosData> get _stream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PosData>(
        player.positionStream,
        player.bufferedPositionStream,
        player.durationStream,
        (pos, buf, dur) {
          final actualDur =
              (dur != null && dur.inMilliseconds > 0) ? dur : Duration.zero;
          return PosData(pos, buf, actualDur);
        },
      );

  @override
  Widget build(BuildContext context) {
    final track = _currentTrack;

    if (track == null) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: const Center(
          child: Text(
            'No track available',
            style: TextStyle(color: Color(0xA3FFD6AA)),
          ),
        ),
      );
    }

    const Color kPrimary = Color(0xE1FFD6AA);
    const Color kPrimaryDim = Color(0xA3FFD6AA);

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: StreamBuilder<PosData>(
        stream: _stream,
        builder: (context, snap) {
          final d = snap.data;
          final dur = d?.duration ?? Duration.zero;
          final pos = d?.position ?? Duration.zero;

          final maxD = max(
            dur.inMilliseconds > 0 ? dur.inMilliseconds.toDouble() : 60000.0,
            1.0,
          );
          final currentPos = drag ?? pos.inMilliseconds.toDouble();
          final displayDur = dur.inMilliseconds > 0 ? dur : Duration.zero;
          final progress = (currentPos / maxD).clamp(0.0, 1.0);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _displayCategory,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        height: 1.0,
                        letterSpacing: 20 * -0.06,
                        color: widget.authorColor ?? kPrimaryDim,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _displayTitle,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 28,
                        height: 32 / 28,
                        letterSpacing: 28 * -0.06,
                        color: widget.titleColor ?? kPrimary,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final barW = constraints.maxWidth;
                        final thumbX = progress * barW;

                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onHorizontalDragUpdate: (details) {
                            final box = context.findRenderObject() as RenderBox;
                            final localX =
                                box.globalToLocal(details.globalPosition).dx;
                            final ratio = (localX / barW).clamp(0.0, 1.0);
                            setState(() => drag = ratio * maxD);
                          },
                          onHorizontalDragEnd: (_) {
                            if (drag != null) {
                              player
                                  .seek(Duration(milliseconds: drag!.toInt()));
                              setState(() => drag = null);
                            }
                          },
                          onTapDown: (details) {
                            final ratio = (details.localPosition.dx / barW)
                                .clamp(0.0, 1.0);
                            player.seek(
                              Duration(milliseconds: (ratio * maxD).toInt()),
                            );
                          },
                          child: SizedBox(
                            height: 24,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  top: 10,
                                  child: Container(
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: widget.trackColor ??
                                          kPrimary.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  top: 10,
                                  child: Container(
                                    width: max(thumbX, 0),
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: widget.progressColor ?? kPrimary,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: thumbX - 1.5,
                                  top: 0,
                                  child: Container(
                                    width: 3,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: widget.progressColor ?? kPrimary,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _fmt(pos),
                            style: TextStyle(
                              fontFamily: 'Inter Tight',
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              height: 18 / 15,
                              color: widget.timeColor ?? kPrimary,
                            ),
                          ),
                          Text(
                            _fmt(displayDur),
                            style: TextStyle(
                              fontFamily: 'Inter Tight',
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              height: 18 / 15,
                              color: (widget.timeColor ?? kPrimary)
                                  .withOpacity(0.64),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 48,
                      height: 48,
                      child: GestureDetector(
                        onTap: _isPreviousDisabled
                            ? null
                            : _manualSwitchToPreviousTrack,
                        child: Center(
                          child: Opacity(
                            opacity: _isPreviousDisabled ? 0.4 : 1.0,
                            child: widget.kPrevious,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    StreamBuilder<PlayerState>(
                      stream: player.playerStateStream,
                      builder: (context, snapshot) {
                        final playing = snapshot.data?.playing ?? false;

                        return GestureDetector(
                          onTap: _isLoadingTrack
                              ? null
                              : () => playing ? player.pause() : player.play(),
                          child: Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              color: widget.playBtnColor ??
                                  const Color(0x1FFFFFFF),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0x1FFFFFFF),
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: _isLoadingTrack
                                  ? SizedBox(
                                      width: 26,
                                      height: 26,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.4,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          widget.timeColor ?? kPrimary,
                                        ),
                                      ),
                                    )
                                  : (playing ? widget.kpause : widget.kplay),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 48,
                      height: 48,
                      child: GestureDetector(
                        onTap:
                            _isNextDisabled ? null : _manualSwitchToNextTrack,
                        child: Center(
                          child: Opacity(
                            opacity: _isNextDisabled ? 0.4 : 1.0,
                            child: widget.kNext,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 56,
                      height: 56,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 28,
                        icon: _isCurrentTrackWished
                            ? widget.wishOn
                            : widget.wishOff,
                        onPressed: () async {
                          final current = _currentTrack;
                          if (current != null) await widget.onWish(current);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 56,
                      height: 56,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 28,
                        icon: widget.shareIcon,
                        onPressed: widget.onShare,
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 56,
                      height: 56,
                      child: GestureDetector(
                        onTap: () => setState(() => repeatOne = !repeatOne),
                        child: Center(
                          child:
                              repeatOne ? widget.kRepeatOne : widget.kRepeatOff,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _fmt(Duration d) => d.inHours > 0
      ? d.toString().split('.').first.padLeft(8, '0')
      : d.toString().substring(2, 7);
}

class PosData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
  PosData(this.position, this.bufferedPosition, this.duration);
}
