import 'package:flutter/material.dart';

class ScaffoldMessage {
  static void showScafflodMessage(context, String msg, Color backGroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backGroundColor,
        content: Text(
          msg,
          style: const TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
    );
  }
}
