import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'dart:math';
import 'Login.dart';



class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      appBar: AppBar(
        title: Text("Dashboard"),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
          }
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            //Background(),
            Details(),

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
  final _auth = FirebaseAuth.instance;
  FirebaseUser fbuser;
  String userName;
  String ans1;
  String ans2;
  String ans3;
  String ans4;
  String ans5;
  int count =0;
  String info;
  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {

    try {
      final user = await _auth.currentUser();
      if (user != null) {
        fbuser = user;
        userName = fbuser.email;
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {

    //calculate

   /* double min=97.0;
    //double max=105.0;
    String info;
    Random rnd = new Random();
    double temp = min+ rnd.nextDouble();
    String t = temp.toString();
    final startindex = t.indexOf('9');
    final finalindex = t.indexOf('.');
    String temperature = t.substring(startindex,finalindex+2);
    int cough = rnd.nextInt(100);
    int sneeze = rnd.nextInt(100);*/

    Firestore.instance.collection('info').document(userName).collection('Activities').getDocuments().then((QuerySnapshot snapshot){
      ans1=snapshot.documents[1]['Do you have Cough?'];
      ans2=snapshot.documents[1]['Do you have fever?is it responding to paracetamol?'];
      ans3=snapshot.documents[1]['Do you have breathlessness?'];
      ans4=snapshot.documents[1]['Travelled interstate/international in past 30 days?'];
      ans5=snapshot.documents[1]['Do you have cold/nose block/running nose?'];

      //((f)=>print('hello:${f['count']}')
      //((f)=>print('hello:${f['count']}')
      // globales.count = f.data['count']
      print("globes:$ans1");
      print("globes:$ans2");
      print("globes:$ans3");
      print("globes:$ans4");
      print("globes:$ans5");
      //  );
    });
    if(ans1 == 'yes')
      count = count+1;
    if(ans2 =='yes')
      count = count+1;
    if(ans3 == 'yes')
      count = count+1;
    if(ans4 == 'yes')
      count=count+1;
    if(ans5 == 'yes')
      count=count+1;
    print("count $count");
    if(count == 5)
    {
      info = "\nsince you have fever&\,you have cough/sneeze \nyou have breethelessness\nyou travelled interstate/international in past 30 days\nyou have cold/nose block/running nose\nyou need to visit nearby health center immediately.";
   // else
     // info = "\nyou don't have fever but\nyou coughed/sneezed beyond the safe limit,\nyou need to visit nearby \nhealth center immediately.";

    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Container(padding:EdgeInsets.only(top:20.0,left: 20.0),child: SvgPicture.asset('assets/bgr7.svg',height: 200.0,)),
/*            IconButton(
              onPressed: (){
                Details();
              },
              icon: Icon(Icons.person),
              color: Colors.red,
              iconSize: 200.0,
            ), */SizedBox(height: 40.0,),
            Container(
                decoration:  BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    border: Border.all(width: 1.0,color: Colors.black),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      //bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(40.0),
                    )
                ),
                padding: EdgeInsets.fromLTRB(25.0, 10.0, 0.0, 35.0),
                child: Text("$info",style: TextStyle(color: Colors.red[900],fontSize: 20.0),)),
            //  Text(,style: TextStyle(color: Colors.red,fontSize: 12.0),),


          ],
        ),),
    );
    }
    else if(count >= 3)
      {
          info =
          "\nyou have majority of the symptoms so please\ntake care of your health.";

          return Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(padding:EdgeInsets.only(top:20.0,left: 20.0),child: SvgPicture.asset('assets/bgy7.svg',height: 200.0,)),
/*                  IconButton(
                    onPressed: () {
                      Details();
                    },
                    icon: Icon(Icons.person),
                    color: Colors.yellowAccent,
                    iconSize: 200.0,
                  ), */SizedBox(height: 40.0,),
                  Container(
                      decoration:  BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          border: Border.all(width: 1.0,color: Colors.black),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            //bottomLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(40.0),
                          )
                      ),
                      padding: EdgeInsets.fromLTRB(25.0, 10.0, 0.0, 35.0),
                      child: Text("\n$info",
                        style: TextStyle(
                            color: Colors.yellow[900], fontSize: 20.0),)),

                ],
              ),),
          );
        }
        else {
          info =
          "\nyou don't have fever &\nyour coughing & sneezing is within safer limit.";
          return Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(padding:EdgeInsets.only(top:20.0,left: 20.0),child: SvgPicture.asset('assets/bgg7.svg',height: 200.0,)),
                  /*IconButton(
                    onPressed: () {
                      Details();
                    },
                    icon: Icon(Icons.person),
                    color: Colors.green,
                    iconSize: 200.0,
                  ),*/ SizedBox(height: 40.0,),
                  Container(
                      decoration:  BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          border: Border.all(width: 1.0,color: Colors.black),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            //bottomLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(40.0),
                          )
                      ),
                      padding: EdgeInsets.fromLTRB(25.0, 10.0, 0.0, 35.0),
                      child: Text("$info",
                        style: TextStyle(
                            color: Colors.green[900], fontSize: 20.0),)),

                ],
              ),),
          );
        }
      }
      }
