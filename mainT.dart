//import 'package:covid/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'LoginT.dart';
import 'SignupT.dart';
import 'dart:convert';
import 'main.dart';
import 'globals.dart'as globales;
import 'package:http/http.dart' as http;
//import 'package:flutter_svg/flutter_svg.dart';
void mainT() => runApp(MyAppT());

class MyAppT extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPageT(),
    );
  }
}

class FirstPageT extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'TRACK-O-METER',
              style: TextStyle(fontSize: 20.0),
            ),
            centerTitle: true,
            backgroundColor: Colors.black,
          ),
          body: Container(
            padding: EdgeInsets.only(top: 10.0),
            child: Stack(
              children: <Widget>[

              //  Container(padding:EdgeInsets.only(top:10.0,left: 10.0),child: SvgPicture.asset('assets/home.svg',height: 200.0,)),
                button(),
              ],
            ),color: Colors.blueGrey[700],
          ),
        ),
      ),
    );
  }
}

class button extends StatefulWidget {
  @override
  _buttonState createState() => _buttonState();
}

class _buttonState extends State<button> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'வணக்கம், பயனர்\n',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue[100],
            ),
          ),SizedBox(height: 10.0),
          Text('புதிய பயனர்?', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.blue[100],),),
          Text("ஒரு கணக்கை உருவாக்க:",style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.blue[100],),),

          SizedBox(height: 10.0),
          RaisedButton(
            child: Text(
              'பதிவுபெறுதல்',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SignupT()));
            },
          ),
          SizedBox(height: 30.0),
          Text('தற்போதுள்ள பயனரா?', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.blue[100],),),
          Text("உள்நுழைய:",style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.blue[100],),),

          if(globales.currentPosition != null)
            Text("lat: ${globales.currentPosition.latitude},lang: ${globales.currentPosition.longitude}"),

          SizedBox(height: 10.0),
          RaisedButton(
            child: Text(
              'உள்நுழைய',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onPressed: () {
              try {
                createAlbum(globales.currentPosition.latitude,
                    globales.currentPosition.longitude);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => LoginT()));
                try {
                  double data = globales.distance;
                  double data_meter = data * 1000;
                  print("meterdistance:$data_meter");
                  String i = data_meter.toString();
                  if (data_meter < 1.0) {
                    final startindex = i.indexOf('0');
                    final finalindex = i.indexOf('.');
                    String info = i.substring(startindex, finalindex + 2);
                    print("info:$info");
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // return object of type Dialog
                        return AlertDialog(
                          title: new Text("தகவல்"),
                          content: Text(
                              "தூரம்$info,\nஉங்கள் இடத்திலிருந்து உடனடியாக நகர்த்தவும்",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,)),
                          actions: <Widget>[
                            // usually buttons at the bottom of the dialog
                            new FlatButton(
                              child: new Text("சரி"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },),
                          ],);
                      },);
                  }
                  else {
                    /* final startindex = i.indexOf('1');
                  final finalindex = i.indexOf('.');
                  String info = i.substring(startindex,finalindex+2);
                  print("info:$info");*/
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // return object of type Dialog
                        return AlertDialog(
                          title: new Text("தகவல்"),
                          content: Text("தூரம்:${globales.distance},",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,)),
                          actions: <Widget>[
                            // usually buttons at the bottom of the dialog
                            new FlatButton(
                              child: new Text("சரி"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },),
                          ],);
                      },);
                  }
                }
                catch (e) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // return object of type Dialog
                      return AlertDialog(
                        title: new Text("தகவல்"),
                        content: Text("கவனமாக இருக்கவும்,", style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green,)),
                        actions: <Widget>[
                          // usually buttons at the bottom of the dialog
                          new FlatButton(
                            child: new Text("சரி"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },),
                        ],);
                    },);
                }
              }
              catch(e){
               // globales.distance =2.0;
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                      title: new Text("தகவல்"),
                      content: Text("உங்கள் சாதன இருப்பிட பொத்தானை இயக்கி பயன்பாட்டை மறுதொடக்கம் செய்யுங்கள்.", style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black,)),
                      actions: <Widget>[
                        // usually buttons at the bottom of the dialog
                        new FlatButton(
                          child: new Text("சரி"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },),
                      ],);
                  },);
              }

            },
          ),
          Container(

            child: Column(
              children: <Widget>[
                SizedBox(width: 0.0,height: 40.0,),
                Text("TO CHANGE APP LANGUAGE:",style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.blue[100],),),

                RaisedButton(
                  child: Text("English",style: TextStyle(fontSize: 20.0,),),

                  onPressed: (){
                    this.setState((){
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => FirstPage()));
                    });
                  },
                ),
              ],
            ),

          ),
        ],
      ),
    );
  }
  Future<Album> createAlbum(double latitude,double longitude) async{

    final http.Response response = await http.post(
      'https://ceg-covid.herokuapp.com/latlong',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String,double>{
        'lat': latitude,
        'long': longitude,
      }),
    );
    if (response.statusCode == 200) {
      var data = response.body;
      var decodedData = jsonDecode(data); //"status": "Success"
      String postResult = decodedData['status'];

      if (postResult == "Success") {
        http.Response getResponse = await http.get('https://ceg-covid.herokuapp.com/latlong');
        print("status:${getResponse.statusCode}");
        if (getResponse.statusCode == 200) {
          var getData = getResponse.body;
          var getDecodedData = jsonDecode(getData);
          globales.distance = getDecodedData['value'];
          print("newvalue:${globales.distance}");
        }
      }
    }

    }

  }


class Album {
  final double longitude;
  final double latitude;


  Album({this.longitude, this.latitude});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      latitude: json['latitude'],
      longitude: json['longitude'],

    );
  }
}
