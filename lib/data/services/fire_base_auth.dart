import 'package:firebase_auth/firebase_auth.dart';
import 'package:snap_share_orange/data/models/user_info_model.dart';
import 'package:snap_share_orange/data/services/database.dart';

class FireBaseAuth {
  static Future<void> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    String userId = userCredential.user!.uid;

    UserInfoModel userInfo =
        UserInfoModel(id: userId, name: name, email: email);

    await Database.addUserDetails(userInfo, userId);
  }

  static Future<void> signInUserWithEmailAndPassword(
      String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> signOutInEmailAndPassword() async {
    await FirebaseAuth.instance.signOut();
  }
}
