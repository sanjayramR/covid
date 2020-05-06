//import 'package:covid/Dashboard.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend1db/Knowyourself.dart';
//import 'package:frontend1db/auth.dart';
import 'Info.dart';
import 'globals.dart'as globales;
//import 'globals.dart' as globales;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:frontend1db/Knowyourself.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FullScreenPage(),
    );
  }
}

class FullScreenPage extends StatefulWidget {
  @override
  _FullScreenPageState createState() => _FullScreenPageState();
}

class _FullScreenPageState extends State<FullScreenPage> {

  FirebaseUser fbuser;
  String userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'USER LOGIN',
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      resizeToAvoidBottomPadding: false,
      body: Container(
        //padding: EdgeInsets.only(bottom: 80.0),
        color: Colors.blueGrey[700],
        child: Stack(
          children: <Widget>[
//SizedBox(width: 200.0,),
          Container(padding:EdgeInsets.only(top:200.0,left: 60.0),child: SvgPicture.asset('assets/bg5.svg',height: 200.0,)),
            Home(),

          ],
        ),

      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _auth = FirebaseAuth.instance;
  //final AuthService _auth = AuthService();
  //String email;
  String password;
  String info;
 // String count ;
  final _fs = Firestore.instance;
  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Center(
        child: Form(
          key: _formKey,
          child: Column(
            ///crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Container(
                //padding: EdgeInsets.all(20.0),
                padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 15.0),
                margin: EdgeInsets.only(top:150.0,bottom: 90.0,right:80.0),

                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  border: Border.all(width: 1.0,color: Colors.black87),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
                child: Container(
                  child: TextFormField(

                    onChanged: (val) {
                      globales.email = val;
                    },
                    decoration: const InputDecoration(
                        icon: Icon(Icons.person, color: Colors.black, size: 40.0),
                        hintText: 'EmailId',
                        hintStyle: TextStyle(color: Colors.black),
                        labelText: 'Enter EmailId',
                        labelStyle: TextStyle(color: Colors.black)),
                    validator:(email){
                      Pattern pattern =
                      r'^([a-z0-9_\-\.]+)@([a-z.]+)\.([a-z]{2,5})$';
                      RegExp regex = new RegExp(pattern);
                      if (!regex.hasMatch(globales.email))
                        return 'Invalid username';
                      else
                        return null;
                    },

                  ),

                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 15.0),
                margin: EdgeInsets.only(top:10.0,bottom: 65.0,left:80.0),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    border: Border.all(width: 1.0,color: Colors.black),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    )
                ),
                child: Container(
                  child: TextFormField(
                    onChanged: (val) {
                      password = val;
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                        icon: Icon(
                          Icons.work,
                          color: Colors.black,
                          size: 40.0,
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.black),
                        labelText: 'Enter Your Password',
                        labelStyle: TextStyle(color: Colors.black)),
                    validator:(password){
                      Pattern pattern =
                          r'^[ A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                      RegExp regex = new RegExp(pattern);
                      if (!regex.hasMatch(password) )
                        return 'Invalid password/\npassword is less than 6 character';
                      else
                        return null;
                    },
                  ),
                ),
              ),



              Container(
                padding: EdgeInsets.only(left: 20.0, top: 30.0,bottom: 90.0),
                child:

                    Column(
                      children: <Widget>[

                        RaisedButton(
                            child: Text('login', style: TextStyle(fontSize: 20.0,),),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),),

                          onPressed: ()async{
                            Firestore.instance.collection('info').document('${globales.email}').collection('Activities').getDocuments().then((QuerySnapshot snapshot){
                              globales.count=snapshot.documents[0]['count'];
                              globales.name=snapshot.documents[0]['name'];
                              globales.phoneNo=snapshot.documents[0]['phone'];
                              globales.age=snapshot.documents[0]['age'];
                              globales.occupation=snapshot.documents[0]['occupation'];
                              globales.pincode=snapshot.documents[0]['pincode'];
                              globales.sex=snapshot.documents[0]['sex'];
                              globales.red=snapshot.documents[0]['red'];

                             // print("globes:${globales.count}");
                            });

                            if(_formKey.currentState.validate()) {
                               dynamic newUser;

                              try {
                                 newUser = await _auth.signInWithEmailAndPassword(
                                    email: globales.email,
                                     password: password,
                                 );
                              }
                              catch(e)
                            {
                              print(e);
                              newUser=null;
                              String i=e.toString();
                              final startindex = i.indexOf('(');
                              final finalindex = i.indexOf(',');
                              info = i.substring(startindex,finalindex);
                            }

                               if (newUser != null) {
                                 if(globales.count== '10')
                                   {
                                     globales.count='0';
                                   }
                                 if(globales.count == '0') {
                                  // print("count : $count");
                                   _fs.collection('info').document('${globales.email}').collection('Activities').document('Activity 1').setData({
                                     'count':globales.count,
                                     'red':globales.red,
                                   });
                                   showDialog(
                                     context: context,
                                     builder: (BuildContext context) {
                                       // return object of type Dialog
                                       return AlertDialog(
                                         title: new Text("Message"),
                                         content: new Text("Loged in as \n${globales.email}",),
                                         actions: <Widget>[
                                           // usually buttons at the bottom of the dialog
                                           new FlatButton(
                                             child: new Text("Ok"),
                                             onPressed: () {
                                               Navigator.of(context).pop();
                                             },),
                                         ],);
                                     },);

                                   Navigator.push(
                                     context,
                                     MaterialPageRoute(builder: (context) => Info()),
                                   );
                                 }
                                 else
                                   {
                                     double data = globales.distance;
                                     print(globales.distance);
                                     double data_meter = data * 1000;
                                     print("meterdistance:$data_meter");
                                     if (data_meter < 1.0) {
                                       //database
                                       Firestore.instance.collection('info').document(
                                           '${globales.email}')
                                           .collection('Activities')
                                           .getDocuments()
                                           .then((QuerySnapshot snapshot) {
                                         globales.red = snapshot.documents[0]['red'];
                                       });
                                       int r = int.parse(globales.red);
                                       r = r + 1;
                                       globales.red = r.toString();
                                     }
                                     int c = int.parse(globales.count);
                                     c=c+1;//print("intc:$c");
                                     globales.count = c.toString();
                                     _fs.collection('info').document('${globales.email}').collection('Activities').document('Activity 1').setData({
                                       'name': globales.name,
                                       'phone': globales.phoneNo,
                                       'age': globales.age,
                                       'occupation': globales.occupation,
                                       'pincode': globales.pincode,
                                       'sex': globales.sex,
                                       'count':globales.count,
                                       'red':globales.red,
                                     });

                                     showDialog(
                                       context: context,
                                       builder: (BuildContext context) {
                                         // return object of type Dialog
                                         return AlertDialog(
                                           title: new Text("Message"),
                                           content: new Text("Loged in as \n${globales.email}",),
                                           actions: <Widget>[
                                             // usually buttons at the bottom of the dialog
                                             new FlatButton(
                                               child: new Text("Ok"),
                                               onPressed: () {
                                                 Navigator.of(context).pop();
                                               },),
                                           ],);
                                       },);

                                     Navigator.push(
                                       context,
                                       MaterialPageRoute(builder: (context) => Knowyourself()),
                                     );
                                   }
                            }

                               else if(info == "(ERROR_NETWORK_REQUEST_FAILED")
                               {
                                 showDialog(
                                   context: context,
                                   builder: (BuildContext context) {
                                     // return object of type Dialog
                                     return AlertDialog(
                                       title: new Text("Message"),
                                       content: new Text("Poor Network Connection"),
                                       actions: <Widget>[
                                         // usually buttons at the bottom of the dialog
                                         new FlatButton(
                                           child: new Text("ok"),
                                           onPressed: () {
                                             Navigator.of(context).pop();},),
                                       ],);},);

                               }

                               else if(info == "(ERROR_WRONG_PASSWORD")
                               {
                                 showDialog(
                                   context: context,
                                   builder: (BuildContext context) {
                                     // return object of type Dialog
                                     return AlertDialog(
                                       title: new Text("Messsage"),
                                       content: new Text("Invalid Password"),
                                       actions: <Widget>[
                                         // usually buttons at the bottom of the dialog
                                         new FlatButton(
                                           child: new Text("ok"),
                                           onPressed: () {
                                             Navigator.of(context).pop();},),
                                       ],);},);

                               }

                            else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // return object of type Dialog
                                  return AlertDialog(
                                    title: new Text("Message"),
                                    content: new Text("sorry \n${globales.email} donot exist"),
                                    actions: <Widget>[
                                      // usually buttons at the bottom of the dialog
                                      new FlatButton(
                                        child: new Text("Ok"),
                                        onPressed: () {
                                          Navigator.of(context).pop();},),
                                    ],);},);
                               }}
                            },
                        ),
                      ],
                    ),

                ),
        ]
              )
        ),
      ),
    );
  }
}







