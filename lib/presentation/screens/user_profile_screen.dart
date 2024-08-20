import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DefaultTabController(
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
                Column(
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
                    Container(
                      height: 630,
                      child: TabBarView(
                        children: [
                          buildGridView(textTheme),
                          ListView.builder(
                            itemCount: 20,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                height: 100,
                                child: Card(
                                  color: Colors.white,
                                  child: Center(
                                    child: Text("Post $index", style: textTheme.titleLarge,),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GridView buildGridView(TextTheme textTheme) {
    return GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of columns
                            crossAxisSpacing: 10.0, // Space between columns
                            mainAxisSpacing: 10.0, // Space between rows
                            childAspectRatio: 1.0, // Aspect ratio of the grid items
                          ),
                          itemCount: 20, // Number of items in the grid
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.white,
                              child: Center(
                                child: Text(
                                  'Post $index',
                                  style: textTheme.titleLarge,
                                ),
                              ),
                            );
                          },
                          padding: const EdgeInsets.all(10.0), // Padding around the grid
                        );
  }

  Wrap buildProfileSection(TextTheme textTheme) {
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
                        "Ferdous Mondol",
                        style: textTheme.titleLarge,
                      ),
                      Text(
                        "@mferdous12",
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
                                    text: '59',
                                    style: textTheme.bodySmall?.copyWith(
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: ' Post',
                                    style: textTheme.bodySmall),
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
                                    text: '125',
                                    style: textTheme.bodySmall?.copyWith(
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: ' Following',
                                    style: textTheme.bodySmall),
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
                                    text: '850',
                                    style: textTheme.bodySmall?.copyWith(
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: ' Follower',
                                    style: textTheme.bodySmall),
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
