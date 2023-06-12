import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloodtest.dart';
import 'package:flutter_application_1/calories.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/back_transition.dart';
import 'package:flutter_application_1/signup.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/history.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int steps = 0;
  var message = "Press Button to Track Activity";
  int k = 0;
  final _formKey = GlobalKey<FormState>();
  String response = "";
  var df = [];
  double gposx = 0.0;
  double gposy = 0.0;
  double gposz = 0.0;

  double aposx = 0.0;
  double aposy = 0.0;
  double aposz = 0.0;
  // final String ip = "";

  var stopReading = false;
  String userID = "";
  late DocumentSnapshot doc;
  var collection = FirebaseFirestore.instance.collection('Goals');
  @override
  void initState() {
    super.initState();
  }

  void startReading() async {
    _setReadingState();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<void> saveData() async {
    final validation = _formKey.currentState?.validate();
    if (validation == false) {
      return;
    }
    _formKey.currentState?.save();
  }

  void _setReadingState() async {
    gyroscopeEvents.listen((GyroscopeEvent event) {
      gposx = event.x;
      gposy = event.y;
      gposz = event.z;
      setState(() {});
    });
    accelerometerEvents.listen((AccelerometerEvent event) {
      aposx = event.x;
      aposy = event.y;
      aposz = event.z;
      setState(() {});
    });

    String i = "http://192.168.1.70:5001";
    final url = Uri.parse(i);
    var response = await http.post(url,
        body: json.encode({
          'gposx': gposx,
          'gposy': gposy,
          'gposz': gposz,
          'aposx': aposx,
          'aposy': aposy,
          'aposz': aposz
        }));
    String j = "http://192.168.1.70:5001/result";
    final url1 = Uri.parse(j);
    try {
      var data = await http.get(url1);
      final decoded = jsonDecode(data.body);
      setState(() async {
        message = decoded['result'];

        if (decoded['result'] == "Walking") {
          var querySnapshot = await collection
              .where("email",
                  isEqualTo:
                      FirebaseAuth.instance.currentUser!.email.toString())
              .get();
          num newsteps = querySnapshot.docs[0]['currentSteps'] + 1;
          FirebaseFirestore.instance
              .collection('Goals')
              .where("email",
                  isEqualTo:
                      FirebaseAuth.instance.currentUser!.email.toString())
              .get()
              .then((querySnapshot) => {
                    querySnapshot.docs.forEach((doc) => {
                          FirebaseFirestore.instance
                              .collection("Goals")
                              .doc(doc.id)
                              .update({
                            'currentSteps': newsteps,
                            'calBurnt': querySnapshot.docs[0]['calBurnt'] + 0.04
                          })
                        })
                  });
        } else if (decoded['result'] == "Running") {
          var querySnapshot = await collection
              .where("email",
                  isEqualTo:
                      FirebaseAuth.instance.currentUser!.email.toString())
              .get();
          num newsteps = querySnapshot.docs[0]['currentSteps'] + 2;
          FirebaseFirestore.instance
              .collection('Goals')
              .where("email",
                  isEqualTo:
                      FirebaseAuth.instance.currentUser!.email.toString())
              .get()
              .then((querySnapshot) => {
                    querySnapshot.docs.forEach((doc) => {
                          FirebaseFirestore.instance
                              .collection("Goals")
                              .doc(doc.id)
                              .update({
                            'currentSteps': newsteps,
                            'calBurnt': querySnapshot.docs[0]['calBurnt'] + 0.08
                          })
                        })
                  });
        }
      });
    } catch (err) {
      setState(() {
        message = err.toString();
      });
    }
    //update currentstep in Goals collection here
    startReading();
  }

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
                      'Activity',
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
                            String stepgoal = (snapshot.data as QuerySnapshot)
                                    .docs[0]['stepGoals']
                                    .toString() +
                                ' ' +
                                'steps';

                            return Column(
                              children: [
                                Text(stepgoal,
                                    style: GoogleFonts.lexendDeca(
                                        // fontFamily: 'Lexend Deca',
                                        color: Colors.black,
                                        fontSize: 20))
                              ],
                            );
                          }),
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
                            // animation: true,
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
                        num totalstep = (snapshot.data as QuerySnapshot).docs[0]
                            ['stepGoals'];
                        num currentstep = (snapshot.data as QuerySnapshot)
                            .docs[0]['currentSteps'];
                        bool full = false;
                        if ((currentstep / totalstep) > 1) {
                          full = true;
                        }
                        return Column(
                          children: [
                            CircularPercentIndicator(
                              percent: full ? 1.0 : (currentstep / totalstep),
                              radius: 85,
                              lineWidth: 30,
                              // animation: true,
                              progressColor: Color.fromARGB(255, 71, 179, 96),
                              backgroundColor: Color.fromARGB(56, 64, 255, 0),
                              center: Text(
                                full
                                    ? "Max"
                                    : (currentstep / totalstep * 100)
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
                          'Total Steps Taken',
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
                              String currsteps =
                                  (snapshot.data as QuerySnapshot)
                                      .docs[0]['currentSteps']
                                      .toString();

                              return Column(
                                children: [
                                  Text(currsteps,
                                      style: GoogleFonts.lexendDeca(
                                          // fontFamily: 'Lexend Deca',
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500))
                                ],
                              );
                            })
                      ]),
                  SizedBox(height: 10),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              bottomRight: Radius.circular(25.0))),
                      child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Calories',
                                style: GoogleFonts.lexendDeca(
                                  // fontFamily: 'Lexend Deca',
                                  color: Colors.white,
                                  fontSize: 22,
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
                                              fontSize: 22));
                                    }
                                    num calburnt =
                                        (snapshot.data as QuerySnapshot).docs[0]
                                            ['calBurnt'];
                                    String calburnt1 =
                                        '${calburnt.toStringAsFixed(2)} kcal';
                                    return Column(
                                      children: [
                                        Text(calburnt1,
                                            style: GoogleFonts.lexendDeca(
                                                // fontFamily: 'Lexend Deca',
                                                color: Colors.white,
                                                fontSize: 22))
                                      ],
                                    );
                                  }),
                            ],
                          ))),
                  SizedBox(height: 10),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              bottomRight: Radius.circular(25.0))),
                      child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 3, 5, 3),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Current Activity',
                                  style: GoogleFonts.lexendDeca(
                                    // fontFamily: 'Lexend Deca',
                                    color: Colors.white,
                                    fontSize: 22,
                                  ),
                                ),
                              ],
                            ),
                            Swing(
                                child: Container(
                                    child: Icon(
                                  Icons.arrow_drop_down,
                                  color: Color(0xFFEC070C),
                                  size: 50,
                                )),
                                infinite: true),
                            Text(
                              "$message",
                              style: GoogleFonts.openSans(
                                // fontFamily: 'Lexend Deca',
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: (() async {
                                startReading();
                                setState(() {});
                              }),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white),
                              child: const Icon(
                                Icons.start,
                                color: Color.fromARGB(255, 6, 71, 8),
                              ),
                            ),
                          ]))),
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
                                children: [
                                  new IconButton(
                                      icon: new Icon(
                                        Icons.home,
                                        color: Colors.white,
                                      ),
                                      onPressed: () =>
                                          Navigator.of(context).push),
                                  new IconButton(
                                      icon: new Icon(
                                        Icons.fastfood,
                                        color: Colors.black,
                                      ),
                                      color: Colors.black,
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
