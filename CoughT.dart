//import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:frontend1db/auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:intl/intl.dart';
//import 'package:http/http.dart';
import 'DashboardT.dart';

class CoughT extends StatelessWidget {
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
          'இருமல் விவரங்கள்',
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


          ],
        ),

      ),
    );
  }
}

class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //calculate

    return
      Column(
        children: <Widget>[
          Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  border: Border.all(width: 1.0, color: Colors.black),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    //bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(40.0),
                  )
              ),
              padding: EdgeInsets.fromLTRB(20.0, 50.0, 0.0, 50.0),
              child: Text(
                "cough 10 time :\n29 April 2020 at 12:30:31 UTC+5:30 2 times :\n26 April 2020 at 11:12:32 UTC+5:30 3 times :\n25 April 2020 at 09:05:45 UTC+5:30 4 times :\n24 April 2020 at 02:06:30 UTC+5:30 5 times :\n28 April 2020 at 12:12:20 UTC+5:30 6 times :\n27 April 2020 at 07:08:50 UTC+5:30 7 times :\n30 April 2020 at 03:04:20 UTC+5:30",

                style: TextStyle(color: Colors.red[900], fontSize: 20.0),),
            ),
          ),
          RaisedButton(
            child: Text(
              'விரிவான அறிக்கை',
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
                  context, MaterialPageRoute(builder: (context) => DashboardT()));
            },
          ),
        ],
      );
  }

}




