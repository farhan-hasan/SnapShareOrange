import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:snap_share_orange/app.dart';
import 'package:snap_share_orange/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(SnapShare());
}
