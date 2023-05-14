import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:web_browser/web/provider/webProvider.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  WebProvider? webProviderFalse;
  WebProvider? webProviderTrue;

  @override
  void initState() {
    super.initState();
    webProviderFalse?.pullToRefreshController=PullToRefreshController(
      onRefresh: () {
        webProviderFalse!.inAppWebViewController!.reload();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    webProviderFalse = Provider.of<WebProvider>(context, listen: false);
    webProviderTrue = Provider.of<WebProvider>(context, listen: true);
    return SafeArea(child: Scaffold(
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: webProviderFalse!.txtsearch,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          var search = webProviderFalse!.txtsearch!.text;
                          webProviderFalse!.inAppWebViewController!.loadUrl(
                              urlRequest: URLRequest(url: Uri.parse(
                                  "https://www.google.com/search?q=$search")));
                        },
                        icon: Icon(Icons.search, color: Colors.black,),
                      )
                  ),
                ),
                LinearProgressIndicator(
                  minHeight: 0.5,
                  value: webProviderTrue!.progress,
                ),
                Expanded(
                  child: InAppWebView(
                    initialUrlRequest: URLRequest(
                        url: Uri.parse("https://www.google.com/")),
                    onProgressChanged: (controller, progress) {
                      webProviderFalse!.inAppWebViewController = controller;
                      webProviderFalse!.chnage(progress/100.toDouble());
                    },
                    onLoadError: (controller, url, code, message) {
                      webProviderFalse!.inAppWebViewController = controller;
                    },
                    onLoadStop: (controller, url) {
                      webProviderFalse!.inAppWebViewController = controller;
                    },
                    onLoadStart: (controller, url) {
                      webProviderFalse!.inAppWebViewController = controller;
                    },
                    pullToRefreshController: webProviderFalse!.pullToRefreshController,
                  ),
                ),
                Container(
                  height: 40, width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(onPressed: () {
                        webProviderTrue!.inAppWebViewController?.goBack();
                      },
                          icon: Icon(Icons.arrow_back_ios_new, size: 20,
                            color: Colors.black,)),
                      IconButton(onPressed: () {

                      },
                          icon: Icon(Icons.bookmark_border, size: 20,
                            color: Colors.black,)),
                      IconButton(onPressed: () {
                        webProviderTrue!.inAppWebViewController?.reload();
                      },
                          icon: Icon(
                            Icons.refresh, size: 20, color: Colors.black,)),
                      IconButton(onPressed: () {

                      },
                          icon: Icon(Icons.favorite_border, size: 20,
                            color: Colors.black,)),
                      IconButton(onPressed: () {
                        webProviderTrue!.inAppWebViewController?.goForward();
                      },
                          icon: Icon(Icons.arrow_forward_ios, size: 20,
                            color: Colors.black,)),
                    ],
                  ),
                )
              ],
            ),
          )
      ),
    ));
  }
}
