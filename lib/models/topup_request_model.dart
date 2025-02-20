class TopupRequestModel {
  TopupRequestModel({
    required this.uid,
    required this.rollNo,
    required this.name,
    required this.amount,
    required this.transactionId,
    required this.transactionTime,
  });

  final String? uid;
  final String? rollNo;
  final String? name;
  final int? amount;
  final String? transactionId;
  final String? transactionTime;

  TopupRequestModel copyWith({
    String? uid,
    String? rollNo,
    String? name,
    int? amount,
    String? transactionId,
    String? transactionTime,
  }) {
    return TopupRequestModel(
      uid: uid ?? this.uid,
      rollNo: rollNo ?? this.rollNo,
      name:  name ?? this.name,
      amount: amount ?? this.amount,
      transactionId: transactionId ?? this.transactionId,
      transactionTime: transactionTime ?? this.transactionTime,
    );
  }

  factory TopupRequestModel.fromJson(Map<String, dynamic> json) {
    return TopupRequestModel(
      uid: json["uid"],
      rollNo: json["roll_no"],
      name: json["name"],
      amount: json["amount"],
      transactionId: json["transaction_id"],
      transactionTime: json["transaction_time"],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "roll_no": rollNo,
        "name":name,
        "amount": amount,
        "transaction_id": transactionId,
        "transaction_time": transactionTime,
      };

  @override
  String toString() {
    return "$uid, $rollNo, $name, $amount, $transactionId, $transactionTime, ";
  }
}
