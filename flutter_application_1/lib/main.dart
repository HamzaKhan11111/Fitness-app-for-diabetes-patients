import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/back_transition.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/signup.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:firebase_setup/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    title: 'Fitness App',
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 84, 201, 90),
      body: Container(
          child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
        child: Column(children: [
          Expanded(
              child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.medical_services,
                color: Colors.white,
                size: 150,
              ),
            ],
          )),
          Expanded(
              child: Column(
            children: [
              Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(-5, 0),
                    )
                  ]),
                  child: FlatButton(
                    child: Text(
                      'Register',
                      style: GoogleFonts.lexendDeca(
                          // fontFamily: 'Lexend Deca',
                          color: Color.fromARGB(255, 255, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      // side: BorderSide(
                      //     color: Color.fromARGB(255, 255, 255, 255))
                    ),
                    onPressed: () => Navigator.of(context)
                        .push(CustomPageRoute2(child: SignUp())),
                    color: Colors.white,
                  )),
              SizedBox(height: 20),
              Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(-5, 0),
                    )
                  ]),
                  width: 200,
                  height: 50,
                  child: FlatButton(
                    child: Text(
                      'Login',
                      style: GoogleFonts.lexendDeca(
                          // fontFamily: 'Lexend Deca',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      // side: BorderSide(
                      //     color: Color.fromARGB(255, 255, 255, 255))
                    ),
                    onPressed: () => Navigator.of(context)
                        .push(CustomPageRoute2(child: Login())),
                    color: Colors.white,
                  )),
            ],
          ))
        ]),
      )),
    );
  }
}
