import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend1db/Dashboard.dart';
//import 'package:frontend1db/auth.dart';
import 'Knowyourself.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart';
import 'Dashboard.dart';




class Temperature extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FullScreenPage(),
    );
  }
}

class FullScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(
          'TEMPERATURE DETAILS',
        ),
        backgroundColor: Colors.black,
        centerTitle: true,

      ),
     // resizeToAvoidBottomPadding: false,
      body: Container(
        //padding: EdgeInsets.only(bottom: 80.0),
        color: Colors.blueGrey[700],
        child: Stack(
          children: <Widget>[
//SizedBox(width: 200.0,),
            Container(padding:EdgeInsets.only(top:200.0,left: 60.0),child: SvgPicture.asset('assets/bg5.svg',height: 200.0,)),
            Details(),
            RaisedButton(
              child: Text(
                'Detailed Report',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                  // bottomRight: Radius.circular(20.0),
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Dashboard()));
              },
            ),
          ],
        ),

      ),
    );
  }
}

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  void getTime() async{
Response response = await get('http://worldtimeapi.org/api/timezone/Asia/Kolkata');
Map data =jsonDecode(response.body);
//print(data);

//getting properties from jason
  String datetime = data['datetime'];
  String offset  = data['utc_ offset'];
 //print(datetime);
  print("hi$offset");

    //datetime object
    DateTime now = DateTime.parse(datetime);

    //print("hi $now");
   // now.add(Duration(hours: ))




}
  @override
  void initState(){
    super.initState();
        getTime();
  }


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}




