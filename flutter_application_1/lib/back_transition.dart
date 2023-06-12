import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  CustomPageRoute({
    required this.child,
  }) : super(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      ScaleTransition(
        scale: animation,
        child: child,
      );
}

//left to right transition
class CustomPageRoute1 extends PageRouteBuilder {
  final Widget child;
  CustomPageRoute1({
    required this.child,
  }) : super(
            pageBuilder: (context, animation, secondaryAnimation) => child,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(-1,
                  0); //screen positioned at 100% to left, and 0% moved to vertically
              const end = Offset
                  .zero; // screen should be brought to offset.zero that is (0,0) coordinates
              const curve = Curves.ease;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            });
}

//right to left transition
class CustomPageRoute2 extends PageRouteBuilder {
  final Widget child;
  CustomPageRoute2({
    required this.child,
  }) : super(
            pageBuilder: (context, animation, secondaryAnimation) => child,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1,
                  0); //screen positioned at 100% to right, and 0% moved to vertically
              const end = Offset
                  .zero; // screen should be brought to offset.zero that is (0,0) coordinates
              const curve = Curves.ease;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            });
}
