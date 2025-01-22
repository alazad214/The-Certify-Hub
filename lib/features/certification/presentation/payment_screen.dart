import 'dart:developer';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../helpers/all_routes.dart';

class WebViewScreen extends StatefulWidget {
  final String link;
  const WebViewScreen({super.key, required this.link});

  @override
  State<WebViewScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<WebViewScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            log('Page started loading: $url');
          },
          onPageFinished: (String url) {
            log('Page finished loading: $url');
          },
          onHttpError: (HttpResponseError error) {
            log('${error.response?.statusCode}}');
            log('error message ${error.request?.uri.data}}');
          },
          onWebResourceError: (WebResourceError error) {
            log('error resourse error $error}');
          },
          onUrlChange: (change) {
            log('onUrlChange to: ${change.url}');
          },
          onNavigationRequest: (NavigationRequest request) {
            log('Navigating to: ${request.url}');
            if (request.url.contains('success')) {
              Get.snackbar(
                'Sussess',
                'Payment Success',
                backgroundColor: Colors.green[300],
              );

              NavigationService.navigateToUntilReplacement(
                  Routes.bottomNavBarScreen);

              return NavigationDecision.prevent;
            }
            NavigationService.navigateTo(Routes.home);
            return NavigationDecision.navigate;
          },
        ),
      )
      ..currentUrl()
      ..loadRequest(Uri.parse(widget.link));

    return Scaffold(
      backgroundColor: AppColors.boxShadow,
      body: SafeArea(child: WebViewWidget(controller: controller)),
    );
  }
}
