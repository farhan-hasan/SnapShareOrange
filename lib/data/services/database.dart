import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:snap_share_orange/data/models/user_info_model.dart';
import 'package:snap_share_orange/data/utils.dart';

class Database {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future addUserDetails(UserInfoModel userInfo, String id) async {
    return await _firestore.collection("users").doc(id).set(userInfo.toMap());
  }

  static Future<List<UserInfoModel>> getAllUserDetails() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('users').get();
    return snapshot.docs.map((doc) {
      return UserInfoModel.fromMap(doc.data());
    }).toList();
  }

  static Future<QuerySnapshot<Object?>> getUserDetails() async {
    return await _firestore
        .collection('users')
        .where('id', isEqualTo: Utils.userId)
        .limit(1)
        .get();
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getUserPosts() async {
    return await _firestore
        .collection('users')
        .doc(Utils.userId)
        .collection('posts')
        .orderBy('date', descending: true)
        .get();
  }

  static Future<String?> getProfileImage() async {
    final ref = FirebaseStorage.instance.ref().child(Utils.userId);
    return await ref.getDownloadURL();
  }

  static Future<String> uploadProfileImageToFirebase(File image) async {
    String fileName = Utils.userId;
    final ref = FirebaseStorage.instance.ref().child(fileName);
    await ref.putFile(image);
    return await ref.getDownloadURL();
  }
}
