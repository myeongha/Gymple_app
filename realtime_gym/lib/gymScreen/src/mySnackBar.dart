import 'package:flutter/material.dart';

class MySnackBar extends SnackBar {
  final String message;
  final Duration duration;
  static bool isSnackBarVisible = false;

  MySnackBar({
    Key? key,
    required this.message,
    required this.duration,
  }) : super(
    key: key,
    content: Padding(
      padding: EdgeInsets.only(left: 12),
      child: Text(
        message,
        style: TextStyle(
          fontSize: 13,
          color: Colors.white,
        ),
      ),
    ),
    backgroundColor: Colors.green.shade200,
    duration: duration,
    action: SnackBarAction(
      label: "확인",
      textColor: Colors.white,
      onPressed: () {
        // Perform undo action
      },
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  );

  static void showMySnackBar(BuildContext context, String message) {
    if (MySnackBar.isSnackBarVisible == false) {
      MySnackBar.isSnackBarVisible = true;
      ScaffoldMessenger.of(context).showSnackBar(
          MySnackBar(
              message: message,
              duration: Duration(seconds: 2)
          )
      );
      Future.delayed(Duration(seconds: 2), () {
        MySnackBar.isSnackBarVisible = false;
      });
    }
  }
}

class MySnackBar2 extends SnackBar {
  final String message;
  final Duration duration;
  static bool isSnackBarVisible = false;

  MySnackBar2({
    Key? key,
    required this.message,
    required this.duration,
  }) : super(
    key: key,
    content: Padding(
      padding: EdgeInsets.only(left: 12),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 13,
          color: Colors.white,
        ),
      ),
    ),
    backgroundColor: Colors.green.shade200,
    duration: duration,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  );

  static void showMySnackBar(BuildContext context, String message) {
    if (MySnackBar2.isSnackBarVisible == false) {
      MySnackBar2.isSnackBarVisible = true;
      ScaffoldMessenger.of(context).showSnackBar(
          MySnackBar2(
              message: message,
              duration: Duration(seconds: 2)
          )
      );
      Future.delayed(Duration(seconds: 2), () {
        MySnackBar2.isSnackBarVisible = false;
      });
    }
  }
}
