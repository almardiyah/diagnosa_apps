// To parse this JSON data, do
//
//     final resultModel = resultModelFromJson(jsonString);

import 'dart:convert';

ResultModel resultModelFromJson(String str) =>
    ResultModel.fromJson(json.decode(str));

String resultModelToJson(ResultModel data) => json.encode(data.toJson());

class ResultModel {
  ResultModel({
    // this.idDiagnosa,
    // this.status,
    this.penyakit,
    this.saran,
//    this.resultModelReturn,
  });

  // int idDiagnosa;
  String penyakit;
  String saran;
  int status;
//  List<Return> resultModelReturn;

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        // idDiagnosa: json["id_diagnosa"],
        // status: json["status"],
        penyakit: json['penyakit'],
        saran: json['saran'],
    //        resultModelReturn:
    //            List<Return>.from(json["return"].map((x) => Return.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        // "id_diagnosa": idDiagnosa,
        // "status": status,
        "penyakit": penyakit,
        "saran": saran,
//        "return": List<dynamic>.from(resultModelReturn.map((x) => x.toJson())),
      };
}

//class Return {
//  Return({
//    this.penyakit,
//    this.nama,
//    this.total,
//    this.status,
//    this.data,
//  });
//
//  String penyakit;
//  String nama;
//  int total;
//  int status;
//  Data data;
//
//  factory Return.fromJson(Map<String, dynamic> json) => Return(
//        penyakit: json["penyakit"],
//        nama: json["nama"],
//        total: json["total"],
//        status: json["status"],
//        data: Data.fromJson(json["data"]),
//      );
//
//  Map<String, dynamic> toJson() => {
//        "penyakit": penyakit,
//        "nama": nama,
//        "total": total,
//        "status": status,
//        "data": data.toJson(),
//      };
//}

class Data {
  Data({
//    this.idSaran,
//    this.idPenyakit,
//    this.idUser,
//    this.judul,
      this.keterangan,
//    this.createdAt,
      this.penyakit,
      this.saran,
  });

  // String idSaran;
  // String idPenyakit;
  // String idUser;
  // String judul;
  String keterangan;
  String saran;
  // DateTime createdAt;
  String penyakit;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
//        idSaran: json["id_saran"],
//        idPenyakit: json["id_penyakit"],
//        idUser: json["id_user"],
//        judul: json["judul"],
       keterangan: json["keterangan"],
//        createdAt: DateTime.parse(json["created_at"]),
        penyakit: json["penyakit"],
        saran: json["saran"],
      );

  Map<String, dynamic> toJson() => {
          "penyakit": penyakit,
          "saran": saran,
//        "id_saran": idSaran,
//        "id_penyakit": idPenyakit,
//        "id_user": idUser,
//        "judul": judul,
       "keterangan": keterangan,
//        "created_at": createdAt.toIso8601String(),
      };
}
