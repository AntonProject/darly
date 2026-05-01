import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/education/review_dialog/review_dialog_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'review_model.dart';
export 'review_model.dart';

class ReviewWidget extends StatefulWidget {
  const ReviewWidget({
    super.key,
    this.reviewDoc,
    String? educationTitle,
  }) : this.educationTitle = educationTitle ?? 'unnamed';

  final EducationReviewsRecord? reviewDoc;
  final String educationTitle;

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  late ReviewModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReviewModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        logFirebaseEvent('REVIEW_COMP_Container_lug7u1dv_ON_TAP');
        logFirebaseEvent('Container_haptic_feedback');
        HapticFeedback.lightImpact();
        logFirebaseEvent('Container_bottom_sheet');
        showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          useSafeArea: true,
          context: context,
          builder: (context) {
            return WebViewAware(
              child: Padding(
                padding: MediaQuery.viewInsetsOf(context),
                child: ReviewDialogWidget(
                  review: widget!.reviewDoc!,
                  educationTitle: widget!.educationTitle,
                ),
              ),
            );
          },
        ).then((value) => safeSetState(() {}));
      },
      child: Container(
        width: 320.0,
        height: 210.0,
        constraints: BoxConstraints(
          maxWidth: 600.0,
        ),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).white12,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).white12,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 56.0,
                    height: 56.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).white12,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).white12,
                      ),
                    ),
                    child: Builder(
                      builder: (context) {
                        if (widget!.reviewDoc?.userPhoto != null &&
                            widget!.reviewDoc?.userPhoto != '') {
                          return Container(
                            width: 56.0,
                            height: 56.0,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: CachedNetworkImage(
                              fadeInDuration: Duration(milliseconds: 500),
                              fadeOutDuration: Duration(milliseconds: 500),
                              imageUrl: getCORSProxyUrl(
                                widget!.reviewDoc!.userPhoto,
                              ),
                              fit: BoxFit.cover,
                              errorWidget: (context, error, stackTrace) =>
                                  Image.asset(
                                'assets/images/error_image.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        } else {
                          return Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Text(
                              valueOrDefault<String>(
                                functions.nameLettters(
                                    widget!.reviewDoc?.userName, ''),
                                'WN',
                              ),
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .titleLargeFamily,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    lineHeight: 1.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .titleLargeIsCustom,
                                  ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          valueOrDefault<String>(
                            widget!.reviewDoc?.userName,
                            'unnamed',
                          ).toUpperCase(),
                          style: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleSmallFamily,
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                lineHeight: 1.24,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .titleSmallIsCustom,
                              ),
                        ),
                        if (responsiveVisibility(
                          context: context,
                          phone: false,
                          tablet: false,
                          tabletLandscape: false,
                          desktop: false,
                        ))
                          Text(
                            valueOrDefault<String>(
                              '${valueOrDefault<String>(
                                widget!.reviewDoc != null ? 'до ' : 'после ',
                                'до ',
                              )}${widget!.educationTitle}',
                              'до WOMAN 2.0',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelMediumFamily,
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  lineHeight: 1.25,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelMediumIsCustom,
                                ),
                          ),
                      ].divide(SizedBox(height: 4.0)),
                    ),
                  ),
                ].divide(SizedBox(width: 12.0)),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                child: Text(
                  valueOrDefault<String>(
                    widget!.reviewDoc?.reviewBefore,
                    '-',
                  ),
                  maxLines: 4,
                  style: FlutterFlowTheme.of(context).labelMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).labelMediumFamily,
                        fontSize: 15.0,
                        letterSpacing: 0.0,
                        lineHeight: 1.25,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).labelMediumIsCustom,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if ((widget!.reviewDoc!.reviewBefore.length ?? 0) > 125)
                Text(
                  'СМОТРЕТЬ ПОЛНОСТЬЮ',
                  style: FlutterFlowTheme.of(context).titleMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).titleMediumFamily,
                        color: FlutterFlowTheme.of(context).primary,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).titleMediumIsCustom,
                      ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
