// To parse this JSON data, do
//
//     final dropdownItemsModel = dropdownItemsModelFromJson(jsonString);

import 'dart:convert';

List<DropdownItemsModel> dropdownItemsModelFromJson(String str) =>
    List<DropdownItemsModel>.from(
        json.decode(str).map((x) => DropdownItemsModel.fromJson(x)));

String dropdownItemsModelToJson(List<DropdownItemsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DropdownItemsModel {
  int userId;
  int id;
  String title;

  DropdownItemsModel({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory DropdownItemsModel.fromJson(Map<String, dynamic> json) =>
      DropdownItemsModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
      };
}
