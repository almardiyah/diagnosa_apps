import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:diagnosa_apps/model/question_model.dart';
import 'package:diagnosa_apps/src/loginPage.dart';
import 'package:diagnosa_apps/src/mainPage.dart';
import 'package:http/http.dart' as http;


import 'package:shared_preferences/shared_preferences.dart';

class SubmitPage extends StatefulWidget {
  @override
  _SubmitPageState createState() => _SubmitPageState();
}

class _SubmitPageState extends State<SubmitPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hasil Diagnosa", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange,
        actions: <Widget>[
          FlatButton(
              onPressed: () async {
//                alertDialog();
              },
              child: Icon(Icons.local_hospital)),
        ],
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  "Penyakit Influenza", style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                child: Text(
                  "Hasil : Positif", style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                child: Text(
                  "Saran : "
                      "Rajinlah mencucui tangan dengan sabun, makan makanan yang sehat dan banyak istirahat serta konsumsi air putih, dan gunakan masker apabila keluar rumah, apabila sakit masih berlanjut lebih dari satu minggu segeralah lakukan pemeriksaan langsung dengan dokter", style: TextStyle(color: Colors.black, fontSize: 17),
                ),
              )
            ],
          ),
        ),
      ),
    );

//      drawer: Drawer(),
  }
}
