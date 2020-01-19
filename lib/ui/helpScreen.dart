import 'package:flutter/material.dart';
import 'homeScreen.dart';

class HelpPage extends StatefulWidget {
	HelpPage({Key key, this.title}) : super(key: key);

	// This widget is the home page of your application. It is stateful, meaning
	// that it has a State object (defined below) that contains fields that affect
	// how it looks.

	// This class is the configuration for the state. It holds the values (in this
	// case the title) provided by the parent (in this case the App widget) and
	// used by the build method of the State. Fields in a Widget subclass are
	// always marked "final".

	final String title;

	@override
	HelpPageState createState() => HelpPageState();
}

class HelpPageState extends State<HelpPage> {
	int counter = 0;

	void onNextBtnTapped() {
		Navigator.push(
			context,
			MaterialPageRoute(builder: (context) => HomePage(title: 'Diet Calculator')),
		);
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
			appBar: AppBar(
				// Here we take the value from the MyHomePage object that was created by
				// the App.build method, and use it to set our appbar title.
				title: Text(widget.title),
			),
			body: Center(
				// Center is a layout widget. It takes a single child and positions it
				// in the middle of the parent.
				child: Column(
					// Column is also a layout widget. It takes a list of children and
					// arranges them vertically. By default, it sizes itself to fit its
					// children horizontally, and tries to be as tall as its parent.
					//
					// Invoke "debug painting" (press "p" in the console, choose the
					// "Toggle Debug Paint" action from the Flutter Inspector in Android
					// Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
					// to see the wireframe for each widget.
					//
					// Column has various properties to control how it sizes itself and
					// how it positions its children. Here we use mainAxisAlignment to
					// center the children vertically; the main axis here is the vertical
					// axis because Columns are vertical (the cross axis would be
					// horizontal).
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						new Expanded(
							flex: 1,
							child: new SingleChildScrollView(
								child: new Text(
									"Nutrition is the science of food and its relationship to health. Nutrients are chemicals in foods that are used by the body for growth, maintenance, and energy."+"\n"+
										"\n"+
										"Nutrients that cannot be synthesized by the body and thus must be derived from the diet are considered essential. They include" + "\n" +
										"\n"+
										"Vitamins" + "\n" +
										"Minerals" + "\n" +
										"Some amino acids" + "\n" +
										"Some fatty acids" + "\n" +
										"\n"+
										"Nutrients that the body can synthesize from other compounds, although they may also be derived from the diet, are considered nonessential." + "\n" +
										"\n"+
										"Macronutrients are required by the body in relatively large amounts; micronutrients are needed in minute amounts." + "\n" +
										"\n"+
										"Lack of nutrients can result in undernutrition, which can lead to deficiency syndromes (eg, kwashiorkor, pellagra). Excess intake of macronutrients can lead to obesity and related disorders; excess intake of micronutrients can be toxic. Also, the balance of various types of nutrients, such as how much unsaturated vs saturated fat is consumed, can influence the development of disorders.",
									style: new TextStyle(
										fontSize: 25.0, color: Colors.black,
									),
								),
								padding: new EdgeInsets.all(25),
							),
						),
					],
				),
			),
			floatingActionButton: FloatingActionButton(
				onPressed: onNextBtnTapped,
				tooltip: 'Next',
				child: Icon(Icons.skip_next),
			), // This trailing comma makes auto-formatting nicer for build methods.
		);
	}
}