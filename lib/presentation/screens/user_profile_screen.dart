import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snap_share_orange/data/models/user_posts_model.dart';
import 'package:snap_share_orange/data/services/database.dart';
import 'package:snap_share_orange/presentation/widgets/scaffold_message.dart';

import '../../data/models/user_info_model.dart';
import '../../data/utils.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late List<UserInfoModel> userDetails;
  late List<UserPostsModel> userPosts;
  UserInfoModel currentUserDetail = UserInfoModel(id: "id", name: "name", email: "email", followers: 0, following: 0);
  bool isLoading = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    fetchProfileData();
    super.initState();
  }

  Future<void> fetchProfileData() async {
    isLoading = true;
    setState(() {});
    await getUserDetails();
    await getUserPosts();
    isLoading = false;
    setState(() {});
  }

  Future<void> getUserDetails() async {

    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .where('id', isEqualTo: Utils.userId)
        .limit(1)
        .get();
    if (querySnapshot.docs.isEmpty) {
      if(mounted) {
        ScaffoldMessage.showScafflodMessage(
            context, 'No document found for the logged-in user.',
            Colors.blueAccent);
      }
      return;
    }

    userDetails = await Database.getAllUserDetails();
    for(UserInfoModel detail in userDetails) {
      if(detail.id == Utils.userId) {
        currentUserDetail = detail;
        return;
      }
    }
  }

  Future<void> getUserPosts() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('users') // Parent collection
        .doc(Utils.userId) // Document ID
        .collection('posts') // Subcollection
        .orderBy('date', descending: true) // Optional: order by timestamp
        .get();
    userPosts = snapshot.docs.map((doc) {
      return UserPostsModel.fromMap(doc.data());
    }).toList();

    for(UserPostsModel model in userPosts) {
      log(model.caption);
      log(model.location);
      log(model.date.toString());
      log(model.likes.toString());
    }

  }

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;
    return
      isLoading ? const Center(child: CircularProgressIndicator(),) :
      DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Profile"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                buildProfileSection(textTheme),
                buildPostsSection(textTheme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPostsSection(TextTheme textTheme) {
    return Column(
                children: [
                  TabBar(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    labelStyle: textTheme.titleSmall,
                    tabs: <Widget>[
                      Tab(
                        child: Wrap(children: [
                          const Icon(Icons.grid_view),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Grid view",
                            style: textTheme.titleSmall,
                          ),
                        ]),
                      ),
                      Tab(
                        child: Wrap(children: [
                          const Icon(Icons.list_alt_outlined),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            "List view",
                            style: textTheme.titleSmall,
                          ),
                        ]),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 630,
                    child: TabBarView(
                      children: [
                        buildGridView(textTheme),
                        buildListView(textTheme),
                      ],
                    ),
                  )
                ],
              );
  }

  Widget buildListView(TextTheme textTheme) {
    return ListView.builder(
                          itemCount: userPosts.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 100,
                              child: Card(
                                color: Colors.white,
                                child: Center(
                                  child: Text(
                                    userPosts[index].caption,
                                    style: textTheme.titleLarge,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
  }

  Widget buildGridView(TextTheme textTheme) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 10.0, // Space between columns
        mainAxisSpacing: 10.0, // Space between rows
        childAspectRatio: 1.0, // Aspect ratio of the grid items
      ),
      itemCount: userPosts.length, // Number of items in the grid
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          child: Center(
            child: Text(
              userPosts[index].caption,
              style: textTheme.titleLarge,
            ),
          ),
        );
      },
      padding: const EdgeInsets.all(10.0), // Padding around the grid
    );
  }

  Widget buildProfileSection(TextTheme textTheme) {
    return Wrap(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.person,
            size: 60,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currentUserDetail.name,
              style: textTheme.titleLarge,
            ),
            Text(
              currentUserDetail.email,
              style: textTheme.bodySmall,
            ),
            const SizedBox(
              height: 8,
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: userPosts.length.toString(),
                          style: textTheme.bodySmall
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      TextSpan(text: ' Post', style: textTheme.bodySmall),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                const Icon(
                  Icons.circle,
                  size: 6,
                ),
                const SizedBox(
                  width: 8,
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: currentUserDetail.following.toString(),
                          style: textTheme.bodySmall
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      TextSpan(text: ' Following', style: textTheme.bodySmall),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                const Icon(
                  Icons.circle,
                  size: 6,
                ),
                const SizedBox(
                  width: 8,
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: currentUserDetail.followers.toString(),
                          style: textTheme.bodySmall
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      TextSpan(text: ' Follower', style: textTheme.bodySmall),
                    ],
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}