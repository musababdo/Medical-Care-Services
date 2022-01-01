
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicalcare/constants.dart';
import 'package:medicalcare/profile/profilescreen.dart';
import 'package:medicalcare/screens/emergencydoctor.dart';
import 'package:medicalcare/screens/emergencynurse.dart';
import 'package:medicalcare/screens/more.dart';
import 'package:medicalcare/screens/mydate.dart';
import 'package:medicalcare/screens/myui.dart';
import 'package:medicalcare/screens/naturecure.dart';
import 'package:medicalcare/screens/doctors.dart';
import 'package:medicalcare/screens/nurse.dart';
import 'package:medicalcare/screens/lab.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  static String id='home';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _bottomBarIndex = 0;
  int profilevalue,datevalue;

  Future getMyProfile() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      profilevalue = preferences.getInt("value") ;
      if ((preferences.getInt("value") == 1)) {
        //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => confirmnow()));
        Navigator.pushNamed(context, ProfileScreen.id);
      }else{
        myDialog();
      }
    });
  }

  Future getMyDate() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      datevalue = preferences.getInt("value") ;
      if ((preferences.getInt("value") == 1)) {
        //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => confirmnow()));
         Navigator.pushNamed(context, MyDate.id);
      }else{
        myDialog();
      }
    });
  }

  Future getDoctor() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      datevalue = preferences.getInt("value") ;
      if ((preferences.getInt("value") == 1)) {
        //Navigator.pushNamed(context, MyDate.id);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Doctors(),
          ),
        );
      }else{
        myDialog();
      }
    });
  }

  Future getNurse() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      datevalue = preferences.getInt("value") ;
      if ((preferences.getInt("value") == 1)) {
        //Navigator.pushNamed(context, MyDate.id);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Nurse(),
          ),
        );
      }else{
        myDialog();
      }
    });
  }

  Future getLab() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      datevalue = preferences.getInt("value") ;
      if ((preferences.getInt("value") == 1)) {
        //Navigator.pushNamed(context, MyDate.id);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LAB(),
          ),
        );
      }else{
        myDialog();
      }
    });
  }

  Future getNetureCure() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      datevalue = preferences.getInt("value") ;
      if ((preferences.getInt("value") == 1)) {
        //Navigator.pushNamed(context, MyDate.id);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NatureCure(),
          ),
        );
      }else{
        myDialog();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop:(){
        exitDialog();
        return Future.value(false);
      },
      child: SafeArea(
        child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _bottomBarIndex,
              fixedColor: kMainColor,
              onTap: (value) {
                setState(() {
                      _bottomBarIndex = value;
                    });
                switch(value){
                  case 0:
                    Navigator.pushNamed(context, More.id);
                    break;
                  case 1:
                  getMyDate();
                    break;
                  case 2:
                  getMyProfile();
                    break;
                }
              },
              items: [
                BottomNavigationBarItem(
                    title: Text('المزيد',style: GoogleFonts.cairo(textStyle: TextStyle(fontSize: 16,),),), icon: Icon(Icons.more_horiz)),
                BottomNavigationBarItem(
                    title: Text('المواعيد',style: GoogleFonts.cairo(textStyle: TextStyle(fontSize: 16,)),), icon: Icon(Icons.date_range)),
                BottomNavigationBarItem(
                    title: Text('الشخصيه',style: GoogleFonts.cairo(textStyle: TextStyle(fontSize: 16,)),), icon: Icon(Icons.person)),
              ],
            ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height:height* .1,
                ),
                Text(
                    'ميديكل كير سيرفس',
                    style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                      ),
                    )
                ),
                SizedBox(
                  height:height* .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        'أحجز او أتصل',
                        style: GoogleFonts.cairo(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        )
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(Icons.phone,color: kMainColor,)
                  ],
                ),
                SizedBox(
                  height:height* .02,
                ),
                GestureDetector(
                  onTap:(){
                    launch(('tel://+249121247534'));
                  },
                  child: Text(
                      '+249121247534',
                      style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      )
                  ),
                ),
                SizedBox(
                  height:height* .06,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap:(){
                          getDoctor();
                        },
                        child: Container(
                          height: 150.0,
                          width: 150.0,
                          color: Colors.transparent,
                          child: Container(
                              decoration: BoxDecoration(
                                  color: kMainColor,
                                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
                              child: new Center(
                                child: new Text("الأطباء",
                                  style: GoogleFonts.cairo(
                                    textStyle: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white
                                    ),
                                  ),
                                  textAlign: TextAlign.center,),
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap:(){
                          getNurse();
                        },
                        child: Container(
                          height: 150.0,
                          width: 150.0,
                          color: Colors.transparent,
                          child: Container(
                              decoration: BoxDecoration(
                                  color:kMainColor,
                                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
                              child: new Center(
                                child: new Text("تمريض",
                                  style: GoogleFonts.cairo(
                                    textStyle: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white
                                    ),
                                  ),
                                  textAlign: TextAlign.center,),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height:height* .02,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap:(){
                          getLab();
                        },
                        child: Container(
                          height: 150.0,
                          width: 150.0,
                          color: Colors.transparent,
                          child: Container(
                              decoration: BoxDecoration(
                                  color: kMainColor,
                                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
                              child: new Center(
                                child: new Text("معمل",
                                  style: GoogleFonts.cairo(
                                    textStyle: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white
                                    ),
                                  ),
                                  textAlign: TextAlign.center,),
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap:(){
                          getNetureCure();
                        },
                        child: Container(
                          height: 150.0,
                          width: 150.0,
                          color: Colors.transparent,
                          child: Container(
                              decoration: BoxDecoration(
                                  color:kMainColor,
                                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
                              child: new Center(
                                child: new Text("علاج طبيعي",
                                  style: GoogleFonts.cairo(
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white
                                    ),
                                  ),
                                  textAlign: TextAlign.center,),
                              )
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height:height* .02,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: Container(color: kMainColor,height: 5,),
                ),
                SizedBox(
                  height:height* .01,
                ),
                Text(
                    'خاص بالمستشفيات',
                    style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                          color: kMainColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    )
                ),
                SizedBox(
                  height:height* .01,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15,bottom: 8),
                  child: Builder(
                    builder: (context) => FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        Navigator.pushNamed(context, EmergencyDoctor.id);
                      },
                      color: kMainColor,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 5,top: 5),
                        child: Center(
                          child: Text(
                              "طلب طبيب",
                              style: GoogleFonts.cairo(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height:height* .01,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15,bottom: 8),
                  child: Builder(
                    builder: (context) => FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        Navigator.pushNamed(context, EmergencyNurse.id);
                      },
                      color: kMainColor,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 5,top: 5),
                        child: Center(
                          child: Text(
                            "طلب ممرض",
                            style: GoogleFonts.cairo(
                              textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
  myDialog(){
    showModalBottomSheet(context: context, builder: (context){
      return WillPopScope(
        onWillPop:(){
          Navigator.pop(context);
          return Future.value(false);
        },
        child: SafeArea(
            child: Container(
              color: Color(0xFF737373),
              height: 180,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20),
                    topRight: const Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Text("تنبيه",style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                        fontSize: 22,
                      ),
                    ),),
                    const SizedBox(height:8),
                    Text('ليس لديك حساب قم بعمل حساب الأن ',style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                        fontSize: 19,
                      ),
                    ),),
                    const SizedBox(height:10),
                    Padding(
                      padding: const EdgeInsets.only(left: 25,right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                Navigator.of(context).pop();
                              });
                            },
                            child: Text('الغاء',
                              style: GoogleFonts.cairo(
                                textStyle: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                Navigator.pushNamed(context, Myui.id).then((_){
                                  Navigator.of(context).pop();
                                });
                              });
                            },
                            child: Text('موافق',
                              style: GoogleFonts.cairo(
                                textStyle: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
        ),
      );
    });
  }
  exitDialog(){
    showModalBottomSheet(context: context, builder: (context){
      return WillPopScope(
        onWillPop:(){
          Navigator.pop(context);
          return Future.value(false);
        },
        child: SafeArea(
            child: Container(
              color: Color(0xFF737373),
              height: 180,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20),
                    topRight: const Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Text("الخروج من التطبيق",style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                        fontSize: 22,
                      ),
                    ),),
                    const SizedBox(height:8),
                    Text('هل تود الخروج من التطبيق ',style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                        fontSize: 19,
                      ),
                    ),),
                    const SizedBox(height:10),
                    Padding(
                      padding: const EdgeInsets.only(left: 25,right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                Navigator.of(context).pop();
                              });
                            },
                            child: Text('الغاء',
                              style: GoogleFonts.cairo(
                                textStyle: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                SystemNavigator.pop();
                              });
                            },
                            child: Text('موافق',
                              style: GoogleFonts.cairo(
                                textStyle: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
        ),
      );
    });
  }
}
