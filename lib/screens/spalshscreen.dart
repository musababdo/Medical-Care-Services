import 'dart:async';

import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicalcare/constants.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:medicalcare/screens/home.dart';
import 'package:medicalcare/screens/myui.dart';

class SplashScreen extends StatefulWidget {
  static String id='splashscreen';
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {

  var wifiBSSID;
  var wifiIP;
  var wifiName;
  bool iswificonnected = false;
  bool isInternetOn = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //startTimer();
    getConnect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body:showText(),
    );
  }

  showText(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Center(
            child: Container(
              //height: MediaQuery.of(context).size.height * .2,
              child: Column(
                children: [
                    Image.asset('images/logo.jpg',
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 1,),
                  SizedBox(
                    height:5,
                  ),
                  Text(
                    'ميديكل كير سيرفس',
                    style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 25
                      ),
                    ),
                  ),
                ],
              )
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                child:CircularProgressIndicator(),
                height: 20,
                width: 20,
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                child: Text("...جاري الاتصال",style: GoogleFonts.cairo(
                  textStyle: TextStyle(
                      color: Colors.white
                  ),
                )
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void startTimer() {
    Timer(Duration(seconds: 5), () {
      //navigateUser();// It will redirect  after 3 seconds
      //Navigator.push(context, MaterialPageRoute(builder: (context)=>home(),),);
      Navigator.popAndPushNamed(context, Home.id);
    });
  }

  _showDialog(){
    showDialog(context: context,
        builder: (context){
          return AlertDialog(
            title: Text("فشل الاتصال",style: GoogleFonts.cairo()),
            content: Text("تأكد من ان جهازك متصل بالانترنت",style: GoogleFonts.cairo()),
            actions: <Widget>[
              FlatButton(
                  onPressed: (){
                    setState(() {
                      Navigator.of(context).pop();
                      SystemNavigator.pop();
                    });
                  },
                  child: Text("حسنا",style: GoogleFonts.cairo())
              ),
            ],
          );
        }
    );
  }

  void getConnect() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _showDialog();
      });
    } else if (connectivityResult == ConnectivityResult.mobile) {
      startTimer();
      //iswificonnected = false;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      startTimer();
      /*iswificonnected = true;
      setState(() async {
        wifiBSSID = await (Connectivity().getWifiBSSID());
        wifiIP = await (Connectivity().getWifiIP());
        wifiName = await (Connectivity().getWifiName());
      });*/
    }
  }
}