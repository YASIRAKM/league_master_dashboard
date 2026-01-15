// To parse this JSON data, do
//
//     final teamModel = teamModelFromJson(jsonString);

import 'dart:convert';

List<TeamModel> teamModelFromJson(String str) => List<TeamModel>.from(json.decode(str).map((x) => TeamModel.fromJson(x)));

String teamModelToJson(List<TeamModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeamModel {
    int? id;
    String? name;
    String? logoUrl;
    int? captainId;
    DateTime? createdAt;
    DateTime? updatedAt;

    TeamModel({
        this.id,
        this.name,
        this.logoUrl,
        this.captainId,
        this.createdAt,
        this.updatedAt,
    });

    TeamModel copyWith({
        int? id,
        String? name,
        String? logoUrl,
        int? captainId,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        TeamModel(
            id: id ?? this.id,
            name: name ?? this.name,
            logoUrl: logoUrl ?? this.logoUrl,
            captainId: captainId ?? this.captainId,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
        id: json["id"],
        name: json["name"],
        logoUrl: json["logo_url"],
        captainId: json["captain_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo_url": logoUrl,
        "captain_id": captainId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
