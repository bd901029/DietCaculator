class FoodResponseKey {
	static String name = "food_name";
	static String photo = "photo";
	static String thumb = "thumb";
	static String calories = "nf_calories";
}

class Food {
	String name = "TEST";
	String imageUrl = "TEST";
	int calories = 0;

	Food.create(Map<String, dynamic> json) {
		this.name = json[FoodResponseKey.name] == null
			? "Unknown"
			: json[FoodResponseKey.name] as String;
		this.imageUrl = json[FoodResponseKey.photo][FoodResponseKey.thumb] == null
			? ""
			: json[FoodResponseKey.photo][FoodResponseKey.thumb] as String;
		this.calories = json[FoodResponseKey.calories] == null
			? 0
			: json[FoodResponseKey.calories] as int;
	}
}
