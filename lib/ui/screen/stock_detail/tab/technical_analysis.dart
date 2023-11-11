import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../config/service/app_services.dart';

class TechnicalAnalysis extends StatefulWidget {
  final String stockCode;

  const TechnicalAnalysis({Key? key, required this.stockCode})
      : super(key: key);

  @override
  State<TechnicalAnalysis> createState() => _TechnicalAnalysisState();
}

class _TechnicalAnalysisState extends State<TechnicalAnalysis>
    with AutomaticKeepAliveClientMixin {
  late final WebViewController controller;
  late ThemeMode themeMode;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel('Toaster',
          onMessageReceived: (JavaScriptMessage message) {
        // ignore: deprecated_member_use
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message.message)),
        );
      })
      ..setBackgroundColor(Colors.transparent)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    themeMode = AppService.instance.themeMode.value;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadRequest(Uri.https(
          "https://info.sbsi.vn/chart/?symbol=${widget.stockCode}&language=vi&theme=${themeMode.isDark ? "dark" : "light"}",
          "chart", {
        "symbol": widget.stockCode,
        "language": "vi",
        "theme": themeMode.isDark ? "dark" : "light"
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WebViewWidget(controller: controller);
  }

  @override
  bool get wantKeepAlive => true;
}
