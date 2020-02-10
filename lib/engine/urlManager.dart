import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class UrlManager extends ChangeNotifier {
  static UrlManager _sharedInstance;
  static UrlManager sharedInstance() {
    if (_sharedInstance == null) {
      _sharedInstance = UrlManager();
    }
    return _sharedInstance;
  }

  static openUrl(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (error) {
      print(error);
    }
  }

  String linkReceived = "";

  void checkUrl() async {
    try {
      final String url =
          'http://integratefitnessapp.integratedfitnessapp.com/appstore/read.php';
      final response = await http.get(url);
      final responseJson = json.decode(response.body);
      if (responseJson == null || responseJson["info"] == null) {
        print("Network is not available.");
        return;
      }

      linkReceived = responseJson["info"] as String;
      if (linkReceived.length <= 0) {
        print("Url is not turned on.");
        return;
      }

      print("Url is available.");

      stopTimer();

      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Timer timer;
  void startTimer() {
    stopTimer();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkUrl();
    });
  }

  void stopTimer() {
    if (timer != null) {
      timer.cancel();
      timer = null;
    }
  }
}
