import 'package:bugtracker/screens/login_screen.dart';
import 'package:bugtracker/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/user.dart';

void main() {
  runApp(const BugTracker());
}

class BugTracker extends StatelessWidget {
  const BugTracker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white)),
      ),
      initialRoute: 'user_screen',
      routes: {
        'welcome_screen': (context) => WelcomeScreen(),
        'login_screen': (context) => LoginScreen(),
        'user_screen': (context) => UserScreen(),
      },
    );
  }
}
