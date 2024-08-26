import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snap_share_orange/data/models/user_info_model.dart';
import 'package:snap_share_orange/data/models/user_posts_model.dart';
import 'package:snap_share_orange/data/services/database.dart';
import 'package:snap_share_orange/presentation/widgets/scaffold_message.dart';

class UserProfileScreenController extends GetxController {
  late List<UserInfoModel> userDetails;
  late List<UserPostsModel> userPosts;

  UserInfoModel currentUserDetail = UserInfoModel(
      id: "id", name: "name", email: "email", followers: 0, following: 0);

  String? imageUrl;
  bool isLoading = false;
  File? _image;
  bool isProfilePictureLoading = false;
  final ImagePicker _picker = ImagePicker();
  String? profileImageUrl, tempImageUrl;

  Future<void> fetchProfileData() async {
    isLoading = true;
    update();
    await getUserProfileDetails();
    await getUserProfilePosts();
    await getProfileImageUrl();
    isLoading = false;
    update();
  }

  Future<void> getUserProfileDetails() async {
    QuerySnapshot querySnapshot = await Database.getUserDetails();
    if (querySnapshot.docs.isEmpty) {
      ScaffoldMessage.showScafflodMessage(
          'No document found for the logged-in user.', Colors.blueAccent);

      return;
    }
  }

  Future<void> getUserProfilePosts() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await Database.getUserPosts();

    userPosts = snapshot.docs.map((doc) {
      return UserPostsModel.fromMap(doc.data());
    }).toList();

    for (UserPostsModel model in userPosts) {
      log(model.caption);
      log(model.location);
      log(model.date.toString());
      log(model.likes.toString());
    }
  }

  Future<void> getProfileImageUrl() async {
    try {
      final url = await Database.getProfileImage();
      profileImageUrl = url;
      update();
    } catch (e) {
      ScaffoldMessage.showScafflodMessage(
          'Failed to load profile image: $e', Colors.blueAccent);
    }
  }

  Future<void> uploadUserProfileImage() async {
    try {
      if (_image != null) {
        String url = await Database.uploadProfileImageToFirebase(_image!);

        profileImageUrl = url;
        update();

        ScaffoldMessage.showScafflodMessage(
            'profile image updated successfully', Colors.blueAccent);
      }
    } catch (e) {
      ScaffoldMessage.showScafflodMessage(
          'Error uploading image: $e', Colors.blueAccent);

      profileImageUrl = tempImageUrl;
      update();
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        tempImageUrl = profileImageUrl;
        profileImageUrl = null;
        update();

        await uploadUserProfileImage();
      }
    } catch (e) {
      ScaffoldMessage.showScafflodMessage(
          'Error picking image: $e', Colors.blueAccent);

      profileImageUrl = tempImageUrl;
      update();
    }
  }
}
