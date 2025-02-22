class StudentModel {
  StudentModel({
    required this.name,
    required this.rollNo,
    required this.email,
    required this.profileUrl,
    required this.uid,
    required this.currentSem,
    required this.status,
    required this.isVerified,
    required this.totalCredit,
    required this.leftCredit,
    required this.leftOverCredit,
    required this.currentBal,
    required this.topupHistory,
    required this.hostel,
    required this.createdAt,
    required this.updatedAt,
    required this.lastActive,
    required this.createdBy,
    required this.updatedBy,
    required this.leaveHistory,
  });

  final String? name;
  final String? rollNo;
  final String? email;
  final String? profileUrl;
  final String? uid;
  final int? currentSem;
  final String? status;
  final bool? isVerified;
  final int? totalCredit;
  final int? leftCredit;
  final int? leftOverCredit;
  final int? currentBal;
  final List<TopupHistory> topupHistory;
  final Hostel? hostel;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? lastActive;
  final String? createdBy;
  final String? updatedBy;
  final List<LeaveHistory> leaveHistory;

  StudentModel copyWith({
    String? name,
    String? rollNo,
    String? email,
    String? profileUrl,
    String? uid,
    String? mpin,
    int? currentSem,
    String? status,
    bool? isVerified,
    int? totalCredit,
    int? leftCredit,
    int? leftOverCredit,
    int? currentBal,
    List<TopupHistory>? topupHistory,
    Hostel? hostel,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastActive,
    String? createdBy,
    String? updatedBy,
    List<LeaveHistory>? leaveHistory,
  }) {
    return StudentModel(
      name: name ?? this.name,
      rollNo: rollNo ?? this.rollNo,
      email: email ?? this.email,
      profileUrl: profileUrl ?? this.profileUrl,
      uid: uid ?? this.uid,
      currentSem: currentSem ?? this.currentSem,
      status: status ?? this.status,
      isVerified: isVerified ?? this.isVerified,
      totalCredit: totalCredit ?? this.totalCredit,
      leftCredit: leftCredit ?? this.leftCredit,
      leftOverCredit: leftOverCredit ?? this.leftOverCredit,
      currentBal: currentBal ?? this.currentBal,
      topupHistory: topupHistory ?? this.topupHistory,
      hostel: hostel ?? this.hostel,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastActive: lastActive ?? this.lastActive,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      leaveHistory: leaveHistory ?? this.leaveHistory,
    );
  }

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      name: json["name"],
      rollNo: json["roll_no"],
      email: json["email"],
      profileUrl: json["profile_url"],
      uid: json["uid"],
      currentSem: json["current_sem"],
      status: json["status"],
      isVerified: json["is_verified"],
      totalCredit: json["total_credit"],
      leftCredit: json["left_credit"],
      leftOverCredit: json["left_over_credit"],
      currentBal: json["current_bal"],
      topupHistory: json["topup_history"] == null
          ? []
          : List<TopupHistory>.from(
              json["topup_history"]!.map((x) => TopupHistory.fromJson(x))),
      hostel: json["hostel"] == null ? null : Hostel.fromJson(json["hostel"]),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      lastActive: DateTime.tryParse(json["last_active"] ?? ""),
      createdBy: json["created_by"],
      updatedBy: json["updated_by"],
      leaveHistory: json["leave_history"] == null
          ? []
          : List<LeaveHistory>.from(
              json["leave_history"]!.map((x) => LeaveHistory.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "roll_no": rollNo,
        "email": email,
        "uid": uid,
        "profile_url": profileUrl,
        "current_sem": currentSem,
        "status": status,
        "is_verified": isVerified,
        "total_credit": totalCredit,
        "left_credit": leftCredit,
        "left_over_credit": leftOverCredit,
        "current_bal": currentBal,
        "topup_history": topupHistory.map((x) => x.toJson()).toList(),
        "hostel": hostel?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "last_active": lastActive?.toIso8601String(),
        "created_by": createdBy,
        "updated_by": updatedBy,
        "leave_history": leaveHistory.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$name, $rollNo, $email, $profileUrl, $uid, $currentSem, $status, $isVerified, $totalCredit, $leftCredit, $currentBal, $topupHistory, $hostel, $createdAt, $updatedAt, $lastActive, $createdBy, $updatedBy, $leaveHistory";
  }
}

class CouponTransactionHistory {
  CouponTransactionHistory({
    required this.transactionId,
    required this.amount,
    required this.transactionTime,
    required this.status,
  });

  final int? amount;
  final String? transactionTime;
  final String? transactionId;
  final String? status;

  CouponTransactionHistory copyWith({
    int? amount,
    String? transactionTime,
    String? transactionId,
    String? status,
  }) {
    return CouponTransactionHistory(
      amount: amount ?? this.amount,
      transactionTime: transactionTime ?? this.transactionTime,
      transactionId: transactionId ?? this.transactionId,
      status: status ?? this.status,
    );
  }

  factory CouponTransactionHistory.fromJson(Map<String, dynamic> json) {
    return CouponTransactionHistory(
      amount: json["amount"],
      transactionTime: json["transaction_time"],
      transactionId: json["transaction_id"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "transaction_time": transactionTime,
        "transaction_id": transactionId,
        "status": status,
      };

  @override
  String toString() {
    return "$amount, $transactionTime, $transactionId, $status, ";
  }
}

class CreditUtilization {
  CreditUtilization({
    required this.totalCredit,
    required this.usedCredit,
    required this.percentageLeft,
  });

  final int? totalCredit;
  final int? usedCredit;
  final double? percentageLeft;

  CreditUtilization copyWith({
    int? totalCredit,
    int? usedCredit,
    double? percentageLeft,
  }) {
    return CreditUtilization(
      totalCredit: totalCredit ?? this.totalCredit,
      usedCredit: usedCredit ?? this.usedCredit,
      percentageLeft: percentageLeft ?? this.percentageLeft,
    );
  }

  factory CreditUtilization.fromJson(Map<String, dynamic> json) {
    return CreditUtilization(
      totalCredit: json["total_credit"],
      usedCredit: json["used_credit"],
      percentageLeft: json["percentage_left"],
    );
  }

  Map<String, dynamic> toJson() => {
        "total_credit": totalCredit,
        "used_credit": usedCredit,
        "percentage_left": percentageLeft,
      };

  @override
  String toString() {
    return "$totalCredit, $usedCredit, $percentageLeft, ";
  }
}

class Hostel {
  Hostel({
    required this.id,
    required this.name,
    required this.roomNumber,
  });

  final String? id;
  final String? name;
  final String? roomNumber;

  Hostel copyWith({
    String? id,
    String? name,
    String? roomNumber,
  }) {
    return Hostel(
      id: id ?? this.id,
      name: name ?? this.name,
      roomNumber: roomNumber ?? this.roomNumber,
    );
  }

  factory Hostel.fromJson(Map<String, dynamic> json) {
    return Hostel(
      id: json["id"],
      name: json["name"],
      roomNumber: json["room_number"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "room_number": roomNumber,
      };

  @override
  String toString() {
    return "$id, $name, $roomNumber, ";
  }
}

class LeaveHistory {
  LeaveHistory({
    required this.leaveId,
    required this.startDate,
    required this.endDate,
  });

  final String? leaveId;
  final String? startDate;
  final String? endDate;

  LeaveHistory copyWith({
    String? leaveId,
    String? startDate,
    String? endDate,
  }) {
    return LeaveHistory(
      leaveId: leaveId ?? this.leaveId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  factory LeaveHistory.fromJson(Map<String, dynamic> json) {
    return LeaveHistory(
      leaveId: json["leave_id"],
      startDate: json["start_date"],
      endDate: json["end_date"],
    );
  }

  Map<String, dynamic> toJson() => {
        "leave_id": leaveId,
        "start_date": startDate,
        "end_date": endDate,
      };

  @override
  String toString() {
    return "$leaveId, $startDate, $endDate, ";
  }
}

class TopupHistory {
  TopupHistory({
    required this.transactionId,
    required this.amount,
    required this.transactionTime,
  });

  final String? transactionId;
  final int? amount;
  final String? transactionTime;

  TopupHistory copyWith({
    String? transactionId,
    int? amount,
    String? transactionTime,
  }) {
    return TopupHistory(
      transactionId: transactionId ?? this.transactionId,
      amount: amount ?? this.amount,
      transactionTime: transactionTime ?? this.transactionTime,
    );
  }

  factory TopupHistory.fromJson(Map<String, dynamic> json) {
    return TopupHistory(
      transactionId: json["transaction_id"],
      amount: json["amount"],
      transactionTime: json["transaction_time"],
    );
  }

  Map<String, dynamic> toJson() => {
        "transaction_id": transactionId,
        "amount": amount,
        "transaction_time": transactionTime,
      };

  @override
  String toString() {
    return "$transactionId, $amount, $transactionTime, ";
  }
}
