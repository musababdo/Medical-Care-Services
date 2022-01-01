
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicalcare/constants.dart';
import 'package:medicalcare/screens/home.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


class EmergencyDoctor extends StatefulWidget {
  static String id='EmergencyDoctor';
  @override
  _EmergencyDoctorState createState() => _EmergencyDoctorState();
}

class _EmergencyDoctorState extends State<EmergencyDoctor> {

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  String _chosenValue;

  TextEditingController  hospital   = new TextEditingController();
  TextEditingController  speciality = new TextEditingController();
  TextEditingController  phone      = new TextEditingController();
  TextEditingController  from       = new TextEditingController();
  TextEditingController  to         = new TextEditingController();

  DateTime currentdate=new DateTime.now();
  String formatdate;

  Future sendNow() async{
    //var url = Uri.parse('http://10.0.2.2/medicalcare/doctor_order.php');
    var url = Uri.parse('https://h-o.sd/medicalcare/emergencydoctor.php');
    var response=await http.post(url, body: {
      "hospital"   : hospital.text,
      "speciality" : speciality.text,
      "phone"      : phone.text,
      "day"        : _chosenValue,
      "from"       : from.text,
      "to"         : to.text,
      "date"       : formatdate
    });
    //json.decode(response.body);
    if(response.body.isNotEmpty) {
      json.decode(response.body);
    }
  }

  String _errorMessage(String hint) {
    if(hint=="أسم المستشفي"){
      return 'الرجاء ادخال اسم المستشفي';
    }else if(hint=="التخصص"){
      return 'الرجاء ادخال التخصص';
    }else if(hint=="رقم الهاتف"){
      return 'الرجاء ادخال رقم الهاتف';
    }else if(hint=="من"){
      return 'الرجاء ادخال التاريخ';
    }else if(hint=="الي"){
      return 'الرجاء ادخال التاريخ';
    }
  }

  @override
  void initState() {
    from.text = "";
    to.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    formatdate=new DateFormat('yyyy.MMMMM.dd hh:mm:ss aaa').format(currentdate);
    final double screenHeight = MediaQuery.of(context).size.height;
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
                'طلب طبيب',
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
                  SizedBox(
                    height:screenHeight * .07,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                    child: Container(
                      //height: MediaQuery.of(context).size.height * .4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all()),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8,right: 8),
                                child: TextFormField(
                                  validator:(value) {
                                    if (value.isEmpty) {
                                      return _errorMessage("أسم المستشفي");
                                      // ignore: missing_return
                                    }
                                  },
                                  controller: hospital,
                                  decoration: InputDecoration(
                                      hintStyle: TextStyle(color: Colors.blue),
                                      hintText: "أسم المستشفي"
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 8,),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all()),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8,right: 8),
                                child: TextFormField(
                                  validator:(value) {
                                    if (value.isEmpty) {
                                      return _errorMessage("التخصص");
                                      // ignore: missing_return
                                    }
                                  },
                                  controller: speciality,
                                  decoration: InputDecoration(
                                      hintStyle: TextStyle(color: Colors.blue),
                                      hintText: "التخصص"
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 8,),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all()),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8,right: 8),
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
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
                              ),
                            ),
                            SizedBox(height: 8,),
                            Container(
                              width: MediaQuery.of(context).size.width * 2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all()),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8,right: 8),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _chosenValue,
                                    //elevation: 5,
                                    style: TextStyle(color: Colors.black),

                                    items: <String>[
                                      'السبت',
                                      'الأحد',
                                      'الأثنين',
                                      'الثلاثاء',
                                      'الأربعاء',
                                      'الخميس',
                                      'الجمعه',
                                    ].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    hint: Text(
                                      "أختر يوم",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    onChanged: (String value) {
                                      setState(() {
                                        _chosenValue = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 8,),
                            Text(
                                'الفتره الزمنيه',
                                style: GoogleFonts.cairo(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                            ),
                            SizedBox(height: 8,),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all()),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8,right: 8),
                                child: TextFormField(
                                  validator:(value) {
                                    if (value.isEmpty) {
                                      return _errorMessage("من");
                                      // ignore: missing_return
                                    }
                                  },
                                  controller: from,
                                  decoration: InputDecoration(
                                      hintStyle: TextStyle(color: Colors.blue),
                                      hintText: "من"
                                  ),
                                    onTap: () async {
                                      DateTime pickedDate = await showDatePicker(
                                          context: context, initialDate: DateTime.now(),
                                          firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                          lastDate: DateTime(2101)
                                      );

                                      if(pickedDate != null ){
                                        print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                        print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                        //you can implement different kind of Date Format here according to your requirement

                                        setState(() {
                                          from.text = formattedDate; //set output date to TextField value.
                                        });
                                      }else{
                                        print("Date is not selected");
                                      }
                                    }
                                ),
                              ),
                            ),
                            SizedBox(height: 8,),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all()),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8,right: 8),
                                child: TextFormField(
                                    validator:(value) {
                                      if (value.isEmpty) {
                                        return _errorMessage("الي");
                                        // ignore: missing_return
                                      }
                                    },
                                    controller: to,
                                    decoration: InputDecoration(
                                        hintStyle: TextStyle(color: Colors.blue),
                                        hintText: "الي"
                                    ),
                                    onTap: () async {
                                      DateTime pickedDate = await showDatePicker(
                                          context: context, initialDate: DateTime.now(),
                                          firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                          lastDate: DateTime(2101)
                                      );

                                      if(pickedDate != null ){
                                        print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                        print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                        //you can implement different kind of Date Format here according to your requirement

                                        setState(() {
                                          to.text = formattedDate; //set output date to TextField value.
                                        });
                                      }else{
                                        print("Date is not selected");
                                      }
                                    }
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
