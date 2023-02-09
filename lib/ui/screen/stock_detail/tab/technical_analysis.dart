import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TechnicalAnalysis extends StatefulWidget {
  final String stockCode;

  const TechnicalAnalysis({Key? key, required this.stockCode}) : super(key: key);

  @override
  State<TechnicalAnalysis> createState() => _TechnicalAnalysisState();
}

class _TechnicalAnalysisState extends State<TechnicalAnalysis>
    with AutomaticKeepAliveClientMixin {

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.all(16),
      child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          backgroundColor: Colors.transparent,
          javascriptChannels: <JavascriptChannel>{
            _toasterJavascriptChannel(context),
          },
          initialUrl:
          "https://info.sbsi.vn/chart/?symbol=${widget.stockCode}&language=vi&theme=dark"),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }
}
