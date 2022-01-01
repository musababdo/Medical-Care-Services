
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medicalcare/constants.dart';
import 'package:medicalcare/models/nursemodel.dart';
import 'package:medicalcare/screens/home.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class proInfo {
  //Constructor
  String username;
  String phone;

  proInfo.fromJson(Map json) {
    username = json['username'];
    phone    = json['phone'];
  }
}

class Nurse extends StatefulWidget {
  static String id='Nurse';
  @override
  _HospitalsState createState() => _HospitalsState();
}

class _HospitalsState extends State<Nurse> {

  String username,phone;

  bool selected = false;
  var nurseModelStatus = List<bool>();
  var tmpArray = [];

  DateTime currentdate=new DateTime.now();
  String formatdate;

  Future<List<NurseModel>> getNurse() async{
    //var url = Uri.parse('http://10.0.2.2/medicalcare/display_nurse.php');
    var url = Uri.parse('https://h-o.sd/medicalcare/display_nurse.php');
    var response = await http.get(url);
    var data = json.decode(response.body);
    List<NurseModel> nurseModels = [];

    for (var u in data) {
      NurseModel nurseModel = NurseModel(u["id"], u["name"]);
      nurseModels.add(nurseModel);
      nurseModelStatus.add(false);
    }
    return nurseModels;
  }

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
      final items = (data['login'] as List).map((i) => new proInfo.fromJson(i));
      for (final item in items) {
        username = item.username;
        phone    = item.phone;
        print(username);
        print(phone);
      }
    });

    return data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNurse();
    getProfile();
  }

  Future sendNow() async{
    //var url = Uri.parse('http://10.0.2.2/medicalcare/nurse_order.php');
    var url = Uri.parse('https://h-o.sd/medicalcare/nurse_order.php');
    var response=await http.post(url, body: {
      "name"        : username,
      "phone"       : phone,
      "nursethings" : tmpArray.toString(),
      "time"        : formatdate
    });
    //json.decode(response.body);
    if(response.body.isNotEmpty) {
      json.decode(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    formatdate=new DateFormat('yyyy.MMMMM.dd hh:mm:ss aaa').format(currentdate);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
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
              'تمريض',
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
          body: Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: Column(
              children: [
                Text(
                    'الرجاء أختيار نوع التمريض',
                    style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    )
                ),
                SizedBox(
                  height:screenHeight * .02,
                ),
                Expanded(
                  flex: 8,
                  child: FutureBuilder(
                    future: getNurse(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      try {
                        if(snapshot.data.length > 0 ){
                          return snapshot.hasData ?
                          ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                List list = snapshot.data;
                                return Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: ListTile(
                                    title: Text(snapshot.data[index].name,style: GoogleFonts.cairo(
                                      textStyle: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),),
                                    trailing: Theme(
                                      data: ThemeData(unselectedWidgetColor: kMainColor),
                                      child: Checkbox(
                                          value: nurseModelStatus[index],
                                          activeColor: kMainColor,
                                          onChanged: (bool val) {
                                            setState(() {
                                              nurseModelStatus[index] = !nurseModelStatus[index];
                                              if(nurseModelStatus[index]==true){
                                                tmpArray.add(snapshot.data[index].name);
                                              }
                                            });
                                          }),
                                    ),
                                  ),
                                );
                              })
                              : new Center(
                            child: new CircularProgressIndicator(),
                          );
                        }else{
                          return Container(
                            height: screenHeight -
                                (screenHeight * .08) -
                                appBarHeight -
                                statusBarHeight,
                            child: Center(
                              child: Text('لايوجد',
                                style: GoogleFonts.cairo(
                                  textStyle: TextStyle(
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      }catch(e){
                        return new Center(
                          child: new CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height:screenHeight * .02,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15,bottom: 8),
                  child: Builder(
                    builder: (context) => FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        if(tmpArray.isEmpty){
                          Fluttertoast.showToast(
                              msg: "الرجاء الاختيار اولا",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }else{
                          sendNow();
                          Fluttertoast.showToast(
                              msg: "تم الأرسال",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                          Navigator.pushNamed(context, Home.id);
                        }
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
          ),
        ),
      ),
    );
  }
}
