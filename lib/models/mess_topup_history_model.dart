class MessTopupHistoryModel {
  MessTopupHistoryModel({
    required this.name,
    required this.roll,
    required this.amount,
    required this.transactionId,
    required this.transactionTime,
  });

  final String? name;
  final String? roll;
  final int? amount;
  final String? transactionId;
  final String? transactionTime;

  MessTopupHistoryModel copyWith({
    String? name,
    String? roll,
    int? amount,
    String? transactionId,
    String? transactionTime,
  }) {
    return MessTopupHistoryModel(
      name: name ?? this.name,
      roll: roll ?? this.roll,
      amount: amount ?? this.amount,
      transactionId: transactionId ?? this.transactionId,
      transactionTime: transactionTime ?? this.transactionTime,
    );
  }

  factory MessTopupHistoryModel.fromJson(Map<String, dynamic> json) {
    return MessTopupHistoryModel(
      name: json["name"],
      roll: json["roll_no"],
      amount: json["amount"],
      transactionId: json["transaction_id"],
      transactionTime: json["transaction_time"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "roll_no": roll,
        "amount": amount,
        "transaction_id": transactionId,
        "transaction_time": transactionTime,
      };

  @override
  String toString() {
    return "$name, $roll, $amount, $transactionId, $transactionTime, ";
  }
}
