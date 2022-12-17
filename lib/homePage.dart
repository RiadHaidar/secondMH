import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

var url = 'https://mahaassembly.in/';

class Homepage extends StatelessWidget {
  InAppWebViewController? webView;

  Future<bool> _onWillPop(BuildContext context) async {
    if (await webView!.canGoBack()) {
      webView!.goBack();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: AppBar(),
        body: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(url)),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform:
                InAppWebViewOptions(useShouldOverrideUrlLoading: true),
          ),
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            final url = navigationAction.request.url.toString();
            String action =
                navigationAction.request.url!.toString().split(':').first;
            List<String> customActions = ['tel', 'whatsapp', 'mailto'];
            bool isCustomAction = customActions.contains(action);

            if (isCustomAction) {
              canLaunchUrl(Uri.parse(url)).then((value) {
                launchUrl(Uri.parse(url),
                    mode: LaunchMode.externalNonBrowserApplication);
              });
              // and cancel the request
              return NavigationActionPolicy.CANCEL;
            } else if (url.startsWith("https://mhassembly.in/")) {
              //
              print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
              return NavigationActionPolicy.ALLOW;
            } else if (url.startsWith("https://wa.me/")) {
              //pr
              //  canLaunchUrl(Uri.parse(request.url)).then((value) {
              //   launchUrl(Uri.parse(request.url),
              //       mode: LaunchMode.externalApplication);
              // }).then((value) => isHome=false);

              print('condition of whatsapp');
              return NavigationActionPolicy.ALLOW;
            } else {
              //    _controller!.goBack();
              canLaunchUrl(Uri.parse(url)).then((value) {
                launchUrl(Uri.parse(url),
                    mode: LaunchMode.externalNonBrowserApplication);
              }).then((value) {
                webView!.stopLoading();
                webView!.goBack();
                 });

              print('not whatever');
//                   // Default decision
/*
  webView?.goBack();*/

              return NavigationActionPolicy.ALLOW;
            }
          },
        ),
      ),
    );
  }
}
