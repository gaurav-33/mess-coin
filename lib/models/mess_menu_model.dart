class MessMenuModel {
  MessMenuModel({
    required this.breakfast,
    required this.lunch,
    required this.snacks,
    required this.dinner,
  });

  final List<String> breakfast;
  final List<String> lunch;
  final List<String> snacks;
  final List<String> dinner;

  MessMenuModel copyWith({
    List<String>? breakfast,
    List<String>? lunch,
    List<String>? snacks,
    List<String>? dinner,
  }) {
    return MessMenuModel(
      breakfast: breakfast ?? this.breakfast,
      lunch: lunch ?? this.lunch,
      snacks: snacks ?? this.snacks,
      dinner: dinner ?? this.dinner,
    );
  }

  factory MessMenuModel.fromJson(Map<String, dynamic> json) {
    return MessMenuModel(
      breakfast: json["breakfast"] == null
          ? []
          : List<String>.from(json["breakfast"]!.map((x) => x)),
      lunch: json["lunch"] == null
          ? []
          : List<String>.from(json["lunch"]!.map((x) => x)),
      snacks: json["snacks"] == null
          ? []
          : List<String>.from(json["snacks"]!.map((x) => x)),
      dinner: json["dinner"] == null
          ? []
          : List<String>.from(json["dinner"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "breakfast": breakfast.map((x) => x).toList(),
        "lunch": lunch.map((x) => x).toList(),
        "snacks": snacks.map((x) => x).toList(),
        "dinner": dinner.map((x) => x).toList(),
      };

  @override
  String toString() {
    return "$breakfast, $lunch, $snacks, $dinner, ";
  }
}
