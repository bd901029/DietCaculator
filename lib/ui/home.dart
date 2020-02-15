import 'package:cached_network_image/cached_network_image.dart';
import 'package:diet_calculator/engine/food.dart';
import 'package:diet_calculator/engine/foodManager.dart';
import 'package:diet_calculator/engine/urlManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'splash.dart';

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

	final foodManager = FoodManager();

	List<Food> searchResults = [];
	List<Food> foods = [];
	int totalCalories = 0;

	@override
	void initState() {
		super.initState();

		// Start listening to changes.
		myController.addListener(onSearchKeyChanged);
		foodManager.addListener(onSearchFinished);

		UrlManager.sharedInstance().addListener(onUrlReceived);
	}

	@override
	void dispose() {
		// Clean up the controller when the widget is removed from the
		// widget tree.
		myController.dispose();
		UrlManager.sharedInstance().removeListener(onUrlReceived);
		super.dispose();
	}

	onUrlReceived() {
		print("Opening Splash....");
		Navigator.push(
			context,
			MaterialPageRoute(builder: (context) => SplashPage()),
		);
	}

	onSearchKeyChanged() {
		String key = myController.text;
		if (key == null || key == "") {
			setState(() {
				searchResults = [];
			});
			return;
		}

		foodManager.searchByName(key);
	}

	onSearchResultSelected(int index) {
		if (searchResults.length <= 0) {
			return;
		}
		
		foods.add(searchResults[index]);
		int calories = 0;
		for (var food in foods) {
			calories = calories + food.calories;
		}

		setState(() {
			searchResults = [];
			myController.text = "";
			totalCalories = calories;
		});
	}

	Future<void> onBarcodeBtnTapped() async {
		String barcode = await FlutterBarcodeScanner.scanBarcode(
			"#ff6666", "Cancel", false, ScanMode.DEFAULT);
		foodManager.searchByBarcode(barcode);
	}

	void onSearchFinished() {
		setState(() {
			searchResults = foodManager.searchResults;
		});
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
						child: Text("Total Caloies: $totalCalories",
							style: TextStyle(color: Colors.blue, fontSize: 30)),
					),
					Container(
						margin: EdgeInsets.symmetric(horizontal: 20),
						alignment: Alignment.center,
						decoration: BoxDecoration(
							color: Color.fromARGB(50, 0, 0, 0),
							borderRadius: BorderRadius.all(Radius.circular(10))),
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
							padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
							child: ListView.builder(
								scrollDirection: Axis.vertical,
								itemCount: searchResults.length > 0
									? searchResults.length
									: foods.length,
								itemBuilder: (BuildContext context, int index) {
									return ListTile(
										leading: Padding(
											padding: EdgeInsets.all(10),
											child: CachedNetworkImage(
												errorWidget: (context, url, error) =>
													Icon(Icons.error),
												imageUrl:
												"${searchResults.length > 0 ? searchResults[index].imageUrl : foods[index].imageUrl}",
											),
										),
										title: Text(
											"${searchResults.length > 0 ? searchResults[index].name : foods[index].name}"),
										trailing: Text("${searchResults.length > 0 ? searchResults[index].calories : foods[index].calories}"),
										onTap: () {
											if (searchResults.length <= 0) return;
											onSearchResultSelected(index);
										},
									);
								}),
						),
					),
				],
			),
			floatingActionButton: FloatingActionButton(
				onPressed: onBarcodeBtnTapped,
				tooltip: 'Scan Barcode',
				child: Icon(Icons.photo_camera),
			), // This trailing comma makes auto-formatting nicer for build methods.
		);
	}
}
