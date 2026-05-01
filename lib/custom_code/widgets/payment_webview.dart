// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart';
import 'package:flutter/gestures.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class PaymentWebview extends StatefulWidget {
  const PaymentWebview({
    super.key,
    this.width,
    this.height,
    this.html,
  });

  final double? width;
  final double? height;
  final String? html;

  @override
  State<PaymentWebview> createState() => _PaymentWebviewState();
}

class _PaymentWebviewState extends State<PaymentWebview>
    with AutomaticKeepAliveClientMixin {
  static Widget? _staticWebView;
  static String? _lastHtmlContent;
  static bool _isInitialized = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _createStaticWebView();
  }

  void _createStaticWebView() {
    if (!_isInitialized && widget.html != null && widget.html!.isNotEmpty) {
      _lastHtmlContent = widget.html;
      _staticWebView = _buildWebViewWidget();
      _isInitialized = true;
    }
  }

  Widget _buildWebViewWidget() {
    final double w = widget.width ?? MediaQuery.sizeOf(context).width;
    final double h = widget.height ?? MediaQuery.sizeOf(context).height * 0.8;

    return Container(
      width: w,
      height: h,
      // Transparent container so page background shows through
      color: Colors.transparent,
      child: WebViewX(
        key: ValueKey(
            'static_payment_webview_${DateTime.now().millisecondsSinceEpoch}'),
        width: w,
        height: h,
        ignoreAllGestures: false,
        initialContent: widget.html!,
        initialSourceType: SourceType.html,
        initialMediaPlaybackPolicy:
            AutoMediaPlaybackPolicy.requireUserActionForAllMediaTypes,
        javascriptMode: JavascriptMode.unrestricted,
        webSpecificParams: const WebSpecificParams(
          webAllowFullscreenContent: true,
        ),
        mobileSpecificParams: MobileSpecificParams(
          debuggingEnabled: false,
          gestureNavigationEnabled: true,
          androidEnableHybridComposition: true,
          // Allow transparent background on Android WebView
        ),
        onWebViewCreated: (controller) {
          // Set transparent background after WebView is created
          // This removes the default white background of the WebView
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(PaymentWebview oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (_staticWebView != null) {
      return _staticWebView!;
    }
    return _buildWebViewWidget();
  }

  static void resetWebView() {
    _staticWebView = null;
    _lastHtmlContent = null;
    _isInitialized = false;
  }
}
