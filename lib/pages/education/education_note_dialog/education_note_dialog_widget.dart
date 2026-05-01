import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'education_note_dialog_model.dart';
export 'education_note_dialog_model.dart';

class EducationNoteDialogWidget extends StatefulWidget {
  const EducationNoteDialogWidget({
    super.key,
    required this.educationId,
  });

  final String? educationId;

  @override
  State<EducationNoteDialogWidget> createState() =>
      _EducationNoteDialogWidgetState();
}

class _EducationNoteDialogWidgetState extends State<EducationNoteDialogWidget> {
  late EducationNoteDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EducationNoteDialogModel());

    _model.messageFieldTextController1 ??= TextEditingController();
    _model.messageFieldFocusNode1 ??= FocusNode();

    _model.messageFieldTextController2 ??= TextEditingController();
    _model.messageFieldFocusNode2 ??= FocusNode();

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
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (responsiveVisibility(
          context: context,
          phone: false,
          tablet: false,
        ))
          Expanded(
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                logFirebaseEvent('EDUCATION_NOTE_DIALOG_Column_pwl2ef07_ON');
                logFirebaseEvent('Column_bottom_sheet');
                Navigator.pop(context);
              },
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(32.0),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 12.0,
                          sigmaY: 12.0,
                        ),
                        child: Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                            minHeight: MediaQuery.sizeOf(context).height * 0.8,
                            maxWidth: 600.0,
                            maxHeight: MediaQuery.sizeOf(context).height * 0.9,
                          ),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).white12,
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                          child: Stack(
                            alignment: AlignmentDirectional(0.0, 1.0),
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(1.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 16.0, 4.0),
                                          child: Container(
                                            width: 32.0,
                                            height: 32.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'БЛОКНОТ',
                                        style: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmallFamily,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                              lineHeight: 1.25,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .titleSmallIsCustom,
                                            ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(1.0, -1.0),
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              logFirebaseEvent(
                                                  'EDUCATION_NOTE_DIALOG_Container_r94p03iy');
                                              logFirebaseEvent(
                                                  'Container_bottom_sheet');
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              width: valueOrDefault<double>(
                                                () {
                                                  if (MediaQuery.sizeOf(context)
                                                          .width <
                                                      kBreakpointSmall) {
                                                    return 32.0;
                                                  } else if (MediaQuery.sizeOf(
                                                              context)
                                                          .width <
                                                      kBreakpointMedium) {
                                                    return 32.0;
                                                  } else if (MediaQuery.sizeOf(
                                                              context)
                                                          .width <
                                                      kBreakpointLarge) {
                                                    return 48.0;
                                                  } else {
                                                    return 48.0;
                                                  }
                                                }(),
                                                48.0,
                                              ),
                                              height: valueOrDefault<double>(
                                                () {
                                                  if (MediaQuery.sizeOf(context)
                                                          .width <
                                                      kBreakpointSmall) {
                                                    return 32.0;
                                                  } else if (MediaQuery.sizeOf(
                                                              context)
                                                          .width <
                                                      kBreakpointMedium) {
                                                    return 32.0;
                                                  } else if (MediaQuery.sizeOf(
                                                              context)
                                                          .width <
                                                      kBreakpointLarge) {
                                                    return 48.0;
                                                  } else {
                                                    return 48.0;
                                                  }
                                                }(),
                                                48.0,
                                              ),
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .white24,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                              child: Icon(
                                                FFIcons.kcloseIcon,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: valueOrDefault<double>(
                                                  () {
                                                    if (MediaQuery.sizeOf(
                                                                context)
                                                            .width <
                                                        kBreakpointSmall) {
                                                      return 24.0;
                                                    } else if (MediaQuery
                                                                .sizeOf(context)
                                                            .width <
                                                        kBreakpointMedium) {
                                                      return 24.0;
                                                    } else if (MediaQuery
                                                                .sizeOf(context)
                                                            .width <
                                                        kBreakpointLarge) {
                                                      return 32.0;
                                                    } else {
                                                      return 32.0;
                                                    }
                                                  }(),
                                                  32.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 8.0)),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 0.0, 20.0, 0.0),
                                      child: StreamBuilder<
                                          List<EducationModuleNotesRecord>>(
                                        stream: queryEducationModuleNotesRecord(
                                          queryBuilder:
                                              (educationModuleNotesRecord) =>
                                                  educationModuleNotesRecord
                                                      .where(
                                                        'educationId',
                                                        isEqualTo:
                                                            widget!.educationId !=
                                                                    ''
                                                                ? widget!
                                                                    .educationId
                                                                : null,
                                                      )
                                                      .orderBy('created_at',
                                                          descending: true),
                                        ),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 20.0,
                                                height: 20.0,
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          List<EducationModuleNotesRecord>
                                              listViewEducationModuleNotesRecordList =
                                              snapshot.data!;

                                          return ListView.separated(
                                            padding: EdgeInsets.fromLTRB(
                                              0,
                                              16.0,
                                              0,
                                              120.0,
                                            ),
                                            reverse: true,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount:
                                                listViewEducationModuleNotesRecordList
                                                    .length,
                                            separatorBuilder: (_, __) =>
                                                SizedBox(height: 16.0),
                                            itemBuilder:
                                                (context, listViewIndex) {
                                              final listViewEducationModuleNotesRecord =
                                                  listViewEducationModuleNotesRecordList[
                                                      listViewIndex];
                                              return Align(
                                                alignment: AlignmentDirectional(
                                                    1.0, 0.0),
                                                child: Container(
                                                  constraints: BoxConstraints(
                                                    maxWidth: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.75,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .white12,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(12.0),
                                                      topRight:
                                                          Radius.circular(12.0),
                                                      bottomLeft:
                                                          Radius.circular(12.0),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        if (listViewEducationModuleNotesRecord
                                                                    .text !=
                                                                null &&
                                                            listViewEducationModuleNotesRecord
                                                                    .text !=
                                                                '')
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        4.0,
                                                                        0.0,
                                                                        4.0,
                                                                        0.0),
                                                            child: Text(
                                                              listViewEducationModuleNotesRecord
                                                                  .text,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyLarge
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyLargeFamily,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    lineHeight:
                                                                        1.25,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .bodyLargeIsCustom,
                                                                  ),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ].addToStart(SizedBox(height: 28.0)),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 16.0, 20.0, 48.0),
                                child: Container(
                                  width: double.infinity,
                                  constraints: BoxConstraints(
                                    minHeight: 48.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).white12,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 24.0,
                                        color: Color(0x1F2A2929),
                                        offset: Offset(
                                          0.0,
                                          4.0,
                                        ),
                                        spreadRadius: 0.0,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(24.0),
                                    border: Border.all(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Stack(
                                    alignment: AlignmentDirectional(1.0, 0.0),
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        child: TextFormField(
                                          controller: _model
                                              .messageFieldTextController1,
                                          focusNode:
                                              _model.messageFieldFocusNode1,
                                          onChanged: (_) =>
                                              EasyDebounce.debounce(
                                            '_model.messageFieldTextController1',
                                            Duration(milliseconds: 500),
                                            () => safeSetState(() {}),
                                          ),
                                          onFieldSubmitted: (_) async {
                                            logFirebaseEvent(
                                                'EDUCATION_NOTE_DIALOG_messageField_ON_TE');
                                            if (_model.messageFieldTextController1
                                                        .text !=
                                                    null &&
                                                _model.messageFieldTextController1
                                                        .text !=
                                                    '') {
                                              logFirebaseEvent(
                                                  'messageField_backend_call');

                                              await EducationModuleNotesRecord
                                                  .collection
                                                  .doc()
                                                  .set(
                                                      createEducationModuleNotesRecordData(
                                                    createdAt:
                                                        getCurrentTimestamp,
                                                    createdBy: currentUserUid,
                                                    text: _model
                                                        .messageFieldTextController1
                                                        .text,
                                                    educationId:
                                                        widget!.educationId,
                                                  ));
                                              logFirebaseEvent(
                                                  'messageField_clear_text_fields_pin_codes');
                                              safeSetState(() {
                                                _model
                                                    .messageFieldTextController1
                                                    ?.clear();
                                              });
                                            }
                                          },
                                          autofocus: false,
                                          textInputAction: TextInputAction.send,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            isDense: false,
                                            labelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMediumFamily,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMediumIsCustom,
                                                    ),
                                            hintText:
                                                'Напишите заметки о курсе',
                                            hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontStyle,
                                                      ),
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontStyle,
                                                      lineHeight: 1.25,
                                                    ),
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            focusedErrorBorder:
                                                InputBorder.none,
                                            contentPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 50.0, 0.0),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                lineHeight: 1.25,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                          maxLines: 10,
                                          minLines: 1,
                                          cursorColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                          enableInteractiveSelection: true,
                                          validator: _model
                                              .messageFieldTextController1Validator
                                              .asValidator(context),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 2.0, 4.0, 2.0),
                                        child: Container(
                                          width: 40.0,
                                          height: 40.0,
                                          decoration: BoxDecoration(
                                            color: valueOrDefault<Color>(
                                              _model.messageFieldTextController1
                                                              .text ==
                                                          null ||
                                                      _model
                                                              .messageFieldTextController1
                                                              .text ==
                                                          ''
                                                  ? FlutterFlowTheme.of(context)
                                                      .white24
                                                  : FlutterFlowTheme.of(context)
                                                      .primary,
                                              FlutterFlowTheme.of(context)
                                                  .white24,
                                            ),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.transparent,
                                            ),
                                          ),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              logFirebaseEvent(
                                                  'EDUCATION_NOTE_DIALOG_Icon_vexpyxyc_ON_T');
                                              if (_model.messageFieldTextController1
                                                          .text !=
                                                      null &&
                                                  _model.messageFieldTextController1
                                                          .text !=
                                                      '') {
                                                logFirebaseEvent(
                                                    'Icon_backend_call');

                                                await EducationModuleNotesRecord
                                                    .collection
                                                    .doc()
                                                    .set(
                                                        createEducationModuleNotesRecordData(
                                                      createdAt:
                                                          getCurrentTimestamp,
                                                      createdBy: currentUserUid,
                                                      text: _model
                                                          .messageFieldTextController1
                                                          .text,
                                                      educationId:
                                                          widget!.educationId,
                                                    ));
                                                logFirebaseEvent(
                                                    'Icon_clear_text_fields_pin_codes');
                                                safeSetState(() {
                                                  _model
                                                      .messageFieldTextController1
                                                      ?.clear();
                                                });
                                              }
                                            },
                                            child: Icon(
                                              FFIcons.karrowUp,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 24.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (responsiveVisibility(
          context: context,
          tabletLandscape: false,
          desktop: false,
        ))
          Expanded(
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                logFirebaseEvent('EDUCATION_NOTE_DIALOG_Column_n9z2a9r2_ON');
                logFirebaseEvent('Column_bottom_sheet');
                Navigator.pop(context);
              },
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 48.0, 0.0, 8.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        logFirebaseEvent(
                            'EDUCATION_NOTE_DIALOG_Container_2rtvpmmq');
                        logFirebaseEvent('Container_haptic_feedback');
                        HapticFeedback.lightImpact();
                        logFirebaseEvent('Container_bottom_sheet');
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 48.0,
                        height: 6.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).accent2,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32.0),
                        topRight: Radius.circular(32.0),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 24.0,
                          sigmaY: 24.0,
                        ),
                        child: Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                            maxWidth: 600.0,
                            maxHeight: MediaQuery.sizeOf(context).height * 0.9,
                          ),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).dialog,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32.0),
                              topRight: Radius.circular(32.0),
                            ),
                          ),
                          child: Stack(
                            alignment: AlignmentDirectional(0.0, 1.0),
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(1.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 16.0, 4.0),
                                          child: Container(
                                            width: 32.0,
                                            height: 32.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'ЗАМЕТКА ОБ УРОКЕ',
                                        style: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMediumFamily,
                                              fontSize: 17.0,
                                              letterSpacing: 0.0,
                                              lineHeight: 1.25,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .titleMediumIsCustom,
                                            ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(1.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 16.0, 4.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              logFirebaseEvent(
                                                  'EDUCATION_NOTE_DIALOG_Container_eu664p49');
                                              logFirebaseEvent(
                                                  'Container_haptic_feedback');
                                              HapticFeedback.mediumImpact();
                                              logFirebaseEvent(
                                                  'Container_bottom_sheet');
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              width: 32.0,
                                              height: 32.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .white24,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                              child: Icon(
                                                FFIcons.kcloseIcon,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: 24.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 8.0)),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 0.0, 20.0, 0.0),
                                      child: StreamBuilder<
                                          List<EducationModuleNotesRecord>>(
                                        stream: queryEducationModuleNotesRecord(
                                          queryBuilder:
                                              (educationModuleNotesRecord) =>
                                                  educationModuleNotesRecord
                                                      .where(
                                                        'educationId',
                                                        isEqualTo:
                                                            widget!.educationId !=
                                                                    ''
                                                                ? widget!
                                                                    .educationId
                                                                : null,
                                                      )
                                                      .orderBy('created_at',
                                                          descending: true),
                                        ),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 20.0,
                                                height: 20.0,
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          List<EducationModuleNotesRecord>
                                              listViewEducationModuleNotesRecordList =
                                              snapshot.data!;

                                          return ListView.separated(
                                            padding: EdgeInsets.fromLTRB(
                                              0,
                                              16.0,
                                              0,
                                              120.0,
                                            ),
                                            reverse: true,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount:
                                                listViewEducationModuleNotesRecordList
                                                    .length,
                                            separatorBuilder: (_, __) =>
                                                SizedBox(height: 16.0),
                                            itemBuilder:
                                                (context, listViewIndex) {
                                              final listViewEducationModuleNotesRecord =
                                                  listViewEducationModuleNotesRecordList[
                                                      listViewIndex];
                                              return Align(
                                                alignment: AlignmentDirectional(
                                                    1.0, 0.0),
                                                child: Container(
                                                  constraints: BoxConstraints(
                                                    maxWidth: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.75,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .white12,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(12.0),
                                                      topRight:
                                                          Radius.circular(12.0),
                                                      bottomLeft:
                                                          Radius.circular(12.0),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        if (listViewEducationModuleNotesRecord
                                                                    .text !=
                                                                null &&
                                                            listViewEducationModuleNotesRecord
                                                                    .text !=
                                                                '')
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        4.0,
                                                                        0.0,
                                                                        4.0,
                                                                        0.0),
                                                            child: Text(
                                                              listViewEducationModuleNotesRecord
                                                                  .text,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyLarge
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyLargeFamily,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    lineHeight:
                                                                        1.25,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .bodyLargeIsCustom,
                                                                  ),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ].addToStart(SizedBox(height: 28.0)),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 16.0, 20.0, 48.0),
                                child: Container(
                                  width: double.infinity,
                                  constraints: BoxConstraints(
                                    minHeight: 48.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).white12,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 24.0,
                                        color: Color(0x1F2A2929),
                                        offset: Offset(
                                          0.0,
                                          4.0,
                                        ),
                                        spreadRadius: 0.0,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(24.0),
                                    border: Border.all(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Stack(
                                    alignment: AlignmentDirectional(1.0, 0.0),
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        child: TextFormField(
                                          controller: _model
                                              .messageFieldTextController2,
                                          focusNode:
                                              _model.messageFieldFocusNode2,
                                          onChanged: (_) =>
                                              EasyDebounce.debounce(
                                            '_model.messageFieldTextController2',
                                            Duration(milliseconds: 500),
                                            () => safeSetState(() {}),
                                          ),
                                          onFieldSubmitted: (_) async {
                                            logFirebaseEvent(
                                                'EDUCATION_NOTE_DIALOG_messageField_ON_TE');
                                            if (_model.messageFieldTextController2
                                                        .text !=
                                                    null &&
                                                _model.messageFieldTextController2
                                                        .text !=
                                                    '') {
                                              logFirebaseEvent(
                                                  'messageField_backend_call');

                                              await EducationModuleNotesRecord
                                                  .collection
                                                  .doc()
                                                  .set(
                                                      createEducationModuleNotesRecordData(
                                                    createdAt:
                                                        getCurrentTimestamp,
                                                    createdBy: currentUserUid,
                                                    text: _model
                                                        .messageFieldTextController2
                                                        .text,
                                                    educationId:
                                                        widget!.educationId,
                                                  ));
                                              logFirebaseEvent(
                                                  'messageField_clear_text_fields_pin_codes');
                                              safeSetState(() {
                                                _model
                                                    .messageFieldTextController2
                                                    ?.clear();
                                              });
                                            }
                                          },
                                          autofocus: false,
                                          textInputAction: TextInputAction.send,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            isDense: false,
                                            labelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMediumFamily,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMediumIsCustom,
                                                    ),
                                            hintText:
                                                'Напишите заметки о курсе',
                                            hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontStyle,
                                                      ),
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontStyle,
                                                      lineHeight: 1.25,
                                                    ),
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            focusedErrorBorder:
                                                InputBorder.none,
                                            contentPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 50.0, 0.0),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                lineHeight: 1.25,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                          maxLines: 10,
                                          minLines: 1,
                                          cursorColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                          enableInteractiveSelection: true,
                                          validator: _model
                                              .messageFieldTextController2Validator
                                              .asValidator(context),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 2.0, 4.0, 2.0),
                                        child: Container(
                                          width: 40.0,
                                          height: 40.0,
                                          decoration: BoxDecoration(
                                            color: valueOrDefault<Color>(
                                              _model.messageFieldTextController2
                                                              .text ==
                                                          null ||
                                                      _model
                                                              .messageFieldTextController2
                                                              .text ==
                                                          ''
                                                  ? FlutterFlowTheme.of(context)
                                                      .white24
                                                  : FlutterFlowTheme.of(context)
                                                      .primary,
                                              FlutterFlowTheme.of(context)
                                                  .white24,
                                            ),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.transparent,
                                            ),
                                          ),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              logFirebaseEvent(
                                                  'EDUCATION_NOTE_DIALOG_Icon_lt96wstk_ON_T');
                                              logFirebaseEvent(
                                                  'Icon_haptic_feedback');
                                              HapticFeedback.mediumImpact();
                                              if (_model.messageFieldTextController2
                                                          .text !=
                                                      null &&
                                                  _model.messageFieldTextController2
                                                          .text !=
                                                      '') {
                                                logFirebaseEvent(
                                                    'Icon_backend_call');

                                                await EducationModuleNotesRecord
                                                    .collection
                                                    .doc()
                                                    .set(
                                                        createEducationModuleNotesRecordData(
                                                      createdAt:
                                                          getCurrentTimestamp,
                                                      createdBy: currentUserUid,
                                                      text: _model
                                                          .messageFieldTextController2
                                                          .text,
                                                      educationId:
                                                          widget!.educationId,
                                                    ));
                                                logFirebaseEvent(
                                                    'Icon_clear_text_fields_pin_codes');
                                                safeSetState(() {
                                                  _model
                                                      .messageFieldTextController2
                                                      ?.clear();
                                                });
                                              }
                                            },
                                            child: Icon(
                                              FFIcons.karrowUp,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 24.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
