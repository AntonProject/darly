import '/components/back_button/back_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'image_expand_model.dart';
export 'image_expand_model.dart';

class ImageExpandWidget extends StatefulWidget {
  const ImageExpandWidget({
    super.key,
    required this.image,
  });

  final String? image;

  @override
  State<ImageExpandWidget> createState() => _ImageExpandWidgetState();
}

class _ImageExpandWidgetState extends State<ImageExpandWidget> {
  late ImageExpandModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ImageExpandModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 1.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: Image.asset(
            'assets/images/Background.webp',
          ).image,
        ),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(0.0),
            child: CachedNetworkImage(
              fadeInDuration: Duration(milliseconds: 500),
              fadeOutDuration: Duration(milliseconds: 500),
              imageUrl: getCORSProxyUrl(
                widget!.image!,
              ),
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          Align(
            alignment: AlignmentDirectional(1.0, -1.0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 54.0, 12.0, 0.0),
              child: wrapWithModel(
                model: _model.backButtonModel,
                updateCallback: () => safeSetState(() {}),
                child: BackButtonWidget(
                  icon: Icon(
                    FFIcons.kcloseIcon,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 28.0,
                  ),
                  action: () async {
                    logFirebaseEvent(
                        'IMAGE_EXPAND_Container_bs4fo5xr_CALLBACK');
                    logFirebaseEvent('backButton_bottom_sheet');
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0.0, 1.0),
            child: Builder(
              builder: (context) => Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 12.0, 20.0, 48.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    logFirebaseEvent('IMAGE_EXPAND_COMP__BTN_ON_TAP');
                    logFirebaseEvent('Button_share');
                    await Share.share(
                      functions.imagePathToString(widget!.image)!,
                      sharePositionOrigin: getWidgetBoundingBox(context),
                    );
                    logFirebaseEvent('Button_bottom_sheet');
                    Navigator.pop(context);
                  },
                  text: 'ПОДЕЛИТЬСЯ',
                  icon: Icon(
                    FFIcons.kshare2,
                    size: 24.0,
                  ),
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 56.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconColor: FlutterFlowTheme.of(context).primaryText,
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).titleSmallFamily,
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 17.0,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).titleSmallIsCustom,
                        ),
                    elevation: 0.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(56.0),
                  ),
                  showLoadingIndicator: false,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
