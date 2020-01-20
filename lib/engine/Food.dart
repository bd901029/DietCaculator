import 'dart:ffi';

class FoodResponseKey {
	static String Name = "food_name";
	static String Thumb = "thumb";
	static String Calories = "calories";
}

class Food {
	String name = "TEST";
	String imageUrl = "TEST";
	double calories = 0.0;

	Food.create(Map<String, dynamic> json) {
		this.name = json[FoodResponseKey.Name];
		this.imageUrl = json[FoodResponseKey.Thumb];
		this.calories = json[FoodResponseKey.Calories];
	}
}