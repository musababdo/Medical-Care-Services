
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicalcare/constants.dart';
import 'package:medicalcare/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyDate extends StatefulWidget {
  static String id='MyDate';
  @override
  _MyDateState createState() => _MyDateState();
}

class _MyDateState extends State<MyDate> {

  String id;

  Future cancelOrder(String id,String status) async{
    //var url = Uri.parse('http://10.0.2.2/medicalcare/cancel_doctor_order.php');
    var url = Uri.parse('https://h-o.sd/medicalcare/cancel_doctor_order.php');
    var response=await http.post(url, body: {
      "id"         : id,
      "status"     : status,
    });
    //json.decode(response.body);
    if(response.body.isNotEmpty) {
      json.decode(response.body);
    }
  }

  SharedPreferences preferences;
  Future getDoctorOrder() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      //print(preferences.getString("id"));
    });
    //var url = Uri.parse('http://10.0.2.2/medicalcare/display_doctor_order.php');
    var url = Uri.parse('https://h-o.sd/medicalcare/display_doctor_order.php');
    var response = await http.post(url, body: {
      "id": preferences.getString("id"),
    });
    var data = json.decode(response.body);
    return data;
  }

  Stream doctororders() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      yield await getDoctorOrder();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDoctorOrder();
  }

  @override
  Widget build(BuildContext context) {
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
              'مواعيدي',
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
          body: StreamBuilder(
            stream: doctororders(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              try {
                if(snapshot.data.length > 0 ){
                  return snapshot.hasData ?
                  ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        List list = snapshot.data;
                        id = list[index]['id'];
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            elevation: 8,
                            child:Column(
                              //mainAxisAlignment:MainAxisAlignment.start ,
                              children: <Widget>[
                                Container(
                                  height: 70,
                                  width: MediaQuery.of(context).size.width * 1,
                                  decoration: BoxDecoration(
                                    color: kMainColor,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20.0),
                                      topLeft: Radius.circular(20.0),
                                    ),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top:10),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              //a.time,
                                              list[index]['date'],
                                              style: GoogleFonts.cairo(
                                                textStyle: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width / 8,
                                            ),
                                            Icon(Icons.date_range,color: Colors.white,size: 33,),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(padding: const EdgeInsets.only(top:10)),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        //a.time,
                                        list[index]['hospital'],
                                        style: GoogleFonts.cairo(
                                          textStyle: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8,),
                                  Text(
                                    //a.time,
                                    list[index]['doctorname'],
                                    style: GoogleFonts.cairo(
                                      textStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                      SizedBox(height: 8,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          SizedBox(width: 5,),
                                          Text(
                                            list[index]['location'],
                                            style: GoogleFonts.cairo(
                                              textStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width / 8,
                                          ),
                                          Icon(Icons.location_on,color: kMainColor,),
                                        ],
                                      ),
                                      SizedBox(height: 8,),
                                      ButtonTheme(
                                        minWidth: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height * .08,
                                        child: Builder(
                                          builder: (context) => Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(32)
                                            ),
                                            elevation: 8,
                                            child: ElevatedButton.icon(
                                              icon: Icon(Icons.cancel,color: Colors.white,size: 35,),
                                              style: ElevatedButton.styleFrom(
                                                primary: kMainColor,
                                                onPrimary: Colors.black,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(32.0),
                                                ),
                                              ),
                                              onPressed: () {
                                                cancelDialog();
                                              },
                                              label: Padding(
                                                padding: const EdgeInsets.only(top: 8,bottom: 8,right: 35,left: 35),
                                                child: Text(
                                                  'الغاء الطلب',
                                                  style: GoogleFonts.cairo(
                                                    textStyle: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
                      child: Text('لايوجد مواعيد',
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
      ),
    );
  }
  cancelDialog(){
    showDialog(context: context,
        builder: (context){
          return AlertDialog(
            title: Text("تنبيه",style: GoogleFonts.cairo(
              textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),),
            content: Text('هل تود الغاء طلبا نهائيا ',style: GoogleFonts.cairo(
              textStyle: TextStyle(
                  fontSize: 18,
              ),
            ),),
            actions: <Widget>[
              FlatButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text("لا",style: GoogleFonts.cairo(
                    textStyle: TextStyle(
                        fontSize: 17,
                    ),
                  ),)
              ),
              FlatButton(
                  onPressed: (){
                    cancelOrder(id, "1");
                    Fluttertoast.showToast(
                        msg: "تم الغاء طلبك",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                    Navigator.pushNamed(context, Home.id);
                  },
                  child: Text("نعم",style: GoogleFonts.cairo(
                    textStyle: TextStyle(
                      fontSize: 17,
                    ),
                  ),)
              ),
            ],
          );
        }
    );
  }
}
