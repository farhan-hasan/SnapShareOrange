import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snap_share_orange/presentation/state_holders/user_profile_screen_controller.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final UserProfileScreenController _userProfileScreenController =
      Get.find<UserProfileScreenController>();

  @override
  void initState() {
    super.initState();
    _userProfileScreenController.fetchProfileData();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GetBuilder<UserProfileScreenController>(
      builder: (userProfileScreenController) {
        return userProfileScreenController.isLoading
            ? const Center(
                child: Text('No data found'),
              )
            : DefaultTabController(
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
                          buildProfileSection(
                              textTheme,
                              userProfileScreenController.profileImageUrl,
                              userProfileScreenController),
                          const SizedBox(
                            height: 8,
                          ),
                          buildPostsSection(
                              textTheme, userProfileScreenController),
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }

  Widget buildPostsSection(TextTheme textTheme, userProfileScreenController) {
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
              buildGridView(textTheme, userProfileScreenController),
              buildListView(textTheme, userProfileScreenController),
            ],
          ),
        )
      ],
    );
  }

  Widget buildListView(TextTheme textTheme,
      UserProfileScreenController userProfileScreenController) {
    return ListView.builder(
      itemCount: userProfileScreenController.userPosts.length,
      itemBuilder: (context, index) {
        return SizedBox(
          height: 100,
          child: Card(
            color: Colors.white,
            child: Center(
              child: Text(
                userProfileScreenController.userPosts[index].caption,
                style: textTheme.titleLarge,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildGridView(TextTheme textTheme,
      UserProfileScreenController userProfileScreenController) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 10.0, // Space between columns
        mainAxisSpacing: 10.0, // Space between rows
        childAspectRatio: 1.0, // Aspect ratio of the grid items
      ),
      itemCount: userProfileScreenController
          .userPosts.length, // Number of items in the grid
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          child: Center(
            child: Text(
              userProfileScreenController.userPosts[index].caption,
              style: textTheme.titleLarge,
            ),
          ),
        );
      },
      padding: const EdgeInsets.all(10.0), // Padding around the grid
    );
  }

  Widget buildProfileSection(TextTheme textTheme, String? profileImageUrl,
      UserProfileScreenController userProfileScreenController) {
    return Wrap(
      children: [
        GestureDetector(
          onTap: () async {
            await userProfileScreenController.pickImage(ImageSource.gallery);
          },
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: profileImageUrl == null
                ? const CircularProgressIndicator()
                : CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(profileImageUrl),
                  ),
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
              userProfileScreenController.currentUserDetail.name,
              style: textTheme.titleLarge,
            ),
            Text(
              userProfileScreenController.currentUserDetail.email,
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
                          text: userProfileScreenController.userPosts.length
                              .toString(),
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
                          text: userProfileScreenController
                              .currentUserDetail.following
                              .toString(),
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
                          text: userProfileScreenController
                              .currentUserDetail.followers
                              .toString(),
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
