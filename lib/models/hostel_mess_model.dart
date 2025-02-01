class HostelMessModel {
    HostelMessModel({
        required this.hostelId,
        required this.hostelName,
        required this.createdAt,
        required this.updatedAt,
    });

    final String? hostelId;
    final String? hostelName;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    HostelMessModel copyWith({
        String? hostelId,
        String? hostelName,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) {
        return HostelMessModel(
            hostelId: hostelId ?? this.hostelId,
            hostelName: hostelName ?? this.hostelName,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );
    }

    factory HostelMessModel.fromJson(Map<String, dynamic> json){ 
        return HostelMessModel(
            hostelId: json["hostel_id"],
            hostelName: json["hostel_name"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "hostel_id": hostelId,
        "hostel_name": hostelName,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };

    @override
    String toString(){
        return "$hostelId, $hostelName, $createdAt, $updatedAt, ";
    }
}
