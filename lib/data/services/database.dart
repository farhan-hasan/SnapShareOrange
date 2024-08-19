import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:snap_share_orange/data/models/user_info_model.dart';

class Database {
  static Future addUserDetails(UserInfoModel userInfo, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfo.toMap());
  }

  static Future<List<UserInfoModel>> getAllUserDetails() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').get();
    return snapshot.docs.map((doc) {
      return UserInfoModel.fromMap(doc.data());
    }).toList();
  }
}
