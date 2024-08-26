import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_share_orange/data/services/fire_base_auth.dart';
import 'package:snap_share_orange/presentation/screens/main_bottom_nav_bar_screen.dart';
import 'package:snap_share_orange/presentation/widgets/scaffold_message.dart';

class LogInScreenController extends GetxController {
  bool _inProgress = false;
  bool _passwordVisible = false;
  bool _isChecked = false;

  bool get inProgress => _inProgress;
  bool get passwordVisible => _passwordVisible;
  bool get isChecked => _isChecked;

  Future<void> userLogin(String email, String password) async {
    try {
      _inProgress = true;
      update();

      await FireBaseAuth.signInUserWithEmailAndPassword(email, password);

      ScaffoldMessage.showScafflodMessage('Login Success', Colors.blueAccent);
      Get.offAll(() => const MainBottomNavBarScreen());
    } on FirebaseException catch (e) {
      String errorMessage;

      if (e.code == 'user-not-found') {
        errorMessage = 'No User Found for that Email';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong Password Provided by User';
      } else {
        errorMessage = 'Login Failed: ${e.message}';
      }

      ScaffoldMessage.showScafflodMessage(errorMessage, Colors.redAccent);
    } catch (e) {
      print("Login Failed: ${e.toString()}");
      ScaffoldMessage.showScafflodMessage('Login Failed', Colors.redAccent);
    } finally {
      _inProgress = false;
      update();
    }
  }

  void togglePasswordVisible() {
    _passwordVisible = !_passwordVisible;
    update();
  }

  void changeCheck(bool? value) {
    _isChecked = value!;

    update();
  }

  void onChangedValue() {
    update();
  }
}
