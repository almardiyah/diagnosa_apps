import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:diagnosa_apps/main.dart';
import 'package:diagnosa_apps/src/signup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:diagnosa_apps/src/mainPage.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'Widget/bezierContainer.dart';
import 'package:fluttertoast/fluttertoast.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FToast fToast;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fToast = FToast(context);
  }
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
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
        onPressed: emailController.text == "" || passwordController.text == "" ? null : () {
          setState(() {
            _isLoading = true;
          });
          signIn(emailController.text, passwordController.text);
        },
        elevation: 0.0,
        color: Colors.orange,
        child: Text("Login",
            style: TextStyle(fontSize: 25, color: Colors.white)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'D',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: 'ia',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            TextSpan(
              text: 'gnosa',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            TextSpan(
              text: ' Login',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
          ]),
    );
  }

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: emailController,
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            icon: Icon(Icons.email, color: Colors.black),
            hintText: "Email",
            border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
            hintStyle: TextStyle(color: Colors.black),
          ),
        ),
        SizedBox(height: 30.0),
        TextFormField(
          controller: passwordController,
          cursorColor: Colors.white,
          obscureText: true,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            icon: Icon(Icons.lock, color: Colors.black),
            hintText: "Password",
            border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
            hintStyle: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
  signIn(String email, pass) async {
    print(email);
    print(pass);
    try{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      Map data = {
        'email': email.trimRight(),
        'password': pass
      };
      var jsonResponse = null;
      var response = await http.post("http://diagnosa-pms.sudamiskin.com/api/masuk", body: data);
      jsonResponse = json.decode(response.body);
      print(response.body);
      print(jsonResponse['status']);
      print(jsonResponse['token']);

      if(jsonResponse['status'] == true){
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute
              (builder: (
                BuildContext context) => MainPage()),
                (Route<dynamic> route) => false);
        fToast.showToast(
          child:Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.greenAccent,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check),
                SizedBox(
                  width: 12.0,
                ),
//              Text("${response.body}"),
                Text("Login Berhasil"),
              ],
            ),
          ),
          gravity: ToastGravity.BOTTOM,
          toastDuration: Duration(seconds: 2),
        );

        print('ilham berhasil nih');
      }else{
        print('ilham gagal nih');
        fToast.showToast(
          child:Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.greenAccent,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.clear),
                SizedBox(
                  width: 12.0,
                ),
//              Text("${response.body}"),
                Text("Login Gagal"),
              ],
            ),
          ),
          gravity: ToastGravity.BOTTOM,
          toastDuration: Duration(seconds: 2),
        );
      }
//    if (jsonResponse['status'] == true) {
//
//      String status = jsonResponse['status'];
//      String data_pasien = jsonResponse['data'];
//        setState(() {
//          _isLoading = false;
//        });
//        Navigator.of(context).pushAndRemoveUntil(
//            MaterialPageRoute
//          (builder: (
//            BuildContext context) => MainPage()),
//                (Route<dynamic> route) => false);
//    }
//    else {
//      setState(() {
//        _isLoading = false;
//      });
//    }
    }
    catch(e){
      fToast.showToast(
        child:Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.greenAccent,
          ),
          child:  Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check),
              SizedBox(
                width: 12.0,
              ),
              Text("${e.toString()}"),
            ],
          ),
        ),
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(seconds: 6),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
          height: height,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -height * .15,
                    right: -MediaQuery.of(context).size.width * .4,
                    child: BezierContainer()),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: height * .2),
                        _title(),
                        SizedBox(height: 100),
                        _emailPasswordWidget(),
                        SizedBox(height: 40),
                        _submitButton(),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.centerRight,
                          child: Text('Forgot Password ?',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                        ),
                        SizedBox(height: height * .055),
                        _createAccountLabel(),
                      ],
                    ),
                  ),
                ),
                Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ));
    }
  }
