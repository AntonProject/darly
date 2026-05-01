import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_list/empty_list_widget.dart';
import '/components/navbar/navbar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/education/education_info_dialog/education_info_dialog_widget.dart';
import '/pages/education/education_module_comp/education_module_comp_widget.dart';
import '/pages/education/education_note_dialog/education_note_dialog_widget.dart';
import '/pages/education/review/review_widget.dart';
import '/web/navbar_web/navbar_web_widget.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'education_page_widget.dart' show EducationPageWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class EducationPageModel extends FlutterFlowModel<EducationPageWidget> {
  ///  Local state fields for this page.

  String? selectedItem = 'Новое';

  ///  State fields for stateful widgets in this page.

  // Model for navbarWeb component.
  late NavbarWebModel navbarWebModel;
  // State field(s) for Column widget.
  ScrollController? columnController1;
  // State field(s) for Row widget.
  ScrollController? rowController;
  // State field(s) for reviewsListView widget.
  ScrollController? reviewsListViewScrollController;
  // State field(s) for Column widget.
  ScrollController? columnController2;
  // Model for navbar component.
  late NavbarModel navbarModel;

  @override
  void initState(BuildContext context) {
    navbarWebModel = createModel(context, () => NavbarWebModel());
    columnController1 = ScrollController();
    rowController = ScrollController();
    reviewsListViewScrollController = ScrollController();
    columnController2 = ScrollController();
    navbarModel = createModel(context, () => NavbarModel());
  }

  @override
  void dispose() {
    navbarWebModel.dispose();
    columnController1?.dispose();
    rowController?.dispose();
    reviewsListViewScrollController?.dispose();
    columnController2?.dispose();
    navbarModel.dispose();
  }
}
