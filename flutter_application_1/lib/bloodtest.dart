import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/calories.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/back_transition.dart';
import 'package:flutter_application_1/signup.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/history.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Blood extends StatefulWidget {
  @override
  State<Blood> createState() => _BloodState();
}

class _BloodState extends State<Blood> {
  TextEditingController _bglevel = TextEditingController();
  String bglevel = "10";
  // @override
  // void initState() {
  //   super.initState();
  // }

  // fetchData() async {
  //   final Timestamp now = Timestamp.fromDate(DateTime.now());
  //   final Timestamp yesterday = Timestamp.fromDate(
  //     DateTime.now().subtract(const Duration(days: 1)),
  //   );
  //   var result = await FirebaseFirestore.instance
  //       .collection("bg level")
  //       .where("email",
  //           isEqualTo: FirebaseAuth.instance.currentUser!.email.toString())
  //       .where('date', isLessThanOrEqualTo: now, isGreaterThan: yesterday)
  //       .get();

  //   return result.docs.first['bg-level'];
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'signup page',
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF42BE6A),
              shadowColor: Colors.blueGrey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Blood Test',
                      style: GoogleFonts.lexendDeca(
                          color: Colors.white,
                          // fontFamily: 'Lexend Deca',
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    ),
                    new InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(CustomPageRoute1(child: Login()));
                      },
                      child: new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: new Text("SignOut",
                            style: GoogleFonts.lexendDeca(
                                color: Colors.white,
                                // fontFamily: 'Lexend Deca',
                                fontSize: 15,
                                fontWeight: FontWeight.w600)),
                      ),
                    )
                  ]),
            ),
            body: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 20),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Bounce(
                    child: Container(
                      child: Icon(
                        Icons.bloodtype,
                        color: Color(0xFFEC070C),
                        size: 150,
                      ),
                    ),
                    // infinite: true,
                    // delay: Duration(seconds: 3),
                  ),
                  SizedBox(height: 50),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50.0),
                              topRight: Radius.circular(50.0))),
                      child: Padding(
                          padding: EdgeInsets.all(30),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Current BG Level : ',
                                  style: GoogleFonts.lexendDeca(
                                    // fontFamily: 'Lexend Deca',
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('Goals')
                                        .where("email",
                                            isEqualTo: FirebaseAuth
                                                .instance.currentUser!.email
                                                .toString())
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Text('Loading...',
                                            style: GoogleFonts.lexendDeca(
                                                // fontFamily: 'Lexend Deca',
                                                color: Colors.white,
                                                fontSize: 20));
                                      }
                                      String bglvl =
                                          (snapshot.data as QuerySnapshot)
                                                  .docs[0]['bgLevel'] +
                                              ' ' +
                                              'mg/dl';
                                      return Column(
                                        children: [
                                          Text(bglvl,
                                              style: GoogleFonts.lexendDeca(
                                                  // fontFamily: 'Lexend Deca',
                                                  color: Colors.white,
                                                  fontSize: 20))
                                        ],
                                      );
                                    })
                              ],
                            )
                          ]))),
                  SizedBox(height: 25),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50.0),
                              bottomRight: Radius.circular(50.0))),
                      child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 30, 5, 30),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextFormField(
                                    controller: _bglevel,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 1,
                                      )),

                                      // labelText: 'Create a Password',
                                      filled: true,
                                      fillColor: Colors.white,
                                      // labelStyle: GoogleFonts.outfit(
                                      //     // fontFamily: 'outfit',
                                      //     color: Colors.black,
                                      //     fontSize: 14,
                                      //     fontWeight: FontWeight.normal),
                                      hintText:
                                          'Update Current BG Level (in mg/dL)',
                                      hintStyle: GoogleFonts.outfit(
                                          // fontFamily: 'outfit',
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              5, 20, 5, 20),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    )),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                        // width: 200,
                                        // height: 70,
                                        padding: EdgeInsets.all(10),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color.fromARGB(
                                                        255, 35, 95, 21)
                                                    .withOpacity(0.9),
                                                spreadRadius: 4,
                                                blurRadius: 4,
                                                offset: Offset(1, 1),
                                              )
                                            ],
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(12.0),
                                                bottomRight:
                                                    Radius.circular(12.0))),
                                        child: Column(children: [
                                          FlatButton(
                                            // padding: EdgeInsets.all(2.5),
                                            child: Text(
                                              'Update BG Level',
                                              style: GoogleFonts.lexendDeca(
                                                  // fontFamily: 'Lexend Deca',
                                                  color: Color.fromARGB(
                                                      255, 48, 120, 20),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15),
                                            ),

                                            // textColor:Colors.black , another way to define text color
                                            splashColor: Color.fromARGB(
                                                255, 255, 255, 255),
                                            // shape: StadiumBorder(),

                                            onPressed: () async {
                                              String bglvl1 = _bglevel.text;
                                              FirebaseFirestore.instance
                                                  .collection('Goals')
                                                  .where("email",
                                                      isEqualTo: FirebaseAuth
                                                          .instance
                                                          .currentUser!
                                                          .email
                                                          .toString())
                                                  .get()
                                                  .then((querySnapshot) => {
                                                        querySnapshot.docs
                                                            .forEach((doc) => {
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          "Goals")
                                                                      .doc(doc
                                                                          .id)
                                                                      .update({
                                                                    'bgLevel':
                                                                        bglvl1
                                                                  })
                                                                })
                                                      });
                                            },
                                          )
                                        ]))
                                  ],
                                )
                              ]))),
                  // SizedBox(height: 70),
                  Expanded(
                      child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    topLeft: Radius.circular(30))),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  new IconButton(
                                      icon: new Icon(
                                        Icons.home,
                                        color: Colors.black,
                                      ),
                                      onPressed: () async {
                                        await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Home()));
                                      }),
                                  new IconButton(
                                      icon: new Icon(
                                        Icons.fastfood,
                                        color: Colors.black,
                                      ),
                                      onPressed: () async {
                                        await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Calories()));
                                      }),
                                  new IconButton(
                                      icon: new Icon(
                                        Icons.bloodtype,
                                        color: Colors.white,
                                      ),
                                      color: Colors.white,
                                      onPressed: () =>
                                          Navigator.of(context).push),
                                  new IconButton(
                                      icon: new Icon(
                                        Icons.history,
                                        color: Colors.black,
                                      ),
                                      color: Colors.black,
                                      onPressed: () async {
                                        await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    History()));
                                      })
                                ]),
                          )))
                ],
              ),
            )));
  }
}
