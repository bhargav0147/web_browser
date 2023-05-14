import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebProvider extends ChangeNotifier
{
  InAppWebViewController? inAppWebViewController;
  TextEditingController? txtsearch=TextEditingController();
  PullToRefreshController? pullToRefreshController;
  double progress=0;
  void chnage(double index)
  {
    progress=index;
    notifyListeners();
  }
}