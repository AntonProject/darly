import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'audio_player_comp_model.dart';
export 'audio_player_comp_model.dart';

class AudioPlayerCompWidget extends StatefulWidget {
  const AudioPlayerCompWidget({
    super.key,
    this.currentTrack,
    required this.trackList,
    required this.link,
  });

  final AudioRecord? currentTrack;
  final List<AudioRecord>? trackList;
  final String? link;

  @override
  State<AudioPlayerCompWidget> createState() => _AudioPlayerCompWidgetState();
}

class _AudioPlayerCompWidgetState extends State<AudioPlayerCompWidget> {
  late AudioPlayerCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AudioPlayerCompModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => AuthUserStreamWidget(
        builder: (context) => Container(
          width: double.infinity,
          height: double.infinity,
          child: custom_widgets.EnhancedPodcastPlayer(
            width: double.infinity,
            height: double.infinity,
            kplay: Icon(
              FFIcons.kplay,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 36.0,
            ),
            kpause: Icon(
              FFIcons.kpause,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 36.0,
            ),
            shareIcon: Icon(
              FFIcons.kshare2,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 36.0,
            ),
            titleColor: FlutterFlowTheme.of(context).primaryText,
            authorColor: FlutterFlowTheme.of(context).secondaryText,
            timeColor: FlutterFlowTheme.of(context).secondaryText,
            kPrevious: Icon(
              FFIcons.kprevious,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 36.0,
            ),
            kNext: Icon(
              FFIcons.knext,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 36.0,
            ),
            kRepeatOff: Icon(
              FFIcons.krepeat1,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 36.0,
            ),
            kRepeatOne: Icon(
              FFIcons.krepeat,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 36.0,
            ),
            wishOn: Icon(
              FFIcons.klikeOn,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 36.0,
            ),
            wishOff: Icon(
              FFIcons.klikeOff,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 36.0,
            ),
            playBtnColor: FlutterFlowTheme.of(context).white12,
            progressColor: Color(0xFFFFD6AA),
            trackColor: Color(0x65FFD6AA),
            speedColor: FlutterFlowTheme.of(context).primaryText,
            speedSize: 17.0,
            currentTrack: widget!.currentTrack,
            playlist: widget!.trackList,
            userWishlist: (currentUserDocument?.wishAudioList?.toList() ?? []),
            onShare: () async {
              logFirebaseEvent('AUDIO_PLAYER_Container_r9hk7iog_CALLBACK');
              logFirebaseEvent('EnhancedPodcastPlayer_share');
              unawaited(
                () async {
                  await Share.share(
                    widget!.link!,
                    sharePositionOrigin: getWidgetBoundingBox(context),
                  );
                }(),
              );
            },
            onWish: (currentTrack) async {
              logFirebaseEvent('AUDIO_PLAYER_Container_r9hk7iog_CALLBACK');
              if ((currentUserDocument?.wishAudioList?.toList() ?? [])
                  .contains(currentTrack.reference.id)) {
                logFirebaseEvent('EnhancedPodcastPlayer_backend_call');

                await currentUserReference!.update({
                  ...mapToFirestore(
                    {
                      'wishAudioList':
                          FieldValue.arrayRemove([currentTrack.reference.id]),
                    },
                  ),
                });
              } else {
                logFirebaseEvent('EnhancedPodcastPlayer_backend_call');

                await currentUserReference!.update({
                  ...mapToFirestore(
                    {
                      'wishAudioList':
                          FieldValue.arrayUnion([currentTrack.reference.id]),
                    },
                  ),
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
