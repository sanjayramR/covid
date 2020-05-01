//import 'package:covid/Dashboard.dart';
import 'package:flutter/material.dart';
//import 'package:frontend1db/auth.dart';
import 'Info.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';



class Login extends StatelessWidget {
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
  String email;
  String password;
  String info;
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
                      email = val;
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
                      if (!regex.hasMatch(email))
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
                child: RaisedButton(
                    child: Text('login', style: TextStyle(fontSize: 20.0,),),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),),


                  onPressed: ()async{
                    if(_formKey.currentState.validate()) {
                       dynamic newUser;
                      //DB validation
                      try {
                         newUser = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
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
                        showDialog(
                        context: context,
                        builder: (BuildContext context) {
      // return object of type Dialog
                        return AlertDialog(
                        title: new Text("Message"),
                        content: new Text("Loged in as \n$email",),
                         actions: <Widget>[
      // usually buttons at the bottom of the dialog
                          new FlatButton(
                         child: new Text("Ok"),
                         onPressed: () {
                          Navigator.of(context).pop();},),
      ],);},);

                         Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Info()),
                      );
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
                            content: new Text("sorry \n$email donot exist"),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}



