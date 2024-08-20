
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snap_share_orange/app.dart';
import 'package:snap_share_orange/presentation/screens/user_profile_screen.dart';

import '../../data/utils.dart';
import '../widgets/scaffold_message.dart';

class MainBottomNavBarScreen extends StatefulWidget {
  const MainBottomNavBarScreen({super.key});

  @override
  State<MainBottomNavBarScreen> createState() => _MainBottomNavBarScreenState();
}

class _MainBottomNavBarScreenState extends State<MainBottomNavBarScreen> {
  int _selectedIndex = 0;
  bool isLoading = false;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    isLoading = true;
    setState(() {});
    getUserKey();
    isLoading = false;
    setState(() {});
  }

  Future<void> getUserKey() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    if (user == null) {
      ScaffoldMessage.showScafflodMessage(
          context, 'No user is currently logged in.', Colors.blueAccent);
      return;
    }

    Utils.userId = user.uid;
  }

  final List<Widget> _screens = [
    const HomePage(),
    Container(),
    Container(),
    const UserProfileScreen(),
  ];


  void _onItemTapped(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return
      isLoading ? const Center(child: CircularProgressIndicator(),) :
      Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.black,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                size: 20,
                color: Colors.black,
              ),
              label: 'Add'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle_rounded,
                color: Colors.black,
              ),
              label: 'user'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        showUnselectedLabels: false,
      ),
    );
  }


}
