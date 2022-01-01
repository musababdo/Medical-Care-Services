
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medicalcare/constants.dart';
import 'package:medicalcare/doctors/confirmdoctor.dart';
import 'package:medicalcare/doctors/doctordate.dart';
import 'package:medicalcare/models/searchdoctor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ChooseDoctor extends StatefulWidget {
  static String id='choosedoctor';
  final List list;
  final int index;
  ChooseDoctor({this.list,this.index});
  @override
  _ChooseDoctorState createState() => _ChooseDoctorState();
}

class _ChooseDoctorState extends State<ChooseDoctor> {

  String city_id,speciality_id;

  List<SearchDoctor> _list = [];
  List<SearchDoctor> _search = [];
  var loading = false;

  final formatter = new NumberFormat("###,###");

  SharedPreferences preferences;
  Future getDoctor() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
//      print(preferences.getString("city_id"));
//      print(preferences.getString("speciality_id"));
    });
    //var url = Uri.parse('http://10.0.2.2/medicalcare/display_doctor.php');
    var url = Uri.parse('https://h-o.sd/medicalcare/display_doctor.php');
    var response = await http.post(url, body: {
      "city_id": preferences.getString("city_id"),
      "speciality_id": preferences.getString("speciality_id"),
    });
    var data = json.decode(response.body);
    //print(data);
    setState(() {
      for (Map i in data) {
        _list.add(SearchDoctor.formJson(i));
        loading = false;
      }
    });
    return data;
  }

  TextEditingController controller = new TextEditingController();

  onSearch(String text) async {
    _search.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _list.forEach((f) {
      if (f.name.contains(text) || f.id.toString().contains(text))
        _search.add(f);
    });

    setState(() {});
  }

  savePref(String name,String price,String time,String hospital,String location,String days) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("name", name);
      preferences.setString("price", price);
      preferences.setString("time", time);
      preferences.setString("hospital", hospital);
      preferences.setString("location", location);
      preferences.setString("days", days);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDoctor();
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
              'أختر طبيب',
              style: GoogleFonts.cairo(
                textStyle: TextStyle(
                    color: Colors.white
                ),
              ),
            ),
            leading: GestureDetector(
              onTap: () {
                //Navigator.pushNamed(context, DoctorSpeciality.id);
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          body: Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.search),
                      title: TextField(
                        controller: controller,
                        onChanged: onSearch,
                        decoration: InputDecoration(
                            hintText: "بحث عن طبيب",hintStyle: GoogleFonts.cairo(), border: InputBorder.none),),
                      trailing: IconButton(
                        onPressed: () {
                          controller.clear();
                          onSearch('');
                        },
                        icon: Icon(Icons.cancel),
                      ),
                    ),
                  ),
                ),
                loading
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    : Expanded(
                  child: _search.length != 0 || controller.text.isNotEmpty
                      ? ListView.builder(
                    itemCount: _search.length,
                    itemBuilder: (context, i) {
                      final b = _search[i];
                      List list = _search;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmDoctor(),),);
                            //Navigator.pushNamed(context, DoctorDate.id);
                            savePref(b.name,b.price,b.time,b.hospital,b.location,b.days);
                            //print(a.name);
                          },
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
                                      child: Text(
                                        b.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.cairo(
                                          textStyle: TextStyle(
                                              fontSize: 23,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold
                                          ),
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
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            //a.time,
                                            'زمن الأنتظار ${b.time} دقيقه',
                                            style: GoogleFonts.cairo(
                                              textStyle: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width / 8,
                                          ),
                                          Icon(Icons.timer,color: kMainColor,),
                                        ],
                                      ),
                                      SizedBox(height: 8,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            b.location,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.cairo(
                                              textStyle: TextStyle(
                                                  fontSize: 16,
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
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          SizedBox(width: 3,),
                                          Text(
                                            b.hospital,
                                            overflow:TextOverflow.ellipsis,
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
                                          Icon(Icons.local_hospital,color: kMainColor,),
                                        ],
                                      ),
                                      SizedBox(height: 8,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          SizedBox(width: 5,),
                                          Text(
                                            //a.price,
                                            'SDG ${formatter.format(int.parse(b.price))}',
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
                                          Icon(Icons.money,color: kMainColor,),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );;
                    },
                  )
                      : ListView.builder(
                    itemCount: _list.length,
                    itemBuilder: (context, i) {
                      final a = _list[i];
                      List<SearchDoctor> list = _list;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmDoctor(),),);
                            //Navigator.pushNamed(context, DoctorDate.id);
                            savePref(a.name,a.price,a.time,a.hospital,a.location,a.days);
                            //print(a.name);
                          },
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
                                      child: Text(
                                        a.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.cairo(
                                          textStyle: TextStyle(
                                              fontSize: 23,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold
                                          ),
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
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            //a.time,
                                            'زمن الأنتظار ${a.time} دقيقه',
                                            style: GoogleFonts.cairo(
                                              textStyle: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width / 8,
                                          ),
                                          Icon(Icons.timer,color: kMainColor,),
                                        ],
                                      ),
                                      SizedBox(height: 8,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            a.location,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.cairo(
                                              textStyle: TextStyle(
                                                  fontSize: 16,
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
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          SizedBox(width: 3,),
                                          Text(
                                            a.hospital,
                                            overflow:TextOverflow.ellipsis,
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
                                          Icon(Icons.local_hospital,color: kMainColor,),
                                        ],
                                      ),
                                      SizedBox(height: 8,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          SizedBox(width: 5,),
                                          Text(
                                            //a.price,
                                            'SDG ${formatter.format(int.parse(a.price))}',
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
                                          Icon(Icons.money,color: kMainColor,),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
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
