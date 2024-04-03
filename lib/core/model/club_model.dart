import 'package:flutter/material.dart';

class ClubModel {
  final int index;
  final int id;
  final String name;
  final String country;
  final Color color;
  final Color? secondarColor;
  final String? logo;

  ClubModel({
    required this.index,
    required this.id,
    required this.name,
    required this.country,
    this.color = Colors.blue,
    this.secondarColor,
    this.logo,
  });

  static ClubModel fromJson(Map<String, dynamic> json) {
    return ClubModel(
      index: json["index"],
      id: json["id"],
      name: json["name"].toString(),
      country: json["country"].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "index": index,
      "id": id,
      "name": name,
      "country": country,
    };
  }
}
