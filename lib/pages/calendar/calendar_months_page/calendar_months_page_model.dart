import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/back_button/back_button_widget.dart';
import '/components/month_day/month_day_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'calendar_months_page_widget.dart' show CalendarMonthsPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CalendarMonthsPageModel
    extends FlutterFlowModel<CalendarMonthsPageWidget> {
  ///  Local state fields for this page.

  bool edit = false;

  List<MonthCycleStruct> cycles = [];
  void addToCycles(MonthCycleStruct item) => cycles.add(item);
  void removeFromCycles(MonthCycleStruct item) => cycles.remove(item);
  void removeAtIndexFromCycles(int index) => cycles.removeAt(index);
  void insertAtIndexInCycles(int index, MonthCycleStruct item) =>
      cycles.insert(index, item);
  void updateCyclesAtIndex(int index, Function(MonthCycleStruct) updateFn) =>
      cycles[index] = updateFn(cycles[index]);

  ///  State fields for stateful widgets in this page.

  // Model for backButton component.
  late BackButtonModel backButtonModel;
  // Models for monthDay dynamic component.
  late FlutterFlowDynamicModels<MonthDayModel> monthDayModels;

  @override
  void initState(BuildContext context) {
    backButtonModel = createModel(context, () => BackButtonModel());
    monthDayModels = FlutterFlowDynamicModels(() => MonthDayModel());
  }

  @override
  void dispose() {
    backButtonModel.dispose();
    monthDayModels.dispose();
  }
}
