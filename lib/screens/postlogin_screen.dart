import 'package:bugtracker/screens/bugs_list.dart';
import 'package:bugtracker/screens/chat_screen.dart';
import 'package:bugtracker/screens/user.dart';
import 'package:flutter/material.dart';

class PostLoginScreen extends StatefulWidget {
  const PostLoginScreen({Key? key}) : super(key: key);

  @override
  _PostLoginScreenState createState() => _PostLoginScreenState();
}

class _PostLoginScreenState extends State<PostLoginScreen> {
  int _selectedIndex = 0;
  var option = ['User', 'Bug', 'Chat'];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget choseScreen() {
    if (_selectedIndex == 0)
      return UserScreen();
    else if (_selectedIndex == 1)
      return BugList();
    else
      return ChatScreen();
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
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: 'Chat'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
