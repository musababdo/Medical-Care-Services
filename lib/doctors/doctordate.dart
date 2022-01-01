
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medicalcare/constants.dart';
import 'package:medicalcare/models/daydoctor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorDate extends StatefulWidget {
  static String id='DoctorDate';
  @override
  _DoctorDateState createState() => _DoctorDateState();
}

class _DoctorDateState extends State<DoctorDate> {

  String name,price,time,hospital,location;

  final formatter = new NumberFormat("###,###");

  SharedPreferences preferences;
  getData() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString("name");
      price = preferences.getString("price");
      time = preferences.getString("time");
      hospital = preferences.getString("hospital");
      location = preferences.getString("location");
    });
  }

  SharedPreferences mpreferences;
  Future<List<DayDoctor>> loadDay() async {
    mpreferences = await SharedPreferences.getInstance();
    var data = await json.decode(mpreferences.getString("days"));
    List<DayDoctor> days=[];
    for(var d in data){
      DayDoctor day = DayDoctor(d["name"]);
      days.add(day);
    }
    return days;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    loadDay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0,
        title: Text(
          'حجز الطبيب',
          style: GoogleFonts.cairo(
            textStyle: TextStyle(
                color: Colors.white
            ),
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            //Navigator.pushNamed(context, ChooseDoctor.id);
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
                  height: MediaQuery.of(context).size.height * .1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          name,
                            style: GoogleFonts.cairo(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                fontSize: 18
                              ),
                            ),
                        ),
                        Text(
                          '  :  الاسم',
                          style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
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
                  height: MediaQuery.of(context).size.height * .1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'SDG ${formatter.format(int.parse(price))}',
                            style: GoogleFonts.cairo(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                              ),
                            ),
                        ),
                        Text(
                          '  :  السعر',
                            style: GoogleFonts.cairo(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
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
                  height: MediaQuery.of(context).size.height * .1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            hospital,
                              style: GoogleFonts.cairo(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                ),
                              ),
                          ),
                          Text(
                            '  :  المستشفي',
                            style: GoogleFonts.cairo(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      ),
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
                  height: MediaQuery.of(context).size.height * .1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                        'زمن الأنتظار ${time} دقيقه',
                            style: GoogleFonts.cairo(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                              ),
                            ),
                        ),
                        Text(
                          '  :  الزمن',
                          style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
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
                  height: MediaQuery.of(context).size.height * .1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          location,
                          style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Text(
                          '  :  الموقع',
                          style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15,5),
              child: new Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                elevation: 9,
                color: Colors.white,
                child: Container(
                  height: MediaQuery.of(context).size.height * .3,
                  width:  MediaQuery.of(context).size.width ,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20,left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            '  :  حجز',
                            style: GoogleFonts.cairo(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                    Expanded(
                      flex: 8,
                      child: FutureBuilder(
                        future: loadDay(),
                        builder: (BuildContext context, AsyncSnapshot snapshot){
                          if (snapshot.hasError) print(snapshot.error);
                          if(snapshot.data.length > 0 ){
                            return snapshot.hasData ?
                            ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  DayDoctor day = snapshot.data[index];
                                  print("//////////////////////////////////");
                                  print(day);
                                  print("//////////////////////////////////");
                                  return GestureDetector(
                                    onTap:(){
                                      //Navigator.push(context, MaterialPageRoute(builder: (context) => catigoryproduct(list: list,index: index,),),);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20)
                                        ),
                                        elevation: 8,
                                        child:Container(
                                          width: MediaQuery.of(context).size.width * .6,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(20.0),
                                                topLeft: Radius.circular(20.0)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 8),
                                            child: Text(
                                              day.name,
                                              style: GoogleFonts.cairo(
                                                textStyle: TextStyle(
                                                  fontSize: 18,
                                                  color:Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                })
                                : new Center(
                              child: new CircularProgressIndicator(),
                            );
                          }else{
                            return Center(
                              child: GestureDetector(
                                onTap:(){

                                },
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
                        },
                      ),
                    ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
