import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/back_transition.dart';
import 'package:flutter_application_1/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<Null> register(String name, String email, String pwd, String cpwd,
    BuildContext context) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: pwd);
    final docUser = FirebaseFirestore.instance.collection('Goals').doc();
    final json = {
      'name': name,
      'email': email,
      'stepGoals': 1000,
      'calGoal': 1000,
      'calBurnt': 0,
      'cal_intake': 0,
      'bgLevel': "0",
      'currentSteps': 0,
      'date': DateTime.now()
    };
    await docUser.set(json);
    Navigator.of(context).push(CustomPageRoute2(child: Home()));
    // return "true";
  } on FirebaseAuthException catch (e) {
    Fluttertoast.showToast(
        msg: e.message,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }
}

Future<Null> signin(String email, String pwd, BuildContext context) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pwd);

    var collection = FirebaseFirestore.instance.collection('Goals');
    var querySnapshot = await collection
        .where("email",
            isEqualTo: FirebaseAuth.instance.currentUser!.email.toString())
        .get();

    final Timestamp timestamp = querySnapshot.docs[0]['date'] as Timestamp;
    final DateTime prev = timestamp.toDate();
    num calgoal = querySnapshot.docs[0]['calGoal'];
    num calburnt = querySnapshot.docs[0]['calBurnt'];
    num calintake = querySnapshot.docs[0]['cal_intake'];
    num currentstep = querySnapshot.docs[0]['currentSteps'];
    num stepgoals = querySnapshot.docs[0]['stepGoals'];
    String bglvl = querySnapshot.docs[0]['bgLevel'];

    if (prev.day != DateTime.now().day ||
        prev.month != DateTime.now().month ||
        prev.year != DateTime.now().year) {
      final docUser1 = FirebaseFirestore.instance.collection('history').doc();
      final json1 = {
        'email': email,
        'stepGoals': stepgoals,
        'calGoal': calgoal,
        'calBurnt': calburnt,
        'cal_intake': calintake,
        'bgLevel': bglvl,
        'currentSteps': currentstep,
        'date': prev
      };

      await docUser1.set(json1);

      FirebaseFirestore.instance
          .collection('Goals')
          .where("email",
              isEqualTo: FirebaseAuth.instance.currentUser!.email.toString())
          .get()
          .then((querySnapshot) => {
                querySnapshot.docs.forEach((doc) => {
                      FirebaseFirestore.instance
                          .collection("Goals")
                          .doc(doc.id)
                          .update({
                        'stepGoals': 1000,
                        'calGoal': 1000,
                        'calBurnt': 0,
                        'cal_intake': 0,
                        'bgLevel': "0",
                        'currentSteps': 0,
                        'date': DateTime.now()
                      })
                    })
              });
    }
    Navigator.of(context).push(CustomPageRoute2(child: Home()));

    // return 'true';
  } on FirebaseAuthException catch (e) {
    Fluttertoast.showToast(
        msg: e.message,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white);
    // return e.message.toString();
  }
}
