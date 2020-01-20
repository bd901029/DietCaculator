import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class SplashPage extends StatefulWidget {
	@override
	SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {

	openUrl() async {

	}

	@override
	Widget build(BuildContext context) {
		// This method is rerun every time setState is called, for instance as done
		// by the _incrementCounter method above.
		//
		// The Flutter framework has been optimized to make rerunning build methods
		// fast, so that you can just rebuild anything that needs updating rather
		// than having to individually change instances of widgets.
		return Scaffold(
			body: Stack(
				children: <Widget>[
					WebView(
						initialUrl: 'https://www.861711.com/',
						javascriptMode: JavascriptMode.unrestricted,
					),
					GestureDetector(
						onTap:(){
							openUrl();
						}
					)
				],
			),
			floatingActionButton: FloatingActionButton(
				onPressed: () {
					Navigator.pop(context);
				},
				tooltip: 'Back',
				child: Icon(Icons.arrow_back),
			),
		);
	}
}