import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/net/flutterfire.dart';
import 'package:flutter_application_1/back_transition.dart';
import 'package:flutter_application_1/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  TextEditingController _name = TextEditingController();
  TextEditingController _emailField = TextEditingController();
  TextEditingController _pwd = TextEditingController();
  TextEditingController _cpwd = TextEditingController();
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
                Container(
                    child: Icon(
                  Icons.person_pin_circle_rounded,
                  color: Colors.white,
                  size: 150,
                )),
                SizedBox(height: 20),
                Container(
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 25,
                        // fontFamily: 'outfit',
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(23.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                            controller: _name,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.white,
                                width: 1,
                              )),
                              // labelText: 'Enter Your Name',
                              filled: true,
                              fillColor: Colors.white,
                              // labelStyle: GoogleFonts.outfit(
                              //     // fontFamily: 'outfit',
                              //     color: Colors.black,
                              //     fontSize: 14,
                              //     fontWeight: FontWeight.normal),
                              hintText: 'Name',
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
                            controller: _emailField,
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
                            controller: _pwd,
                            obscureText: true,
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
                              hintText: 'Password (must be 6 characters long)',
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
                            controller: _cpwd,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.white,
                                width: 1,
                              )),
                              // labelText: 'Confirm Password',
                              filled: true,
                              fillColor: Colors.white,
                              // labelStyle: GoogleFonts.outfit(
                              //     // fontFamily: 'outfit',
                              //     color: Colors.black,
                              //     fontSize: 14,
                              //     fontWeight: FontWeight.normal),
                              hintText: 'Confirm Password',
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
                            width: 180,
                            height: 40,
                            // decoration: BoxDecoration(
                            //     color: Color.fromARGB(255, 0, 0, 0),
                            //     shape: BoxShape.rectangle,
                            //     borderRadius: BorderRadius.circular(10)),
                            child: FlatButton(
                                child: isLoading
                                    ? CircularProgressIndicator(
                                        color: Colors.black)
                                    : Text(
                                        'Register',
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
                                  await register(
                                      _name.text,
                                      _emailField.text.trim(),
                                      _pwd.text,
                                      _cpwd.text,
                                      context);
                                  setState(() => isLoading = false);
                                }))
                      ],
                    ))
              ]),
            )));
  }
}
