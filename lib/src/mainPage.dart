import 'dart:math';

import 'package:diagnosa_apps/model/result_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diagnosa_apps/model/question_model.dart';
import 'package:diagnosa_apps/model/radio_model.dart';
import 'package:diagnosa_apps/src/loginPage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../model/radio_model.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  SharedPreferences sharedPreferences;
  List<Datum> list_question = new List();
  List<RadioModel> modelRadio = new List();
  List<RData> modelData = new List();
  RData listData = new RData();
  RadioModel listRadio = new RadioModel();
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    checkQuestion();
  }

  // widget radio
  Widget _buildRadioButton1(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _programmingList1
          .map((programming) => RadioListTile(
                title: Text(programming.text),
                value: programming.index,
                groupValue: _rgProg[index],
                controlAffinity: ListTileControlAffinity.trailing,
                dense: true,
                onChanged: (value) {
                  setState(() {
                    _rgProg[index] = value;
                    setState(() {
                      modelData[index].value = value;
                      modelRadio.add(RadioModel(id: 0022, data: modelData));
                      listRadio.id = 0022;
                      listRadio.data = modelData;
                      print(modelRadio.toList());
                    });
                    print(value);
                    print(listRadio.toJson());
                  });
                },
              ))
          .toList(),
    );
  }

  Widget _submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xfffbb448), Color(0xfff7892b)])),
      child: RaisedButton(
        elevation: 0.0,
        color: Colors.orange,
        child:
            Text("Submit", style: TextStyle(fontSize: 25, color: Colors.white)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        onPressed: () {
          print(_rgProg);
        },
      ),
    );
  }

  void alertDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Logout"),
            content: Text("Are you sure want to logout"),
            actions: <Widget>[
              FlatButton(
                child: new Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: new Text("Yes"),
                onPressed: () {
                  logout();
                },
              )
            ],
          );
        });
  }

  void logout() {
    sharedPreferences.clear();
    sharedPreferences.commit();
    Get.off(LoginPage());
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") != null) {
      Get.off(MainPage());
    }
  }

  void submitQuestion(BuildContext context) async {
    Map data = {
      "id": [0, 0, 1]
    };
    print("dibawah data");
    print(data);
    print(radioModelToJson(listRadio));
    var response = await http.post(
        "http://eksatamvan.xyz/api/diagnosa",
        body: radioModelToJson(listRadio));
    final result = resultModelFromJson(response.body);
    print(result.status);
//    print(result.resultModelReturn.length);
    if (result.status != null) {
      final _random = new Random();
      String data = result.saran;
      String penyakit = result.penyakit;
      showSuccess(context, "Penyakit: " + penyakit, data, () {
        Navigator.pop(context);
      });
//      }
    } else {
      showSuccess(context, "Keterangan", " anda tidak sakit", () {
        Navigator.pop(context);
      });
    }
  }

  void showSuccess(
      BuildContext context, String title, String desc, Function onCancel) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => new CupertinoAlertDialog(
              title: new Text("$title"),
              content: new Text("$desc"),
              actions: <Widget>[
                FlatButton(
                    child: Text(
                      "Terima Kasih",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    onPressed: onCancel),
              ],
            ));
  }

  checkQuestion() async {
    {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var jsonResponse = null;
      var response = await http.get(
        "http://eksatamvan.xyz/api/gejala",
      );
      final quesdata = quenstionModelFromJson(response.body);
      setState(() {
        list_question = quesdata.data;

        for (int i = 0; quesdata.data.length > i; i++) {
          _rgProg.add(0);
          RData valuedata = new RData();
          valuedata.value = 0;
          valuedata.kode = int.parse(quesdata.data[i].idGejala);
          modelData
              .add(RData(kode: int.parse(quesdata.data[i].idGejala), value: 0));
          print(valuedata.toString());
        }
        modelRadio.add(RadioModel(id: 0022, data: modelData));
        listRadio.id = 0022;
        listRadio.data = modelData;

        print(modelRadio.toList());
      });
      print(listRadio.toJson());
      print(quesdata.data.length);
    }
  }

  checkAnswer() async {
    {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var jsonResponse = null;
      var response = await http.post(
        "http://eksatamvan.xyz/api/gejala",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Diagnosa App", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange,
        actions: <Widget>[
          FlatButton(
              onPressed: () async {
                alertDialog();
              },
              child: Text("Log Out", style: TextStyle(color: Colors.white))),
        ],
      ),
      body: SafeArea(
          child: Stack(
            children: <Widget>[
            Container(
              padding: EdgeInsets.all(18.0),
              child: new ListView.builder(
                itemCount: list_question.length,
                itemBuilder: (context, i) {
                return new Card(
                    child: new Container(
                      padding: EdgeInsets.all(7.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        Text("${i + 1}. ${list_question[i].nama}"),
                        _buildRadioButton1(i),
                    ],
                  ),
                ));
              },
            ),
          ),
        ],
      )),

      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: RaisedButton(
          onPressed: () {
            submitQuestion(context);
            print(radioModelToJson(listRadio));
            print(_rgProg);
          },
          elevation: 0.0,
          color: Colors.orange,
          child: Text("Submit",
              style: TextStyle(fontSize: 25, color: Colors.white)),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
      ),
    );
  }
}

int _rgProgramming = -1;
List<int> _rgProg = [];
String _selectedValue;

final List<RadioGroup> _programmingList1 = [
  RadioGroup(index: 1, text: "Ya"),
  RadioGroup(index: 0, text: "Tidak"),
];



class RadioGroup {
  final int index;
  final String text;
  RadioGroup({this.index, this.text});
}
