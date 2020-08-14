// To parse this JSON data, do
//
//     final sendData = sendDataFromJson(jsonString);

import 'dart:convert';

SendData sendDataFromJson(String str) => SendData.fromJson(json.decode(str));

String sendDataToJson(SendData data) => json.encode(data.toJson());

class SendData {
  SendData({
    this.id,
    this.data,
  });

  int id;
  List<Datum> data;

  factory SendData.fromJson(Map<String, dynamic> json) => SendData(
        id: json["id"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.kode,
    this.value,
  });

  int kode;
  int value;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        kode: json["kode"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "kode": kode,
        "value": value,
      };
}
