import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDialog extends StatefulWidget {

  MyDialog({Key key, this.mlocation}) : super(key: key);
  TextEditingController mlocation=new TextEditingController();

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {

  final location=["السبت", "الأحد", "الأثنين", "الثلاثاء", "الأربعاء", "الخميس", "الجمعه"];

  var items = List<String>();

  @override
  void initState() {
    // TODO: implement initState
    items.addAll(location);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: GestureDetector(
                onTap:(){
                  widget.mlocation.text=items[index];
                  Navigator.of(context).pop();
                },
                child: Text('${items[index]}',
                    style: GoogleFonts.cairo()
                ),
              )
          );
        },
      ),
    );
  }
}