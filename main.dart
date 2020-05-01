//import 'package:covid/login.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'globals.dart'as globales;
import 'Login.dart';
import 'Signup.dart';
import 'mainT.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:// Column(
        //children: <Widget>[
          Splashscreen(),
         // FirstPage(),
       // ],
     // ),
    );
  }
}



class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {

    super.initState();
    _getCurrentLocation();
    Future.delayed(Duration(seconds: 5),(){print("hi");
      Navigator.push(
        context, MaterialPageRoute(
        builder: (context) => FirstPage()
      )
      );
     },
    );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'TRACK-O-METER',
            style: TextStyle(fontSize: 20.0),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
      color: Colors.black,
           ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 100.0,),
              Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/giphy.gif'),
                        radius: 200.0,
                      )
                    ] ,
                ),
              ),

              Column(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding:EdgeInsets.only(top:20.0),
                  ),
                  Text("Follow Social Distancing",style: TextStyle(color: Colors.white,fontSize: 18.0,fontWeight:FontWeight.bold),)
                ],
              ),




            ],
          )
        ],
      ),

    );
  }

  _getCurrentLocation(){
    double lat;
    double long;
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    try{
      geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best).then((Position position){
        setState((){
          globales.currentPosition = position;
          //print("latitude:${_currentPosition.latitude}");
        });
      });
    }
    catch(e){
      print("Exception1:$e");
    }
    //lat=_currentPosition.latitude;
    //String latitude=lat.toString();
    //String longitude=long.toString();
  }

}



class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    print("hi");
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
          body: Container(color: Colors.blueGrey[700],
            child: Stack(
                children: <Widget>[
                button(),

            ],),
        ),
      ),
    ),);
  }
}


class button extends StatefulWidget {
  @override
  _buttonState createState() => _buttonState();
}

class _buttonState extends State<button> {
  Future<Album> _futureAlbum;
  //Position _currentPosition;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'WELCOME,User\n',
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue[100],
            ),
          ),
          Text('New user?', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.blue[100],),),
          Text("create an account:",style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.blue[100],),),

          SizedBox(height: 10.0),

          RaisedButton(
            child: Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onPressed: () {

              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Signup()));
            },
          ),
          SizedBox(height: 30.0),
          Text('Existing User?', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.blue[100],),),
          Text("login:",style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.blue[100],),),

          SizedBox(height: 10.0),
          if(globales.currentPosition != null)
            Text("lat: ${globales.currentPosition.latitude},lang: ${globales.currentPosition.longitude}"),

          RaisedButton(
            child: Text(
              'Log In',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onPressed: () {
              createAlbum(globales.currentPosition.latitude,globales.currentPosition.longitude);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
             // print("dissss:${globales.distance}");


              try {
                double data = globales.distance;
                double data_meter = data * 1000;
                print("meterdistance:$data_meter");
                String i=data_meter.toString();
                if (data_meter < 1.0) {
                  final startindex = i.indexOf('0');
                  final finalindex = i.indexOf('.');
                  String info = i.substring(startindex,finalindex+2);
                  print("info:$info");
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // return object of type Dialog
                      return AlertDialog(
                        title: new Text("INFO"),
                        content: Text(
                            "distance$info,\nMove Away from your place imediately",
                            style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red,)),
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
                  final startindex = i.indexOf('1');
                  final finalindex = i.indexOf('.');
                  String info = i.substring(startindex,finalindex+2);
                  print("info:$info");
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // return object of type Dialog
                      return AlertDialog(
                        title: new Text("INFO"),
                        content: Text("distance:$info,", style: TextStyle(
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
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                      title: new Text("INFO"),
                      content: Text("BE SAFE,", style: TextStyle(
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

            },
          ),

          Container(

            child: Column(
              children: <Widget>[
                SizedBox(width: 0.0,height: 20.0,),
                Text("பயன்பாட்டு மொழியை மாற்ற:",style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.blue[100],),),

                    RaisedButton(
                      child: Text("தமிழ்",style: TextStyle(fontSize: 20.0,),),

                      onPressed: (){
                        this.setState((){
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => MyAppT()));
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
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
     globales.distance = data['result'];
     globales.value = data['Result'];
       print("distance:${globales.distance}");
       print("value:${globales.value}");
       //return Album.fromJson(json.decode(response.body));
      }
    else{
      print(response.statusCode);
      throw Exception('failed to load Album');
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


