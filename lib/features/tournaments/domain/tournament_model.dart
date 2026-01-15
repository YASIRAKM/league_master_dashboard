// To parse this JSON data, do
//
//     final tournament = tournamentFromJson(jsonString);

import 'dart:convert';

List<TournamentModel> tournamentFromJson(List<dynamic> data) =>
    List<TournamentModel>.from(data.map((x) => TournamentModel.fromJson(x)));

String tournamentToJson(List<TournamentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

final class TournamentModel {
  int id;
  String name;
  String status;
  int maxTeams;
  DateTime createdAt;
  DateTime updatedAt;

  TournamentModel({
    required this.id,
    required this.name,
    required this.status,
    required this.maxTeams,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TournamentModel.fromJson(Map<String, dynamic> json) =>
      TournamentModel(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        maxTeams: json["max_teams"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "max_teams": maxTeams,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
