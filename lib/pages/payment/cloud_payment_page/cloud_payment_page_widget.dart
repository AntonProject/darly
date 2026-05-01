import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/back_button/back_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/payment/fail_payment/fail_payment_widget.dart';
import '/pages/payment/success_payment/success_payment_widget.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'cloud_payment_page_model.dart';
export 'cloud_payment_page_model.dart';

class CloudPaymentPageWidget extends StatefulWidget {
  const CloudPaymentPageWidget({
    super.key,
    required this.orderRef,
  });

  final DocumentReference? orderRef;

  static String routeName = 'CloudPaymentPage';
  static String routePath = '/cloudPaymentPage';

  @override
  State<CloudPaymentPageWidget> createState() => _CloudPaymentPageWidgetState();
}

class _CloudPaymentPageWidgetState extends State<CloudPaymentPageWidget> {
  late CloudPaymentPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CloudPaymentPageModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'CloudPaymentPage'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('CLOUD_PAYMENT_CloudPaymentPage_ON_INIT_S');
      logFirebaseEvent('CloudPaymentPage_custom_action');
      unawaited(
        () async {
          await actions.lockLandscapeMode();
        }(),
      );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<OrderRecord>(
      stream: OrderRecord.getDocument(widget!.orderRef!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }

        final cloudPaymentPageOrderRecord = snapshot.data!;

        return Title(
            title: 'CloudPaymentPage',
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
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 54.0, 0.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (valueOrDefault<bool>(
                          (cloudPaymentPageOrderRecord.status != 'succeeded') &&
                              (cloudPaymentPageOrderRecord.status !=
                                  'cancelled'),
                          true,
                        ))
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                  child: wrapWithModel(
                                    model: _model.backButtonModel,
                                    updateCallback: () => safeSetState(() {}),
                                    child: BackButtonWidget(
                                      icon: Icon(
                                        FFIcons.kleftIcon3,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 24.0,
                                      ),
                                      action: () async {
                                        logFirebaseEvent(
                                            'CLOUD_PAYMENT_Container_2r196ze7_CALLBAC');
                                        logFirebaseEvent(
                                            'backButton_navigate_back');
                                        context.safePop();
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth: 600.0,
                                    ),
                                    decoration: BoxDecoration(),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 24.0, 0.0, 0.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Container(
                                          width: double.infinity,
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.75,
                                          child: custom_widgets.PaymentWebview(
                                            width: double.infinity,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.75,
                                            html: functions
                                                .createCloudPaymentsWebViewSubs(
                                                    widget!.orderRef?.id,
                                                    cloudPaymentPageOrderRecord
                                                        .clientEmail,
                                                    cloudPaymentPageOrderRecord
                                                        .clientId,
                                                    cloudPaymentPageOrderRecord
                                                        .description,
                                                    cloudPaymentPageOrderRecord
                                                        .amount
                                                        .toDouble(),
                                                    valueOrDefault<String>(
                                                      valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.role,
                                                                  '') ==
                                                              'admin'
                                                          ? getRemoteConfigString(
                                                              'cloudTestKey')
                                                          : getRemoteConfigString(
                                                              'cloudKey'),
                                                      'pk_d07912a5de0f0bbad69bb4889e3be',
                                                    ),
                                                    cloudPaymentPageOrderRecord
                                                        .currency,
                                                    false,
                                                    true,
                                                    cloudPaymentPageOrderRecord
                                                        .recurrentInterval,
                                                    cloudPaymentPageOrderRecord
                                                        .recurrentPeriod,
                                                    cloudPaymentPageOrderRecord
                                                        .price,
                                                    null,
                                                    Color(0x03000000),
                                                    Color(0x1FFFFFFF),
                                                    Color(0x1FFFFFFF),
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                    valueOrDefault<bool>(
                                                      valueOrDefault<bool>(
                                                        valueOrDefault(
                                                                    currentUserDocument
                                                                        ?.subscriptionId,
                                                                    '') ==
                                                                null ||
                                                            valueOrDefault(
                                                                    currentUserDocument
                                                                        ?.subscriptionId,
                                                                    '') ==
                                                                '',
                                                        true,
                                                      )
                                                          ? true
                                                          : false,
                                                      true,
                                                    ),
                                                    3,
                                                    valueOrDefault<int>(
                                                      getRemoteConfigInt(
                                                          'taxationSystem'),
                                                      1,
                                                    ),
                                                    getRemoteConfigString(
                                                        'vat')),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (valueOrDefault<bool>(
                          cloudPaymentPageOrderRecord.status == 'succeeded',
                          false,
                        ))
                          Expanded(
                            child: wrapWithModel(
                              model: _model.successPaymentModel,
                              updateCallback: () => safeSetState(() {}),
                              child: SuccessPaymentWidget(
                                parameter1: cloudPaymentPageOrderRecord.status,
                              ),
                            ),
                          ),
                        if (valueOrDefault<bool>(
                          cloudPaymentPageOrderRecord.status == 'cancelled',
                          false,
                        ))
                          Expanded(
                            child: wrapWithModel(
                              model: _model.failPaymentModel,
                              updateCallback: () => safeSetState(() {}),
                              child: FailPaymentWidget(),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}
