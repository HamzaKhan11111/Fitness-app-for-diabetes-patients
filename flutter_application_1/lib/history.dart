import 'package:flutter/material.dart';
import 'package:flutter_application_1/calories.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/back_transition.dart';
import 'package:flutter_application_1/signup.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/bloodtest.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:fl_chart/fl_chart.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'History page',
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
                      'History',
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
              child: SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: 10),
                      child: IntrinsicHeight(
                          child: Column(
                        children: [
                          Text(
                            'Steps History',
                            style: GoogleFonts.lexendDeca(
                              // fontFamily: 'Lexend Deca',
                              color: Colors.black,
                              fontSize: 22,
                            ),
                          ),
                          // SizedBox(height: 10),
                          Row(children: [
                            RotatedBox(
                                quarterTurns: -1,
                                child: Text(
                                  'Number of Steps',
                                  style: GoogleFonts.lexendDeca(
                                    // fontFamily: 'Lexend Deca',
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                )),
                            LineChart(
                              LineChartData(
                                  minX: 1,
                                  maxX: 12,
                                  minY: 0,
                                  maxY: 1000,
                                  gridData: FlGridData(
                                      show: true,
                                      getDrawingHorizontalLine: (value) {
                                        return FlLine(
                                            color: Colors.black,
                                            strokeWidth: 1);
                                      },
                                      drawVerticalLine: true,
                                      getDrawingVerticalLine: (value) {
                                        return FlLine(
                                            color: Colors.black,
                                            strokeWidth: 1);
                                      }),
                                  lineBarsData: [
                                    LineChartBarData(
                                        spots: [
                                          FlSpot(1, 400),
                                          FlSpot(2, 750),
                                          FlSpot(3, 570),
                                          FlSpot(4, 600),
                                          FlSpot(5, 800),
                                          FlSpot(6, 630),
                                          FlSpot(7, 800),
                                          FlSpot(8, 830),
                                        ],
                                        barWidth: 5,
                                        dotData: FlDotData(show: false),
                                        colors: [Colors.blue],
                                        isCurved: true,
                                        belowBarData: BarAreaData(
                                            show: true,
                                            colors: [
                                              Colors.blue.withOpacity(0.3)
                                            ]))
                                  ]),
                            ),
                          ]),
                          Text(
                            'Days',
                            style: GoogleFonts.lexendDeca(
                              // fontFamily: 'Lexend Deca',
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Calories',
                            style: GoogleFonts.lexendDeca(
                              // fontFamily: 'Lexend Deca',
                              color: Colors.black,
                              fontSize: 22,
                            ),
                          ),
                          // SizedBox(height: 10),
                          Row(children: [
                            RotatedBox(
                                quarterTurns: -1,
                                child: Text(
                                  'Calories',
                                  style: GoogleFonts.lexendDeca(
                                    // fontFamily: 'Lexend Deca',
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                )),
                            LineChart(
                              LineChartData(
                                  minX: 1,
                                  maxX: 12,
                                  minY: 0,
                                  maxY: 1000,
                                  gridData: FlGridData(
                                      show: true,
                                      getDrawingHorizontalLine: (value) {
                                        return FlLine(
                                            color: Colors.black,
                                            strokeWidth: 1);
                                      },
                                      drawVerticalLine: true,
                                      getDrawingVerticalLine: (value) {
                                        return FlLine(
                                            color: Colors.black,
                                            strokeWidth: 1);
                                      }),
                                  lineBarsData: [
                                    LineChartBarData(
                                        spots: [
                                          FlSpot(1, 850),
                                          FlSpot(2, 820),
                                          FlSpot(3, 800),
                                          FlSpot(4, 805),
                                          FlSpot(5, 812),
                                          FlSpot(6, 750),
                                          FlSpot(7, 790),
                                          FlSpot(8, 810),
                                        ],
                                        barWidth: 5,
                                        dotData: FlDotData(show: false),
                                        colors: [Colors.red],
                                        isCurved: true,
                                        belowBarData: BarAreaData(
                                            show: true,
                                            colors: [
                                              Colors.red.withOpacity(0.3)
                                            ]))
                                  ]),
                            ),
                          ]),
                          Text(
                            'Days',
                            style: GoogleFonts.lexendDeca(
                              // fontFamily: 'Lexend Deca',
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Blood-Glucose Level',
                            style: GoogleFonts.lexendDeca(
                              // fontFamily: 'Lexend Deca',
                              color: Colors.black,
                              fontSize: 22,
                            ),
                          ),
                          Row(children: [
                            RotatedBox(
                                quarterTurns: -1,
                                child: Text(
                                  'Number of Steps',
                                  style: GoogleFonts.lexendDeca(
                                    // fontFamily: 'Lexend Deca',
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                )),
                            LineChart(
                              LineChartData(
                                  minX: 1,
                                  maxX: 12,
                                  minY: 0,
                                  maxY: 1000,
                                  gridData: FlGridData(
                                      show: true,
                                      getDrawingHorizontalLine: (value) {
                                        return FlLine(
                                            color: Colors.black,
                                            strokeWidth: 1);
                                      },
                                      drawVerticalLine: true,
                                      getDrawingVerticalLine: (value) {
                                        return FlLine(
                                            color: Colors.black,
                                            strokeWidth: 1);
                                      }),
                                  lineBarsData: [
                                    LineChartBarData(
                                        spots: [
                                          FlSpot(1, 400),
                                          FlSpot(2, 750),
                                          FlSpot(3, 570),
                                          FlSpot(4, 600),
                                          FlSpot(5, 800),
                                          FlSpot(6, 630),
                                          FlSpot(7, 800),
                                          FlSpot(8, 830),
                                        ],
                                        barWidth: 5,
                                        dotData: FlDotData(show: false),
                                        colors: [Colors.green],
                                        isCurved: true,
                                        belowBarData: BarAreaData(
                                            show: true,
                                            colors: [
                                              Colors.green.withOpacity(0.3)
                                            ]))
                                  ]),
                            ),
                          ]),

                          Text(
                            'Days',
                            style: GoogleFonts.lexendDeca(
                              // fontFamily: 'Lexend Deca',
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          // SizedBox(height: 5),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
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
                                                        builder: (context) =>
                                                            Home()));
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
                                                color: Colors.black,
                                              ),
                                              // color: Colors.white,
                                              onPressed: () async {
                                                await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Blood()));
                                              }),
                                          new IconButton(
                                              icon: new Icon(
                                                Icons.history,
                                                color: Colors.white,
                                              ),
                                              // color: Colors.black,
                                              onPressed: () =>
                                                  Navigator.of(context).push)
                                        ]),
                                  )))
                        ],
                      )))),
            )));
  }
}
