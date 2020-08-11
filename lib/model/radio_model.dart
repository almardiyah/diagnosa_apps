// To parse this JSON data, do
//
//     final radioModel = radioModelFromJson(jsonString);

import 'dart:convert';

RadioModel radioModelFromJson(String str) => RadioModel.fromJson(json.decode(str));

String radioModelToJson(RadioModel data) => json.encode(data.toJson());

class RadioModel {
  RadioModel({
    this.id,
    this.data,
  });

  int id;
  List<RData> data;

  factory RadioModel.fromJson(Map<String, dynamic> json) => RadioModel(
    id: json["id"],
    data: List<RData>.from(json["data"].map((x) => RData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class RData {
  RData({
    this.kode,
    this.value,
  });

  int kode;
  int value;

  factory RData.fromJson(Map<String, dynamic> json) => RData(
    kode: json["kode"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "kode": kode,
    "value": value,
  };
}
