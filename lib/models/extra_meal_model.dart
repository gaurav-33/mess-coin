class ExtraMealModel {
    ExtraMealModel({
        required this.breakfast,
        required this.lunch,
        required this.dinner,
    });

    final List<Meal> breakfast;
    final List<Meal> lunch;
    final List<Meal> dinner;

    ExtraMealModel copyWith({
        List<Meal>? breakfast,
        List<Meal>? lunch,
        List<Meal>? dinner,
    }) {
        return ExtraMealModel(
            breakfast: breakfast ?? this.breakfast,
            lunch: lunch ?? this.lunch,
            dinner: dinner ?? this.dinner,
        );
    }

    factory ExtraMealModel.fromJson(Map<String, dynamic> json){ 
        return ExtraMealModel(
            breakfast: json["breakfast"] == null ? [] : List<Meal>.from(json["breakfast"]!.map((x) => Meal.fromJson(x))),
            lunch: json["lunch"] == null ? [] : List<Meal>.from(json["lunch"]!.map((x) => Meal.fromJson(x))),
            dinner: json["dinner"] == null ? [] : List<Meal>.from(json["dinner"]!.map((x) => Meal.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "breakfast": breakfast.map((x) => x.toJson()).toList(),
        "lunch": lunch.map((x) => x.toJson()).toList(),
        "dinner": dinner.map((x) => x.toJson()).toList(),
    };

    @override
    String toString(){
        return "$breakfast, $lunch, $dinner, ";
    }
}

class Meal {
    Meal({
        required this.name,
        required this.price,
    });

    final String? name;
    final String? price;

    Meal copyWith({
        String? name,
        String? price,
    }) {
        return Meal(
            name: name ?? this.name,
            price: price ?? this.price,
        );
    }

    factory Meal.fromJson(Map<String, dynamic> json){ 
        return Meal(
            name: json["name"],
            price: json["price"],
        );
    }

    Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
    };

    @override
    String toString(){
        return "$name, $price, ";
    }
}
