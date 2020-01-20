import 'dart:convert';
import 'dart:ffi';

import 'package:diet_calculator/engine/food.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class FoodManager extends ChangeNotifier {
	List<Food> searchResults = [];

	static String NUTRITIONIX_ID = "2b7eb7fc";
	static String NUTRITIONIX_KEY = "7ff2633984803ffd3e48b0e4ff03ab88";

	void searchByName(String key) async {
		final String url = "https://trackapi.nutritionix.com/v2/search/instant";
		final response = await http.post(url,
			body: jsonEncode({"query": key, "branded": true, "detailed": true}),
			headers: {
				"Content-Type": "application/json",
				"x-app-id": NUTRITIONIX_ID,
				"x-app-key": NUTRITIONIX_KEY
			});
		final responseJson = json.decode(response.body);
		if (responseJson == null || responseJson["branded"] == null) {
			return;
		}

		final foodResponse = responseJson["branded"];

		List<dynamic> jsonFoods = List.from(foodResponse);

		searchResults = [];
		for (int i = 0; i < jsonFoods.length; i++) {
			searchResults.add(Food.create(jsonFoods[i]));
		}

		notifyListeners();
	}

	void searchByBarcode(String barcode) async {
		String url =
			"https://trackapi.nutritionix.com/v2/search/item?upc=" + barcode;
		final response = await http.get(url, headers: {
			"Content-Type": "application/json",
			"x-app-id": NUTRITIONIX_ID,
			"x-app-key": NUTRITIONIX_KEY
		});
		final responseJson = json.decode(response.body);
		if (responseJson == null || responseJson["foods"] == null) {
			return;
		}

		final foodResponse = responseJson["foods"];

		List<dynamic> jsonFoods = List.from(foodResponse);

		searchResults = [];
		for (int i = 0; i < jsonFoods.length; i++) {
			searchResults.add(Food.create(jsonFoods[i]));
		}

		notifyListeners();
	}
}
