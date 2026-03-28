import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'custom_app_bar.dart';
import 'loading_widget.dart';

class WebPageScreen extends StatefulWidget {
  const WebPageScreen({super.key, required this.link, required this.title});

  final String link;
  final String title;

  @override
  State<WebPageScreen> createState() => _WebPageScreenState();
}

class _WebPageScreenState extends State<WebPageScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            if (mounted) setState(() => _isLoading = true);
          },
          onPageFinished: (_) {
            if (mounted) setState(() => _isLoading = false);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.link));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading) Center(child: LogoLoaderWidget()),
        ],
      ),
    );
  }
}
