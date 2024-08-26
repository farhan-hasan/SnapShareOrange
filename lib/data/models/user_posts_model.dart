import 'package:cloud_firestore/cloud_firestore.dart';

class UserPostsModel {
  final Timestamp date;
  final int likes;
  final String location;
  final String music;
  final String caption;
  final String image;

  UserPostsModel({required this.image, required this.caption, required this.date,required  this.likes,required  this.location,required  this.music});
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'likes': likes,
      'location': location,
      'music': music,
      'caption': caption,
      'image': image,
    };
  }

  factory UserPostsModel.fromMap(Map<String, dynamic> userPostsDetails) {
    return UserPostsModel(
      music: userPostsDetails['music'],
      location: userPostsDetails['location'],
      likes: userPostsDetails['likes'],
      date: userPostsDetails['date'],
      caption: userPostsDetails['caption'],
      image: userPostsDetails['image'],
    );
  }
}
