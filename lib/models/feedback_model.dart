class FeedBackModel {
  FeedBackModel({
    required this.hostelId,
    required this.hostelName,
    required this.studentName,
    required this.studentRollNo,
    required this.imageUrl,
    required this.query,
    required this.createdAt,
  });

  final String? hostelId;
  final String? hostelName;
  final String? studentName;
  final String? studentRollNo;
  final String? imageUrl;
  final String? query;
  final String? createdAt;

  FeedBackModel copyWith({
    String? hostelId,
    String? hostelName,
    String? studentName,
    String? studentRollNo,
    String? imageUrl,
    String? query,
    String? createdAt,
  }) {
    return FeedBackModel(
      hostelId: hostelId ?? this.hostelId,
      hostelName: hostelName ?? this.hostelName,
      studentName: studentName ?? this.studentName,
      studentRollNo: studentRollNo ?? this.studentRollNo,
      imageUrl: imageUrl ?? this.imageUrl,
      query: query ?? this.query,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory FeedBackModel.fromJson(Map<String, dynamic> json) {
    return FeedBackModel(
      hostelId: json["hostel_id"],
      hostelName: json["hostel_name"],
      studentName: json["student_name"],
      studentRollNo: json["student_rollNo"],
      imageUrl: json["image_url"],
      query: json["query"],
      createdAt: json["created_at"],
    );
  }

  Map<String, dynamic> toJson() => {
        "hostel_id": hostelId,
        "hostel_name": hostelName,
        "student_name": studentName,
        "student_rollNo": studentRollNo,
        "image_url": imageUrl,
        "query": query,
        "created_at": createdAt,
      };

  @override
  String toString() {
    return "$hostelId, $hostelName, $studentName, $studentRollNo, $imageUrl, $query, $createdAt, ";
  }
}
