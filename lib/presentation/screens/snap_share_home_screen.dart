import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_share_orange/data/services/fire_base_auth.dart';
import 'package:snap_share_orange/presentation/screens/auth_screen/auth_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SnapShare"),
        actions: [
          IconButton(
            onPressed: () async {
              await FireBaseAuth.signOutInEmailAndPassword();

              Get.offAll(() => const AuthScreen());
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: const Center(
        child: Text("Home"),
      ),
    );
  }
}
