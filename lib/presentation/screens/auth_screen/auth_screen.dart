import 'package:flutter/material.dart';
import 'package:snap_share_orange/presentation/screens/auth_screen/log_in_screen.dart';
import 'package:snap_share_orange/presentation/screens/auth_screen/sign_up_screen.dart';
import 'package:snap_share_orange/presentation/widgets/custom_elevated_button.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "SociaLive",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SignUpScreen()));
            },
            child: const Text(
              "Create Account",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LogInScreen()));
            },
            child: const Text(
              "Log In",
              style: TextStyle(color: Colors.blue),
            ),
          )
        ],
      ),
    );
  }
}
