import 'package:flutter/material.dart';

class Routes {
  static Routes instance = Routes();

  Future<dynamic> pushAndRemoveUntil({
    required Widget widget,
    required BuildContext context,
  }) {
    return Navigator.of(context).pushAndRemoveUntil(
      _createSlidePageRoute(widget),
      (route) => false,
    );
  }

  Future<dynamic> push({
    required Widget widget,
    required BuildContext context,
  }) {
    return Navigator.of(context).push(_createSlidePageRoute(widget));
  }

  PageRouteBuilder _createSlidePageRoute(Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
