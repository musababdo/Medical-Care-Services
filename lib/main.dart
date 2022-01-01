

import 'package:flutter/material.dart';
import 'package:medicalcare/doctors/choosedoctor.dart';
import 'package:medicalcare/doctors/confirmdoctor.dart';
import 'package:medicalcare/doctors/doctordate.dart';
import 'package:medicalcare/doctors/doctorspeciality.dart';
import 'package:medicalcare/profile/profilescreen.dart';
import 'package:medicalcare/screens/aboutus.dart';
import 'package:medicalcare/screens/emergencydoctor.dart';
import 'package:medicalcare/screens/emergencynurse.dart';
import 'package:medicalcare/screens/more.dart';
import 'package:medicalcare/screens/mydate.dart';
import 'package:medicalcare/screens/naturecure.dart';
import 'package:medicalcare/screens/doctors.dart';
import 'package:medicalcare/screens/home.dart';
import 'package:medicalcare/screens/nurse.dart';
import 'package:medicalcare/screens/lab.dart';
import 'package:medicalcare/screens/myui.dart';
import 'package:medicalcare/screens/spalshscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool isUserLoggedIn = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //initialRoute: isUserLoggedIn ? SplashScreen.id : Myui.id,
      initialRoute: SplashScreen.id,
      routes: {
        Myui.id: (context) => Myui(),
        Home.id: (context) => Home(),
        SplashScreen.id: (context) => SplashScreen(),
        LAB.id: (context) => LAB(),
        NatureCure.id: (context) => NatureCure(),
        Doctors.id: (context) => Doctors(),
        ChooseDoctor.id: (context) => ChooseDoctor(),
        DoctorSpeciality.id: (context) => DoctorSpeciality(),
        ConfirmDoctor.id: (context) => ConfirmDoctor(),
        DoctorDate.id: (context) => DoctorDate(),
        Nurse.id: (context) => Nurse(),
        More.id: (context) => More(),
        MyDate.id: (context) => MyDate(),
        ProfileScreen.id: (context) => ProfileScreen(),
        EmergencyDoctor.id: (context) => EmergencyDoctor(),
        EmergencyNurse.id: (context) => EmergencyNurse(),
        AboutUs.id: (context) => AboutUs(),
      },
    );
  }
}
