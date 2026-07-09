import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'meta_card_comp_model.dart';
export 'meta_card_comp_model.dart';

class MetaCardCompWidget extends StatefulWidget {
  const MetaCardCompWidget({super.key});

  @override
  State<MetaCardCompWidget> createState() => _MetaCardCompWidgetState();
}

class _MetaCardCompWidgetState extends State<MetaCardCompWidget> {
  late MetaCardCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MetaCardCompModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.asset(
        'assets/images/CardNew.webp',
        width: 90.0,
        height: 140.0,
        fit: BoxFit.fill,
      ),
    );
  }
}
