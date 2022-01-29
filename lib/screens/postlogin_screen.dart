import 'package:bugtracker/screens/bugs_list.dart';
import 'package:bugtracker/screens/user.dart';
import 'package:flutter/material.dart';

class PostLoginScreen extends StatefulWidget {
  const PostLoginScreen({Key? key}) : super(key: key);

  @override
  _PostLoginScreenState createState() => _PostLoginScreenState();
}

class _PostLoginScreenState extends State<PostLoginScreen> {
  int _selectedIndex = 0;
  var option = ['User', 'Bug'];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget choseScreen() {
    if (_selectedIndex == 0)
      return UserScreen();
    else
      return BugList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: choseScreen(),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle_outlined), label: 'User'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bug_report_outlined), label: 'Bug'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
