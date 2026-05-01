import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'nav_tab_model.dart';
export 'nav_tab_model.dart';

class NavTabWidget extends StatefulWidget {
  const NavTabWidget({
    super.key,
    double? tab,
    required this.icon,
    String? text,
  })  : this.tab = tab ?? 1.0,
        this.text = text ?? 'Главная';

  final double tab;
  final Widget? icon;
  final String text;

  @override
  State<NavTabWidget> createState() => _NavTabWidgetState();
}

class _NavTabWidgetState extends State<NavTabWidget> {
  late NavTabModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NavTabModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget!.icon!,
        AutoSizeText(
          valueOrDefault<String>(
            widget!.text,
            'Главная',
          ),
          maxLines: 1,
          style: FlutterFlowTheme.of(context).labelSmall.override(
                fontFamily: FlutterFlowTheme.of(context).labelSmallFamily,
                color: valueOrDefault<Color>(
                  widget!.tab == 1.0
                      ? FlutterFlowTheme.of(context).primaryText
                      : FlutterFlowTheme.of(context).secondaryText,
                  FlutterFlowTheme.of(context).primaryText,
                ),
                fontSize: 10.0,
                letterSpacing: 0.0,
                lineHeight: 1.4,
                useGoogleFonts:
                    !FlutterFlowTheme.of(context).labelSmallIsCustom,
              ),
        ),
      ],
    );
  }
}
