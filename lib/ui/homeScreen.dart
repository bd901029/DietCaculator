import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as debugger;

class HomePage extends StatefulWidget {
	HomePage({Key key, this.title}) : super(key: key);

	// This widget is the home page of your application. It is stateful, meaning
	// that it has a State object (defined below) that contains fields that affect
	// how it looks.

	// This class is the configuration for the state. It holds the values (in this
	// case the title) provided by the parent (in this case the App widget) and
	// used by the build method of the State. Fields in a Widget subclass are
	// always marked "final".

	final String title;

	@override
	HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

	final myController = TextEditingController();

	List searchResults = [];
	int totalCalories = 100;

	@override
	void ini

	HomePage() {
		myController.addListener(onSearchKeyChanged);
	}

	onSearchKeyChanged() {
		debugger.debugger();
		print("${myController.text}");
		setState(() {
		});
	}

	void onAddBtnTapped() {
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
				title: new Text('Diet Calculator'),
			),
			body: Column(
				crossAxisAlignment: CrossAxisAlignment.center,
				children: <Widget>[
					Container(
						margin: EdgeInsets.symmetric(vertical: 20),
						alignment: Alignment.center,
						child: Text("Total Caloies: 0", style: TextStyle(color: Colors.blue, fontSize: 30)),
					),
					Container(
						margin: EdgeInsets.symmetric(horizontal: 20),
						alignment: Alignment.center,
						decoration: BoxDecoration(
							color: Color.fromARGB(50, 0, 0, 0),
							borderRadius: BorderRadius.all(Radius.circular(10))
						),
						child: Row(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: <Widget>[
								Expanded(
									flex: 1,
									child: Container(
										padding: EdgeInsets.all(5),
										child: TextFormField(
											decoration: InputDecoration(
												border: InputBorder.none,
												hintText: "Search Food...",
												icon: Icon(Icons.search),
											),
											controller: myController,
										),
									),
								)
							],
						),
					),
					Expanded(
						child: Padding(
							padding: EdgeInsets.symmetric(horizontal: 20),
							child: ListView.builder(
								scrollDirection: Axis.vertical,
								itemCount: 100,
								itemBuilder: (BuildContext context, int index) {
									return ListTile(
										leading: Icon(Icons.add),
										title: Text("$index"),
										onTap: () {
											print('tapped');
										},
									);
								}
							),
						),
					),
				],
			),
			floatingActionButton: FloatingActionButton(
				onPressed: onAddBtnTapped,
				tooltip: 'Add',
				child: Icon(Icons.add),
			), // This trailing comma makes auto-formatting nicer for build methods.
		);
	}
}