import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_share_orange/data/services/fire_base_auth.dart';
import 'package:snap_share_orange/presentation/screens/auth_screen/log_in_screen.dart';
import 'package:snap_share_orange/presentation/widgets/scaffold_message.dart';

class SignUpScreenController extends GetxController {
  bool _passwordVisible = false;

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  bool get passwordVisible => _passwordVisible;

  Future<void> createUserSignUpDatabase(
      String email, String password, String name) async {
    try {
      _isLoading = true;
      update();
      await FireBaseAuth.createUserWithEmailAndPassword(email, password, name);
      await FireBaseAuth.signOutInEmailAndPassword();

      ScaffoldMessage.showScafflodMessage(
          'User Sign-Up Success', Colors.blueAccent);

      Get.off(() => const LogInScreen());
    } on FirebaseException catch (e) {
      if (e.code == 'email-already-in-use') {
        ScaffoldMessage.showScafflodMessage(
            'Email is already in use', Colors.redAccent);
      } else if (e.code == 'weak-password') {
        ScaffoldMessage.showScafflodMessage(
            'The password is too weak', Colors.redAccent);
      }
    } catch (e) {
      print("Sign-Up Failed: ${e.toString()}");
    } finally {
      _isLoading = false;
      update();
    }
  }

  void tooglePasswordVisible() {
    _passwordVisible = !_passwordVisible;
    update();
  }

  void onChangedValue() {
    update();
  }
}
