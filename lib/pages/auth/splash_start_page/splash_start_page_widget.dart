import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'splash_start_page_model.dart';
export 'splash_start_page_model.dart';

class SplashStartPageWidget extends StatefulWidget {
  const SplashStartPageWidget({super.key});

  static String routeName = 'splashStartPage';
  static String routePath = '/splashStartPage';

  @override
  State<SplashStartPageWidget> createState() => _SplashStartPageWidgetState();
}

class _SplashStartPageWidgetState extends State<SplashStartPageWidget> {
  late SplashStartPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SplashStartPageModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'splashStartPage'});
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
        title: 'splashStartPage',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Container(
              width: double.infinity,
              height: double.infinity,
              child: custom_widgets.FullScreenVideo(
                width: double.infinity,
                height: double.infinity,
                videoUrl:
                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/woman-103qa6/assets/vtc11yrlhemz/final_pro_658-ezgif.com-mute-video.mp4',
                looping: false,
                autoPlay: true,
                radius: 0.0,
                onVideoEnd: () async {
                  logFirebaseEvent('SPLASH_START_Container_7l2oyzbn_CALLBACK');
                  logFirebaseEvent('FullScreenVideo_navigate_to');

                  context.goNamed(
                    SplashPageWidget.routeName,
                    extra: <String, dynamic>{
                      '__transition_info__': TransitionInfo(
                        hasTransition: true,
                        transitionType: PageTransitionType.fade,
                        duration: Duration(milliseconds: 0),
                      ),
                    },
                  );
                },
              ),
            ),
          ),
        ));
  }
}
