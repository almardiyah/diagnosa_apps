// To parse this JSON data, do
//
//     final quenstionModel = quenstionModelFromJson(jsonString);

import 'dart:convert';

QuenstionModel quenstionModelFromJson(String str) => QuenstionModel.fromJson(json.decode(str));

String quenstionModelToJson(QuenstionModel data) => json.encode(data.toJson());

class QuenstionModel {
  QuenstionModel({
    this.status,
    this.data,
  });

  bool status;
  List<Datum> data;

  factory QuenstionModel.fromJson(Map<String, dynamic> json) => QuenstionModel(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.idGejala,
    this.kodeGejala,
    this.nama,
    this.nilai,
    this.createdAt,
  });

  String idGejala;
  String kodeGejala;
  String nama;
  String nilai;
  DateTime createdAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idGejala: json["id_gejala"],
    kodeGejala: json["kode_gejala"],
    nama: json["nama"],
    nilai: json["nilai"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id_gejala": idGejala,
    "kode_gejala": kodeGejala,
    "nama": nama,
    "nilai": nilai,
    "created_at": createdAt.toIso8601String(),
  };
}
