import 'dart:async';
import 'dart:convert';

import 'package:medicalcare/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medicalcare/screens/myui.dart';
import 'package:medicalcare/signin/login.dart';
import 'package:medicalcare/signin/login_option.dart';

class Register extends StatefulWidget {
  static String id = 'register';
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  int _state=0;

  TextEditingController _username = TextEditingController();
  TextEditingController _phone    = TextEditingController();
  TextEditingController _password = TextEditingController();

  Future register() async{
    //var url = Uri.parse('http://10.0.2.2/medicalcare/register.php');
    var url = Uri.parse('https://h-o.sd/medicalcare/register.php');
    //var url = Uri.parse('https://medicalcareservices.000webhostapp.com/medicalcare/register.php');
    var response=await http.post(url, body: {
      "username" : _username.text.trim(),
      "password" : _password.text.trim(),
      "phone"    : _phone.text.trim(),
    });
    //json.decode(response.body);
    if(response.body.isNotEmpty) {
      json.decode(response.body);
    }
  }

  bool _validate = false;
  bool _secureText = true;
  void showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  String _errorMessage(String hint) {
    if(hint=="أسم المستخدم"){
      return 'الرجاء ادخال اسم المستخدم';
    }else if(hint=="رقم الهاتف"){
      return 'الرجاء ادخال رقم الهاتف';
    }else if(hint=="كلمه المرور"){
      return 'الرجاء ادخال كلمه المرور';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _globalKey,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 16,
            ),
            TextFormField(
              style: TextStyle(color: Colors.black),
              controller: _username,
              cursorColor: Colors.black,
              validator:(value) {
                if (value.isEmpty) {
                  return _errorMessage("أسم المستخدم");
                  // ignore: missing_return
                }
              },
              decoration: InputDecoration(
                hintText: 'أسم المستخدم',
                icon: Icon(Icons.person,color:Colors.white),
                hintStyle: GoogleFonts.cairo(
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              style: TextStyle(color: Colors.black),
              cursorColor: Colors.black,
              controller: _phone,
              keyboardType:TextInputType.number,
              validator:(value) {
                if (value.isEmpty) {
                  return _errorMessage("رقم الهاتف");
                  // ignore: missing_return
                }
              },
              decoration: InputDecoration(
                hintText: 'رقم الهاتف',
                icon: Icon(Icons.phone,color:Colors.white),
                hintStyle: GoogleFonts.cairo(
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              style: TextStyle(color: Colors.black),
              obscureText: _secureText,
              cursorColor: Colors.black,
              controller: _password,
              validator:(value) {
                if (value.isEmpty) {
                  return _errorMessage("كلمه المرور");
                  // ignore: missing_return
                }
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: showHide,
                  icon: Icon(_secureText
                      ? Icons.visibility_off
                      : Icons.visibility),
                ),
                hintText: 'كلمه المرور',
                icon: Icon(Icons.lock,color:Colors.white),
                hintStyle: GoogleFonts.cairo(
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              ),
            ),

            SizedBox(
              height: 24,
            ),

            GestureDetector(
              onTap:(){
                if (_state == 0) {
                  animateButton();
                }

                if (_globalKey.currentState.validate()){
                  _globalKey.currentState.save();
                  try{
                    register();
                    Fluttertoast.showToast(
                        msg: "تم الحفظ بنجاح",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: kMainColor,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                    _username.text='';
                    _phone.text='';
                    _password.text='';
                  }on PlatformException catch(e){

                  }
                }else{
                  setState(() {
                    _state = 0;
                  });
                }
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: kMainColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFF3D657).withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 4,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child:  Center(
                  child: setUpButtonChild(),
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
  Widget setUpButtonChild() {
    if (_state == 0) {
      return new Text(
        "أنشاء الحساب",
        style: GoogleFonts.cairo(
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
    } else if (_state == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    }
  }

  void animateButton() {
    setState(() {
      _state = 1;
    });

    Timer(Duration(milliseconds: 3300), () {
      setState(() {
        _state = 0;
      });
    });
  }
}