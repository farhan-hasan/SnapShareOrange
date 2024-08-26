import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_share_orange/data/services/fire_base_auth.dart';
import 'package:snap_share_orange/presentation/widgets/scaffold_message.dart';

class ForgotPasswordScreenController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> resetPassword(
      String email, TextEditingController emailTEController) async {
    try {
      _isLoading = true;
      update();
      await FireBaseAuth.sendPasswordResetEmail(email);

      ScaffoldMessage.showScafflodMessage(
          "Password Reset Email has sent", Colors.blueAccent);

      emailTEController.clear();
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessage.showScafflodMessage(
            "Password Reset Email has sent", Colors.redAccent);
      }
    } finally {
      _isLoading = false;
      update();
    }
  }
}
