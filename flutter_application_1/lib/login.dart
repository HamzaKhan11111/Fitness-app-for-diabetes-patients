import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/back_transition.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'net/flutterfire.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;

  TextEditingController _emailField1 = TextEditingController();

  TextEditingController _pwd1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'signup page',
        home: Scaffold(
            backgroundColor: Color.fromARGB(255, 84, 201, 90),
            body: Container(
              child: Column(children: [
                SizedBox(height: 20),
                Container(
                    alignment: Alignment.topLeft,
                    child: Container(
                        color: Color.fromARGB(255, 84, 201, 90),
                        alignment: Alignment.topLeft,
                        child: new IconButton(
                            icon: new Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            iconSize: 40,
                            color: Colors.white,
                            onPressed: () => Navigator.of(context)
                                .push(CustomPageRoute1(child: HomePage()))))),
                SizedBox(height: 20),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.add_location_outlined,
                      color: Colors.white,
                      size: 130,
                    )),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Welcome!',
                    style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 32,
                        // fontFamily: 'outfit',
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                    padding: EdgeInsets.all(23.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                            controller: _emailField1,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.white,
                                width: 1,
                              )),
                              // labelText: 'Enter Your Email Address',
                              filled: true,
                              fillColor: Colors.white,
                              // labelStyle: GoogleFonts.outfit(
                              //     // fontFamily: 'outfit',
                              //     color: Colors.black,
                              //     fontSize: 14,
                              //     fontWeight: FontWeight.normal),
                              hintText: 'Email Address',
                              hintStyle: GoogleFonts.outfit(
                                  // fontFamily: 'outfit',
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                              contentPadding: EdgeInsets.all(20.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            )),
                        SizedBox(height: 20),
                        TextFormField(
                            obscureText: true,
                            controller: _pwd1,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.white,
                                width: 1,
                              )),
                              // labelText: 'Enter Your Password',
                              filled: true,
                              fillColor: Colors.white,
                              // labelStyle: GoogleFonts.outfit(
                              //     // fontFamily: 'outfit',
                              //     color: Colors.black,
                              //     fontSize: 14,
                              //     fontWeight: FontWeight.normal),
                              hintText: 'Password',
                              hintStyle: GoogleFonts.outfit(
                                  // fontFamily: 'outfit',
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                              contentPadding: EdgeInsets.all(20.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            )),
                        SizedBox(height: 25),
                        Container(
                            width: 230,
                            height: 50,
                            // decoration: BoxDecoration(
                            //     color: Color.fromARGB(255, 0, 0, 0),
                            //     shape: BoxShape.rectangle,
                            //     borderRadius: BorderRadius.circular(10)),
                            child: FlatButton(
                              child: isLoading
                                  ? CircularProgressIndicator(
                                      color: Colors.black)
                                  : Text(
                                      'Log In',
                                      style: GoogleFonts.lexendDeca(
                                          // fontFamily: 'Lexend Deca',
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                              color: Colors.white,
                              // textColor:Colors.black , another way to define text color
                              splashColor: Color.fromARGB(255, 255, 255, 255),
                              shape: StadiumBorder(),
                              onPressed: () async {
                                if (isLoading) return;
                                setState(() => isLoading = true);
                                await signin(_emailField1.text.trim(),
                                    _pwd1.text, context);
                                setState(() => isLoading = false);
                              },
                            ))
                      ],
                    ))
              ]),
            )));
  }
}
