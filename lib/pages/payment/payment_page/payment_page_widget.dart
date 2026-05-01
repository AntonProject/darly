import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/back_button/back_button_widget.dart';
import '/components/empty_list/empty_list_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'payment_page_model.dart';
export 'payment_page_model.dart';

class PaymentPageWidget extends StatefulWidget {
  const PaymentPageWidget({super.key});

  static String routeName = 'PaymentPage';
  static String routePath = '/paymentPage';

  @override
  State<PaymentPageWidget> createState() => _PaymentPageWidgetState();
}

class _PaymentPageWidgetState extends State<PaymentPageWidget> {
  late PaymentPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PaymentPageModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'PaymentPage'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('PAYMENT_PaymentPage_ON_INIT_STATE');
      logFirebaseEvent('PaymentPage_custom_action');
      unawaited(
        () async {
          await actions.setStatusBarColor();
        }(),
      );
      logFirebaseEvent('PaymentPage_custom_action');
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
    return Title(
        title: 'PaymentPage',
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
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.asset(
                    'assets/images/Background.webp',
                  ).image,
                ),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 54.0, 0.0, 0.0),
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
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                          action: () async {
                            logFirebaseEvent(
                                'PAYMENT_Container_znb78tw9_CALLBACK');
                            logFirebaseEvent('backButton_navigate_back');
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
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 16.0, 20.0, 16.0),
                                child: Text(
                                  'ВЫБЕРИТЕ ТАРИФ',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .headlineMediumFamily,
                                        letterSpacing: 0.0,
                                        lineHeight: 1.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .headlineMediumIsCustom,
                                      ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 8.0, 20.0, 0.0),
                                child: FutureBuilder<List<PaymentsRecord>>(
                                  future: queryPaymentsRecordOnce(
                                    queryBuilder: (paymentsRecord) =>
                                        paymentsRecord
                                            .where(
                                              'single',
                                              isEqualTo: true,
                                            )
                                            .orderBy('index'),
                                  ),
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: SizedBox(
                                          width: 20.0,
                                          height: 20.0,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    List<PaymentsRecord>
                                        columnPaymentsRecordList =
                                        snapshot.data!;

                                    return SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: List.generate(
                                                columnPaymentsRecordList.length,
                                                (columnIndex) {
                                          final columnPaymentsRecord =
                                              columnPaymentsRecordList[
                                                  columnIndex];
                                          return InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              logFirebaseEvent(
                                                  'PAYMENT_Container_1cxjhspu_ON_TAP');
                                              logFirebaseEvent(
                                                  'Container_update_page_state');
                                              _model.period =
                                                  columnPaymentsRecord.period;
                                              _model
                                                  .price = columnPaymentsRecord
                                                          .newPriceDate! >
                                                      getCurrentTimestamp
                                                  ? columnPaymentsRecord.price
                                                  : columnPaymentsRecord
                                                      .newPrice;
                                              _model.paymentId =
                                                  columnPaymentsRecord
                                                      .reference.id;
                                              safeSetState(() {});
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .white12,
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: Image.network(
                                                    getCORSProxyUrl(
                                                      valueOrDefault<String>(
                                                        _model.paymentId ==
                                                                columnPaymentsRecord
                                                                    .reference
                                                                    .id
                                                            ? 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/woman-103qa6/assets/rsq4apy9m3f3/Plan_Details_Container-2.webp'
                                                            : 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/woman-103qa6/assets/tqi22pm8zmtn/Plan_Details_Container-1.webp',
                                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/woman-103qa6/assets/vn015msvzrlk/plan_details_container1.webp',
                                                      ),
                                                    ),
                                                  ).image,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                                border: Border.all(
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        20.0, 24.0, 20.0, 24.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              -1.0, 0.0),
                                                      child: Text(
                                                        valueOrDefault<String>(
                                                          columnPaymentsRecord
                                                              .title,
                                                          'Без обратной связи',
                                                        ).toUpperCase(),
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .titleMedium
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMediumFamily,
                                                              fontSize: 20.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              lineHeight: 1.0,
                                                              useGoogleFonts:
                                                                  !FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMediumIsCustom,
                                                            ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              -1.0, 0.0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    16.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Builder(
                                                          builder: (context) {
                                                            final features =
                                                                columnPaymentsRecord
                                                                    .features
                                                                    .toList();
                                                            if (features
                                                                .isEmpty) {
                                                              return EmptyListWidget();
                                                            }

                                                            return Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: List.generate(
                                                                  features
                                                                      .length,
                                                                  (featuresIndex) {
                                                                final featuresItem =
                                                                    features[
                                                                        featuresIndex];
                                                                return Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          24.0,
                                                                      height:
                                                                          24.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        image:
                                                                            DecorationImage(
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          image:
                                                                              Image.asset(
                                                                            'assets/images/Feature_Icon_Container.png',
                                                                          ).image,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          featuresItem,
                                                                          'Доступ к материалам на 3 месяца',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                              fontSize: 15.0,
                                                                              letterSpacing: 0.0,
                                                                              lineHeight: 1.25,
                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      width:
                                                                          8.0)),
                                                                );
                                                              }).divide(SizedBox(
                                                                  height:
                                                                      16.0)),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  16.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(56.0),
                                                        child: BackdropFilter(
                                                          filter:
                                                              ImageFilter.blur(
                                                            sigmaX: 12.0,
                                                            sigmaY: 12.0,
                                                          ),
                                                          child: FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              logFirebaseEvent(
                                                                  'PAYMENT_PAGE_PAGE_Button_905b2amx_ON_TAP');
                                                              logFirebaseEvent(
                                                                  'Button_haptic_feedback');
                                                              HapticFeedback
                                                                  .selectionClick();
                                                              logFirebaseEvent(
                                                                  'Button_backend_call');

                                                              var orderRecordReference =
                                                                  OrderRecord
                                                                      .collection
                                                                      .doc();
                                                              await orderRecordReference
                                                                  .set(
                                                                      createOrderRecordData(
                                                                rlUser:
                                                                    currentUserReference,
                                                                date:
                                                                    getCurrentTimestamp,
                                                                status: 'new',
                                                                description:
                                                                    'Получите все возможности приложения по цене похода в кафе',
                                                                price: _model
                                                                    .price,
                                                                currency: 'RUB',
                                                                clientEmail:
                                                                    currentUserEmail,
                                                                paid: false,
                                                                amount: (_model
                                                                            .price!)
                                                                        .round() ??
                                                                    0,
                                                                recurrentInterval:
                                                                    'Month',
                                                                recurrentPeriod:
                                                                    _model
                                                                        .period,
                                                                clientId:
                                                                    currentUserUid,
                                                              ));
                                                              _model.newOrder =
                                                                  OrderRecord.getDocumentFromData(
                                                                      createOrderRecordData(
                                                                        rlUser:
                                                                            currentUserReference,
                                                                        date:
                                                                            getCurrentTimestamp,
                                                                        status:
                                                                            'new',
                                                                        description:
                                                                            'Получите все возможности приложения по цене похода в кафе',
                                                                        price: _model
                                                                            .price,
                                                                        currency:
                                                                            'RUB',
                                                                        clientEmail:
                                                                            currentUserEmail,
                                                                        paid:
                                                                            false,
                                                                        amount:
                                                                            (_model.price!).round() ??
                                                                                0,
                                                                        recurrentInterval:
                                                                            'Month',
                                                                        recurrentPeriod:
                                                                            _model.period,
                                                                        clientId:
                                                                            currentUserUid,
                                                                      ),
                                                                      orderRecordReference);
                                                              logFirebaseEvent(
                                                                  'Button_navigate_to');

                                                              context.pushNamed(
                                                                CloudPaymentPageWidget
                                                                    .routeName,
                                                                queryParameters:
                                                                    {
                                                                  'orderRef':
                                                                      serializeParam(
                                                                    _model
                                                                        .newOrder
                                                                        ?.reference,
                                                                    ParamType
                                                                        .DocumentReference,
                                                                  ),
                                                                }.withoutNulls,
                                                              );

                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            text: _model.paymentId ==
                                                                    columnPaymentsRecord
                                                                        .reference
                                                                        .id
                                                                ? valueOrDefault<
                                                                    String>(
                                                                    'Купить – ${functions.priceFormat(columnPaymentsRecord.newPriceDate! > getCurrentTimestamp ? columnPaymentsRecord.price : columnPaymentsRecord.newPrice)}₽',
                                                                    'Купить – 39990₽',
                                                                  )
                                                                : valueOrDefault<
                                                                    String>(
                                                                    'Купить – ${functions.priceFormat(columnPaymentsRecord.newPriceDate! > getCurrentTimestamp ? columnPaymentsRecord.price : columnPaymentsRecord.newPrice)}₽',
                                                                    'Купить – 39990₽',
                                                                  ),
                                                            options:
                                                                FFButtonOptions(
                                                              width: double
                                                                  .infinity,
                                                              height: 56.0,
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          16.0,
                                                                          0.0),
                                                              iconPadding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .white12,
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).titleSmallFamily,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        fontSize:
                                                                            17.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        useGoogleFonts:
                                                                            !FlutterFlowTheme.of(context).titleSmallIsCustom,
                                                                      ),
                                                              elevation: 0.0,
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .white12,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          56.0),
                                                            ),
                                                            showLoadingIndicator:
                                                                false,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    if ((columnPaymentsRecord
                                                                .newPriceDate! >
                                                            getCurrentTimestamp) &&
                                                        (columnPaymentsRecord
                                                                .newPrice !=
                                                            null))
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    16.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: RichText(
                                                          textScaler:
                                                              MediaQuery.of(
                                                                      context)
                                                                  .textScaler,
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text:
                                                                    valueOrDefault<
                                                                        String>(
                                                                  '${functions.priceFormat(columnPaymentsRecord.newPrice)}₽',
                                                                  '45.000₽',
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .titleMediumFamily,
                                                                      fontSize:
                                                                          24.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.25,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .titleMediumIsCustom,
                                                                    ),
                                                              ),
                                                              TextSpan(
                                                                text:
                                                                    ' c ${dateTimeFormat(
                                                                  "d MMMM",
                                                                  columnPaymentsRecord
                                                                      .newPriceDate,
                                                                  locale: FFLocalizations.of(
                                                                          context)
                                                                      .languageCode,
                                                                )}',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .titleMediumFamily,
                                                                      color: valueOrDefault<
                                                                          Color>(
                                                                        _model.paymentId ==
                                                                                columnPaymentsRecord.reference.id
                                                                            ? FlutterFlowTheme.of(context).primary80
                                                                            : FlutterFlowTheme.of(context).secondaryText,
                                                                        FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                      ),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.25,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .titleMediumIsCustom,
                                                                    ),
                                                              )
                                                            ],
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .titleMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMediumFamily,
                                                                  fontSize:
                                                                      24.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  lineHeight:
                                                                      1.25,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleMediumIsCustom,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        })
                                            .divide(SizedBox(height: 20.0))
                                            .addToEnd(SizedBox(height: 48.0)),
                                      ),
                                    );
                                  },
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
        ));
  }
}
