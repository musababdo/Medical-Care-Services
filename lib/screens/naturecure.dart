
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medicalcare/constants.dart';
import 'package:medicalcare/models/nursemodel.dart';
import 'package:medicalcare/screens/home.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class cproInfo {
  //Constructor
  String username;
  String phone;

  cproInfo.fromJson(Map json) {
    username = json['username'];
    phone    = json['phone'];
  }
}

class NatureCure extends StatefulWidget {
  static String id='NatureCure';
  @override
  _DentistCenterState createState() => _DentistCenterState();
}

class _DentistCenterState extends State<NatureCure> {

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  bool patient = false;

  String myusername,myphone;

  TextEditingController  username = new TextEditingController();
  TextEditingController  phone    = new TextEditingController();
  TextEditingController  location = new TextEditingController();
  TextEditingController  note     = new TextEditingController();

  DateTime currentdate=new DateTime.now();
  String formatdate;

  SharedPreferences mpreferences;
  Future getProfile() async {
    mpreferences = await SharedPreferences.getInstance();
    setState(() {
      //print(preferences.getString("id"));
    });
    //var url = Uri.parse('http://10.0.2.2/medicalcare/profile/display_profile.php');
    var url = Uri.parse('https://h-o.sd/medicalcare/profile/display_profile.php');
    var response = await http.post(url, body: {
      "id" : mpreferences.getString("id"),
    });
    var data = json.decode(response.body);
    setState(() {
      final items = (data['login'] as List).map((i) => new cproInfo.fromJson(i));
      for (final item in items) {
        username.text = item.username;
        phone.text    = item.phone;

        myusername = item.username;
        myphone    = item.phone;
      }
    });
    return data;
  }

  Future sendNow() async{
    //var url = Uri.parse('http://10.0.2.2/medicalcare/naturecure_order.php');
    var url = Uri.parse('https://h-o.sd/medicalcare/naturecure_order.php');
    var response=await http.post(url, body: {
      "name"         : username.text,
      "phone"        : phone.text,
      "location"     : location.text,
      "note"         : note.text,
      "time"         : formatdate
    });
    //json.decode(response.body);
    if(response.body.isNotEmpty) {
      json.decode(response.body);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }

  String _errorMessage(String hint) {
    if(hint=="أسم المريض"){
      return 'الرجاء ادخال اسم المريض';
    }else if(hint=="رقم الهاتف"){
      return 'الرجاء ادخال رقم الهاتف';
    }else if(hint=="عنوان السكن"){
      return 'الرجاء ادخال عنوان السكن';
    }else if(hint=="نوع المرض"){
      return 'الرجاء ادخال نوع المرض';
    }

  }

  @override
  Widget build(BuildContext context) {
    formatdate=new DateFormat('yyyy.MMMMM.dd hh:mm:ss aaa').format(currentdate);
    return Form(
      key: _globalKey,
      child: SafeArea(
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
                'علاج طبيعي',
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
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: new Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                      ),
                      elevation: 9,
                      color: Colors.white,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 1.7,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    'أنا أحجز عوضا عن مريض أخر ',
                                    style: GoogleFonts.cairo(
                                      textStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: MediaQuery.of(context).size.width * .1,),
                                  Theme(
                                    data: ThemeData(unselectedWidgetColor: kMainColor),
                                    child: Checkbox(
                                      checkColor: Colors.white,
                                      activeColor: kMainColor,
                                      value: patient,
                                      onChanged: (value) {
                                        setState(() {
                                          if(patient = value) {
                                            username.clear();
                                            phone.clear();
                                          }else{
                                            username.text = myusername;
                                            phone.text = myphone;
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Divider(color: Colors.black38,),
                              TextFormField(
                                validator:(value) {
                                  if (value.isEmpty) {
                                    return _errorMessage("أسم المريض");
                                    // ignore: missing_return
                                  }
                                },
                                controller: username,
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(color: Colors.blue),
                                    hintText: "أسم المريض"
                                ),
                              ),
                              SizedBox(height: 5,),
                              TextFormField(
                                validator:(value) {
                                  if (value.isEmpty) {
                                    return _errorMessage("رقم الهاتف");
                                    // ignore: missing_return
                                  }
                                },
                                controller: phone,
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(color: Colors.blue),
                                    hintText: "رقم الهاتف"
                                ),
                              ),
                              SizedBox(height: 5,),
                              TextFormField(
                                validator:(value) {
                                  if (value.isEmpty) {
                                    return _errorMessage("عنوان السكن");
                                    // ignore: missing_return
                                  }
                                },
                                controller: location,
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(color: Colors.blue),
                                    hintText: "عنوان السكن"
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: new Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                      ),
                      elevation: 9,
                      color: Colors.white,
                      child: Container(
                        height: MediaQuery.of(context).size.height * .2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: kMainColor)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5,right: 5),
                              child: TextFormField(
                                minLines: 6,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                validator:(value) {
                                  if (value.isEmpty) {
                                    return _errorMessage("نوع المرض");
                                    // ignore: missing_return
                                  }
                                },
                                controller: note,
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(color: Colors.blue),
                                    hintText: "نوع المرض"
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15,bottom: 8,top: 8),
                    child: Builder(
                      builder: (context) => FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          if (_globalKey.currentState.validate()){
                            _globalKey.currentState.save();
                            try{
                              sendNow();
                              Fluttertoast.showToast(
                                  msg: "تم أرسال الطلب",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                              Navigator.pushNamed(context, Home.id);
                            }on PlatformException catch(e){

                            }
                          }
                        },
                        color: kMainColor,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20,bottom: 5,top: 5),
                          child: Center(
                            child: Text(
                                "طلب علاج طبيعي",
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
            ),
          ),
        ),
      ),
    );
  }
}
