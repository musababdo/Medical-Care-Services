
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicalcare/constants.dart';
import 'package:medicalcare/screens/aboutus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

class More extends StatefulWidget {
  static String id='More';
  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {

  Future<void> signOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      pref.remove("value");
      pref.clear();
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "تم تسجيل الخروج",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop:(){
          //Navigator.popAndPushNamed(context, CartScreen.id);
          Navigator.pop(context);
          return Future.value(false);
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: kMainColor,
            elevation: 0,
            title: Text(
              'المزيد',
              style: GoogleFonts.cairo(
                textStyle: TextStyle(
                    color: Colors.white
                ),
              ),
            ),
            leading: GestureDetector(
              onTap: () {
                //Navigator.pushNamed(context, Home.id);
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      dense: true,
                      trailing: Icon(Icons.arrow_forward_ios),
                      title: Text("أتصل بنا", style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                          fontSize: 18
                        ),
                      ),
                      ),
                      leading: Icon(Icons.phone,color: kMainColor,),
                      onTap: (){
                        launch(('tel://+249121247534'));
                      },
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      trailing: Icon(Icons.arrow_forward_ios),
                      title: Text("من نحن", style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                            fontSize: 18
                        ),
                      ),),
                      leading: Icon(Icons.info_outline,color: kMainColor),
                      onTap: (){
                        Navigator.pushNamed(context,AboutUs.id);
                      },
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      dense: true,
                      trailing: Icon(Icons.arrow_forward_ios),
                      title: Text("تسجيل خروج", style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                            fontSize: 18
                        ),
                      ),),
                      leading: Icon(Icons.logout,color: kMainColor),
                      onTap: (){
                        signOut();
                      },
                    ),
                  ),

                ],),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
