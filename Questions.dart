//import 'package:covid/Dashboard.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'dart:math';
import 'Knowyourself.dart';

class Questions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      appBar: AppBar(
        title: Text("Self Assessment"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),

      body:Stack(
          children: <Widget>[
           // background(),
            Container(padding:EdgeInsets.only(top:200.0,left: 60.0),child: SvgPicture.asset('assets/bg6.svg',height: 200.0,)),
            Formdetails(),
          ],
        ),
    );
  }
}


class background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Image.asset('assets/background1.jpg',),
        ],
      ),
    );
  }

}


class Formdetails extends StatefulWidget {
  @override
  _FormdetailsState createState() => _FormdetailsState();
}

class _FormdetailsState extends State<Formdetails> {
  final _fs = Firestore.instance;
  FirebaseUser fbuser;
  String userName;
  double value;
  bool checkvalue=false;





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

  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

  List<String> question = ['Qn1', 'Qn2', 'Qn3', 'Qn4', 'Qn5','Qn6', 'Qn7', 'Qn8', 'Qn9', 'Qn10','Qn11', 'Qn12','Qn13', 'Qn14','Qn15', 'Qn16'];
  String ans1, ans2, ans3, ans4,ans5, ans6, ans7, ans8,ans9, ans10, ans11, ans12,ans13, ans14,ans15, ans16;
  String qn1 = 'How is your health?';
  String qn2 = 'Do you have Cough?';
  String qn3 = 'Do you have cold/nose block/running nose?';
  String qn4 = 'Do you have breathlessness?';
  String qn5 = 'Do you have fever?is it responding to paracetamol?';
  String qn6 = 'Do you have generalized body pain?';
  String qn7 = 'Do you have loose motion';
  String qn8 = 'Do you have vomiting?';
  String qn9 = 'Travelled interstate/international in past 30 days?';
  String qn10 = 'Has anyone in your family travelled interstate/international in past 30 days?';
  String qn11 = 'Do you live in hotspot zone?';
  String qn12 = 'Do you work with CIVID19 patients?';
  String qn13 = 'Do you have asthma/respiratory distress/wheezing/TB?';
  String qn14 = 'Do you have Diabetics/Hypertension/History of heart attack/Hich cholestrol?';
  String qn15 = 'Do you have other chronic kidney/liver/lung/heart disease?';
  String qn16 = 'Do you have HIV/AIDS ?/Taking any medication reducing immunity?';


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Container(
                  padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                margin: EdgeInsets.only(top:0.0,bottom: 65.0,left:0.0,right: 0.0),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    border: Border.all(width: 1.0,color: Colors.white),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                     // bottomRight: Radius.circular(20.0),
                    )
                ),
                child:Center(child: Text("RESPIRATORY SYMPTOMS:",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),))
              ),

              Container(
                //padding: EdgeInsets.all(20.0),
                padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 15.0),
                margin: EdgeInsets.only(top:0.0,bottom: 70.0,right:70.0),

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
                      ans1 = val;
                    },
                    decoration: const InputDecoration(

                        hintText: 'Personal Health',
                        hintStyle: TextStyle(color: Colors.black),
                        labelText: 'How is your health?',
                        labelStyle: TextStyle(color: Colors.black)),
                    validator:(ans1){
                      if (ans1.isEmpty)
                        return 'Invalid answer';
                      else
                        return null;

                    },
                  ),
                ),
              ),

              Container(

                padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 15.0),
                margin: EdgeInsets.only(top:0.0,bottom: 65.0,left:20.0),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    border: Border.all(width: 1.0,color: Colors.black),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    )
                ),
                child:  TextFormField(
                    onChanged: (val) {
                      ans2 = val;
                    },
                    decoration: const InputDecoration(
                        hintText: 'If yes dry/with phlegm ',
                        hintStyle: TextStyle(color: Colors.black),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: .0),
                        labelText: 'Do you have Cough?',
                        labelStyle: TextStyle(color: Colors.black)),
                    validator:(ans2){
                      if (ans2.isEmpty)
                        return 'Invalid answer ';
                      else
                        return null;

                    },

                ),
              ),


              Container(
                //padding: EdgeInsets.all(20.0),
                padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 15.0),
                margin: EdgeInsets.only(top:0.0,bottom: 70.0,right:20.0),

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
                      ans3 = val;
                    },
                    decoration: const InputDecoration(

                        hintText: 'cold/nose block/running nose',
                        hintStyle: TextStyle(color: Colors.black),
                        labelText: 'cold/nose block/running nose?',
                        labelStyle: TextStyle(color: Colors.black)),
                    validator:(ans3){
                      if (ans3.isEmpty)
                        return 'Invalid answer';
                      else
                        return null;

                    },
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 15.0),
                margin: EdgeInsets.only(top:0.0,bottom: 65.0,left:20.0),
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
                      ans4 = val;
                    },
                    decoration: const InputDecoration(
                        hintText: 'Breathlessness',
                        hintStyle: TextStyle(color: Colors.black),
                        labelText: 'Do you have breathlessness?',
                        labelStyle: TextStyle(color: Colors.black)),
                    validator:(ans4){
                      if (ans4.isEmpty)
                        return 'Invalid answer ';
                      else
                        return null;

                    },
                  ),
                ),
              ),

              Container(
                  padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                  margin: EdgeInsets.only(top:0.0,bottom: 65.0,left:0.0,right: 0.0),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      border: Border.all(width: 1.0,color: Colors.white),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        // bottomRight: Radius.circular(20.0),
                      )
                  ),
                  child:Center(child: Text("FEVER SYMPTOMS:",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),))
              ),

              Container(
                //padding: EdgeInsets.all(20.0),
                padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 15.0),
                margin: EdgeInsets.only(top:0.0,bottom: 70.0,right:20.0),

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
                      ans5 = val;
                    },
                    decoration: const InputDecoration(

                        hintText: 'is it responding to paracetamol?',
                        hintStyle: TextStyle(color: Colors.black),
                        labelText: 'Do you have fever?',
                        labelStyle: TextStyle(color: Colors.black)),
                    validator:(ans5){

                      if (ans5.isEmpty)
                        return 'Invalid answer';
                      else
                        return null;

                    },
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 15.0),
                margin: EdgeInsets.only(top:0.0,bottom: 65.0,left:20.0),
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
                      ans6 = val;
                    },
                    decoration: const InputDecoration(
                        hintText: 'Generalized body pain',
                        hintStyle: TextStyle(color: Colors.black),
                        labelText: 'Do you have generalized body pain?',
                        labelStyle: TextStyle(color: Colors.black)),
                    validator:(ans6){
                      if (ans6.isEmpty)
                        return 'Invalid answer ';
                      else
                        return null;

                    },
                  ),
                ),
              ),

              Container(
                  padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                  margin: EdgeInsets.only(top:0.0,bottom: 65.0,left:0.0,right: 0.0),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      border: Border.all(width: 1.0,color: Colors.white),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        // bottomRight: Radius.circular(20.0),
                      )
                  ),
                  child:Center(child: Text("GASTROINTESTINAL SYMPTOMS:",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),))
              ),

              Container(
                //padding: EdgeInsets.all(20.0),
                padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 15.0),
                margin: EdgeInsets.only(top:0.0,bottom: 70.0,right:20.0),

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
                      ans7 = val;
                    },
                    decoration: const InputDecoration(

                        hintText: 'Personal Health',
                        hintStyle: TextStyle(color: Colors.black),
                        labelText: 'Do you have loose motion?',
                        labelStyle: TextStyle(color: Colors.black)),
                    validator:(ans7){

                      if (ans7.isEmpty)
                        return 'Invalid answer';
                      else
                        return null;

                    },
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 15.0),
                margin: EdgeInsets.only(top:0.0,bottom: 65.0,left:20.0),
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
                      ans8 = val;
                    },
                    decoration: const InputDecoration(
                        hintText: 'Personal Health',
                        hintStyle: TextStyle(color: Colors.black),
                        labelText: 'Do you have vomiting?',
                        labelStyle: TextStyle(color: Colors.black)),
                    validator:(ans8){
                      if (ans8.isEmpty)
                        return 'Invalid answer ';
                      else
                        return null;

                    },
                  ),
                ),
              ),

              Container(
                  padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                  margin: EdgeInsets.only(top:0.0,bottom: 65.0,left:0.0,right: 0.0),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      border: Border.all(width: 1.0,color: Colors.white),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        // bottomRight: Radius.circular(20.0),
                      )
                  ),
                  child:Column(
                    children: <Widget>[
                      Center(child: Text("TRAVEL/CONTACT HISTORY:",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                      Center(child: Text("for past 21 days ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14.0),)),

                    ],
                  )
              ),

              Container(
                //padding: EdgeInsets.all(20.0),
                padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 15.0),
                margin: EdgeInsets.only(top:0.0,bottom: 70.0,right:20.0),

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
                      ans9 = val;
                    },
                    decoration: const InputDecoration(

                        hintText: 'Travel History',
                        hintStyle: TextStyle(color: Colors.black),
                        labelText: 'Travelled interstate/international?',
                        labelStyle: TextStyle(color: Colors.black)),
                    validator:(ans9){

                      if (ans9.isEmpty)
                        return 'Invalid answer';
                      else
                        return null;

                    },
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 15.0),
                margin: EdgeInsets.only(top:0.0,bottom: 65.0,left:20.0),
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
                      ans10 = val;
                    },
                    decoration: const InputDecoration(
                        hintText: 'travelled interstate/international?',
                        hintStyle: TextStyle(color: Colors.black),
                        labelText: 'Anyone in your family?',
                        labelStyle: TextStyle(color: Colors.black)),
                    validator:(ans10){
                      if (ans10.isEmpty)
                        return 'Invalid answer ';
                      else
                        return null;

                    },
                  ),
                ),
              ),

              Container(
                //padding: EdgeInsets.all(20.0),
                padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 15.0),
                margin: EdgeInsets.only(top:0.0,bottom: 70.0,right:20.0),

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
                      ans11 = val;
                    },
                    decoration: const InputDecoration(

                        hintText: 'Travel History',
                        hintStyle: TextStyle(color: Colors.black),
                        labelText: 'Do you live in hotspot zone?',
                        labelStyle: TextStyle(color: Colors.black)),
                    validator:(ans11){

                      if (ans11.isEmpty)
                        return 'Invalid answer';
                      else
                        return null;

                    },
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 15.0),
                margin: EdgeInsets.only(top:0.0,bottom: 65.0,left:20.0),
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
                      ans12 = val;
                    },
                    decoration: const InputDecoration(
                        hintText: 'Travel History',
                        hintStyle: TextStyle(color: Colors.black),
                        labelText: 'Do you work with COVID19 patients??',
                        labelStyle: TextStyle(color: Colors.black)),
                    validator:(ans12){
                      if (ans12.isEmpty)
                        return 'Invalid answer ';
                      else
                        return null;

                    },
                  ),
                ),
              ),

              Container(
                  padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                  margin: EdgeInsets.only(top:0.0,bottom: 65.0,left:0.0,right: 0.0),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      border: Border.all(width: 1.0,color: Colors.white),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        // bottomRight: Radius.circular(20.0),
                      )
                  ),
                  child:Column(
                    children: <Widget>[
                      Center(child: Text("COMORBIDITIES:",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),Padding(
                        padding: EdgeInsets.only(right: 50.0,top: 10.0),
                      ),
                       Text("\tIf yes:\n\t\t\tOn regular medication/irregular medication/no-medication",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

                    ],
                  )
              ),

              Container(
                //padding: EdgeInsets.all(20.0),
                padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 15.0),
                margin: EdgeInsets.only(top:0.0,bottom: 70.0,right:20.0),

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
                      ans13 = val;
                    },
                    decoration: const InputDecoration(

                        hintText: 'Personal Health',
                        hintStyle: TextStyle(color: Colors.black),
                        labelText: 'Have asthma/respiratory distress/wheezing/TB?',
                        labelStyle: TextStyle(color: Colors.black)),
                    validator:(ans13){

                      if (ans13.isEmpty)
                        return 'Invalid answer';
                      else
                        return null;

                    },
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 15.0),
                margin: EdgeInsets.only(top:0.0,bottom: 65.0,left:20.0),
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
                      ans14 = val;
                    },
                    decoration: const InputDecoration(
                        hintText: 'Personal Health',
                        hintStyle: TextStyle(color: Colors.black),
                        labelText: 'Have Diabetics/BP/Hich cholestrol?',
                        labelStyle: TextStyle(color: Colors.black)),
                    validator:(ans14){
                      if (ans14.isEmpty)
                        return 'Invalid answer ';
                      else
                        return null;

                    },
                  ),
                ),
              ),


              Container(
                //padding: EdgeInsets.all(20.0),
                padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 15.0),
                margin: EdgeInsets.only(top:0.0,bottom: 70.0,right:20.0),

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
                      ans15 = val;
                    },
                    decoration: const InputDecoration(

                        hintText: 'Personal Health',
                        hintStyle: TextStyle(color: Colors.black),
                        labelText: 'Have kidney/liver/lung/heart disease?',
                        labelStyle: TextStyle(color: Colors.black)),
                    validator:(ans15){

                      if (ans15.isEmpty)
                        return 'Invalid answer';
                      else
                        return null;

                    },
                  ),
                ),
              ),


              Container(
                padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 15.0),
                margin: EdgeInsets.only(top:0.0,bottom: 65.0,left:20.0),
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
                      ans16 = val;
                    },
                    decoration: const InputDecoration(
                        hintText: 'personal health',
                        hintStyle: TextStyle(color: Colors.black),
                        labelText: 'Taking any medication for immunity?',
                        labelStyle: TextStyle(color: Colors.black)),
                    validator:(ans16){
                      if (ans16.isEmpty)
                        return 'Invalid answer ';
                      else
                        return null;

                    },
                  ),
                ),
              ),


              Container(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  //margin: EdgeInsets.only(top:0.0,bottom: 65.0,left:0.0),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      border: Border.all(width: 1.0,color: Colors.black),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        //bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      )
                  ),
                  child: Row(
                    children: <Widget>[
                      SizedBox(height: 50.0,),
                      Container(
                        child: Checkbox( value: checkvalue, onChanged:(bool value){
                          setState(() {
                            checkvalue=value;
                          });
                        }),
                        padding: EdgeInsets.only(left: 50.0),
                      ),SizedBox(height: 50.0,),
                      Text("Confirming my action"
                          ,style: TextStyle(color: Colors.black,fontSize: 18.0,fontWeight:FontWeight.bold,),overflow: TextOverflow.ellipsis,),
                    ],
                  )
              ),


              Container(
                padding: EdgeInsets.only(left: 140.0, top: 80.0),
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      if (checkvalue == true) {
                        Scaffold.of(context)
                            .showSnackBar(
                            SnackBar(content: Text('Data is in processing.')));
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Knowyourself()));
                      }
                      else {
                        Scaffold.of(context)
                            .showSnackBar(
                            SnackBar(content: Text('CONFIRM your action.')));
                      }

                    }

                    _fs.collection('info').document('$userName').collection('Activities').document('Activity 2').setData({
                      //'email': userName,
                      qn1: ans1,
                      qn2: ans2,
                      qn3: ans3,
                      qn4: ans4,
                      qn5: ans5,
                      qn6: ans6,
                      qn7: ans7,
                      qn8: ans8,
                      qn9: ans9,
                      qn10: ans10,
                      qn11: ans11,
                      qn12: ans12,
                      qn13: ans13,
                      qn14: ans14,
                      qn15: ans15,
                      qn16: ans16,
                    });

                  },
                  child: Text(
                    'proceed',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

