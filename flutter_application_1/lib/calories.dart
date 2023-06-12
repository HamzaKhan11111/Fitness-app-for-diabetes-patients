import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloodtest.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/back_transition.dart';
import 'package:flutter_application_1/signup.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/history.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Calories extends StatefulWidget {
  @override
  State<Calories> createState() => _CaloriesState();
}

class _CaloriesState extends State<Calories> {
  final List<String> items1 = ["Pastery", "Chocolate", "Burger"];
  final List<String> items2 = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10"
  ];
  final json1 = {"Pastery": 550, "Chocolate": 540, "Burger": 300};
  final json2 = {
    "1": 1,
    "2": 2,
    "3": 3,
    "4": 4,
    "5": 5,
    "6": 6,
    "7": 7,
    "8": 8,
    "9": 9,
    "10": 10
  };
  String values = "";
  String values1 = "";
  String foodItem = "";
  String foodQuantity = "";
  num currentcal = 240;
  num totalcal = 1000;
  bool isLoading = false;
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
                      'Calories',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Today\'s Goal',
                        style: GoogleFonts.lexendDeca(
                          // fontFamily: 'Lexend Deca',
                          color: Color(0xFF42BE6A),
                          fontSize: 24,
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
                                      color: Colors.black,
                                      fontSize: 20));
                            }
                            String calgoal = (snapshot.data as QuerySnapshot)
                                    .docs[0]['calGoal']
                                    .toString() +
                                ' ' +
                                'Kcal';
                            setState(() async {
                              totalcal = await (snapshot.data as QuerySnapshot)
                                  .docs[0]['calGoal'];
                            });
                            return Column(
                              children: [
                                Text(calgoal,
                                    style: GoogleFonts.lexendDeca(
                                        // fontFamily: 'Lexend Deca',
                                        color: Colors.black,
                                        fontSize: 20))
                              ],
                            );
                          })
                    ],
                  ),
                  SizedBox(height: 50),
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
                          return CircularPercentIndicator(
                            percent: 0.0,
                            radius: 85,
                            lineWidth: 30,
                            animation: true,
                            progressColor: Color.fromARGB(255, 71, 179, 96),
                            backgroundColor: Color.fromARGB(56, 64, 255, 0),
                            center: Text(
                              "...",
                              style: GoogleFonts.mukta(
                                  // fontFamily: 'Mukta',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                            ),
                            startAngle: 0,
                          );
                        }
                        num calgoal =
                            (snapshot.data as QuerySnapshot).docs[0]['calGoal'];
                        num calintake = (snapshot.data as QuerySnapshot).docs[0]
                            ['cal_intake'];
                        bool full = false;
                        if ((calintake / calgoal) > 1) {
                          full = true;
                        }
                        return Column(
                          children: [
                            CircularPercentIndicator(
                              percent: full ? 1.0 : (calintake / calgoal),
                              radius: 85,
                              lineWidth: 30,
                              animation: true,
                              progressColor: full
                                  ? Colors.red
                                  : Color.fromARGB(255, 71, 179, 96),
                              backgroundColor: full
                                  ? Colors.red
                                  : Color.fromARGB(56, 64, 255, 0),
                              center: Text(
                                full
                                    ? "Max"
                                    : (calintake / calgoal * 100)
                                            .toStringAsFixed(1) +
                                        " " +
                                        "%",
                                style: GoogleFonts.mukta(
                                    // fontFamily: 'Mukta',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ),
                              startAngle: 0,
                            ),
                          ],
                        );
                      }),
                  SizedBox(height: 30),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Total Calories Taken',
                          style: GoogleFonts.raleway(
                              // fontFamily: 'Raleway',
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        Swing(
                            child: Container(
                                child: Icon(
                              Icons.arrow_right,
                              color: Color(0xFFEC070C),
                              size: 50,
                            )),
                            infinite: true),
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
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500));
                              }
                              String calint = (snapshot.data as QuerySnapshot)
                                      .docs[0]['cal_intake']
                                      .toString() +
                                  ' ' +
                                  'Calories';
                              setState(() async {
                                currentcal =
                                    await (snapshot.data as QuerySnapshot)
                                        .docs[0]['cal_intake'];
                              });
                              return Column(
                                children: [
                                  Text(calint,
                                      style: GoogleFonts.lexendDeca(
                                          // fontFamily: 'Lexend Deca',
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500))
                                ],
                              );
                            })
                      ]),
                  SizedBox(height: 50),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              bottomRight: Radius.circular(25.0))),
                      child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 30),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 180,
                                  height: 50,
                                  padding: EdgeInsets.all(1),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25.0))),
                                  // child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none),
                                    hint: const Text('Food'),
                                    value: values,
                                    onChanged: (String? value) {
                                      setState(() {
                                        values = value!;
                                      });
                                      iconEnabledColor:
                                      Colors.black;
                                      iconSize:
                                      30;
                                      style:
                                      GoogleFonts.lexendDeca(
                                        color: Color.fromARGB(255, 7, 118, 4),
                                        fontSize: 15,
                                      );
                                    },
                                    onSaved: (String? value) {
                                      setState(() {
                                        values = value!;
                                      });
                                      iconEnabledColor:
                                      Colors.black;
                                      iconSize:
                                      30;
                                      style:
                                      GoogleFonts.lexendDeca(
                                        color: Color.fromARGB(255, 7, 118, 4),
                                        fontSize: 15,
                                      );
                                    },
                                    items: items1.map(
                                      (String e) {
                                        return DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                                Container(
                                  width: 180,
                                  height: 50,
                                  padding: EdgeInsets.all(1),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25.0))),
                                  // child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none),
                                    hint: const Text('Quantity'),
                                    value: values1,
                                    onChanged: (String? value) {
                                      setState(() {
                                        values1 = value!;
                                      });
                                      iconEnabledColor:
                                      Colors.black;
                                      iconSize:
                                      30;
                                      style:
                                      GoogleFonts.lexendDeca(
                                        color: Color.fromARGB(255, 7, 118, 4),
                                        fontSize: 15,
                                      );
                                    },
                                    onSaved: (String? value) {
                                      setState(() {
                                        values1 = value!;
                                      });
                                      iconEnabledColor:
                                      Colors.black;
                                      iconSize:
                                      30;
                                      style:
                                      GoogleFonts.lexendDeca(
                                        color: Color.fromARGB(255, 7, 118, 4),
                                        fontSize: 15,
                                      );
                                    },
                                    items: items2.map(
                                      (String e) {
                                        return DropdownMenuItem(
                                            value: e, child: Text(e));
                                      },
                                    ).toList(),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Container(
                                width: 200,
                                height: 40,
                                padding: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromARGB(255, 35, 95, 21)
                                            .withOpacity(0.9),
                                        spreadRadius: 4,
                                        blurRadius: 4,
                                        offset: Offset(1, 1),
                                      )
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: FlatButton(
                                  // padding: EdgeInsets.all(10),
                                  child: isLoading
                                      ? CircularProgressIndicator(
                                          color: Colors.black)
                                      : Text(
                                          'Update Calories',
                                          style: GoogleFonts.lexendDeca(
                                              // fontFamily: 'Lexend Deca',
                                              color: Color.fromARGB(
                                                  255, 48, 120, 20),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15),
                                        ),

                                  // textColor:Colors.black , another way to define text color
                                  splashColor:
                                      Color.fromARGB(255, 255, 255, 255),
                                  // shape: StadiumBorder(),

                                  onPressed: () async {
                                    if (isLoading) return;
                                    setState(() => isLoading = true);
                                    final docUser = FirebaseFirestore.instance
                                        .collection('calories')
                                        .doc();
                                    final json = {
                                      'email': FirebaseAuth
                                          .instance.currentUser!.email
                                          .toString(),
                                      'foodItem': values,
                                      'foodQuantity': json2[values1],
                                      'date': DateTime.now()
                                    };
                                    await docUser.set(json);
                                    var collection = FirebaseFirestore.instance
                                        .collection('Goals');

                                    var querySnapshot = await collection
                                        .where("email",
                                            isEqualTo: FirebaseAuth
                                                .instance.currentUser!.email
                                                .toString())
                                        .get();

                                    final calintake =
                                        querySnapshot.docs[0]['cal_intake'];
                                    num? foodcal = json1[values];
                                    num? qty = json2[values1];
                                    FirebaseFirestore.instance
                                        .collection('Goals')
                                        .where("email",
                                            isEqualTo: FirebaseAuth
                                                .instance.currentUser!.email
                                                .toString())
                                        .get()
                                        .then((querySnapshot) => {
                                              querySnapshot.docs
                                                  .forEach((doc) => {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection("Goals")
                                                            .doc(doc.id)
                                                            .update({
                                                          'cal_intake':
                                                              calintake +
                                                                  (foodcal! *
                                                                      qty!),
                                                        })
                                                      })
                                            });
                                    setState(() {
                                      foodItem = values;
                                      foodQuantity = values1;
                                      isLoading = false;
                                    });
                                  },
                                ))
                          ]))),
                  // SizedBox(height: 40),
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
                                        color: Colors.white,
                                      ),
                                      onPressed: () =>
                                          Navigator.of(context).push),
                                  new IconButton(
                                      icon: new Icon(
                                        Icons.bloodtype,
                                        color: Colors.black,
                                      ),
                                      color: Colors.black,
                                      onPressed: () async {
                                        await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Blood()));
                                      }),
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
