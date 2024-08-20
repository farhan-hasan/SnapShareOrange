import 'package:flutter/material.dart';
import 'package:snap_share_orange/data/services/fire_base_auth.dart';
import 'package:snap_share_orange/presentation/screens/auth_screen/auth_screen.dart';
import 'package:snap_share_orange/presentation/screens/auth_screen/log_in_screen.dart';
import 'package:snap_share_orange/presentation/screens/auth_screen/sign_up_screen.dart';
import 'package:snap_share_orange/presentation/screens/main_bottom_nav_bar_screen.dart';
import 'package:snap_share_orange/presentation/screens/user_profile_screen.dart';

class SnapShare extends StatelessWidget {
  SnapShare({super.key});

  final TextTheme lightTextTheme = const TextTheme(
    titleLarge: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
        color: Color(0xff101828),
        fontFamily: "Satoshi"),
    titleSmall: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        color: Color(0xff101828),
        fontFamily: "Satoshi"),
    bodyLarge: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w400,
        color: Color(0xff101828),
        fontFamily: "Satoshi"),
    bodySmall: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: Color(0xff101828),
        fontFamily: "Satoshi"),
  );

  final TextTheme darkTextTheme = const TextTheme(
    titleLarge: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        fontFamily: "Satoshi"),
    titleSmall: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        fontFamily: "Satoshi"),
    bodyLarge: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w400,
        color: Colors.white,
        fontFamily: "Satoshi"),
    bodySmall: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: Colors.white,
        fontFamily: "Satoshi"),
  );

  final InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    hintStyle: const TextStyle(
        color: Color(0xff98A2B3), fontSize: 14, fontWeight: FontWeight.w400),
    labelStyle: const TextStyle(
        color: Color(0xff98A2B3), fontSize: 14, fontWeight: FontWeight.w400),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: Color(0xff6993FF)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: Color(0xff6993FF)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: Color(0xff6993FF)),
    ),
  );
  final InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xff101828),
    hintStyle: const TextStyle(
        color: Color(0xff98A2B3), fontSize: 14, fontWeight: FontWeight.w400),
    labelStyle: const TextStyle(
        color: Color(0xff98A2B3), fontSize: 14, fontWeight: FontWeight.w400),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: Color(0xff6993FF)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: Color(0xff6993FF)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: Color(0xff6993FF)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.white,
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(
                fontFamily: "Satoshi",
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Color(0xff101828))),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xff4478FF),
                textStyle: const TextStyle(
                  fontFamily: "Satoshi",
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ))),
        textTheme: lightTextTheme,
        iconTheme: const IconThemeData(color: Color(0xFF101828), size: 24),
        inputDecorationTheme: lightInputDecorationTheme,
        //  useMaterial3: true,
      ),
      home: const LogInScreen(),
    );
  }
}

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
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthScreen()),
                  (context) => false);
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
