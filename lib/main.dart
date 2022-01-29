import 'package:bugtracker/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';

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
      initialRoute: 'welcome_screen',
      routes: {
        'welcome_screen': (context) => WelcomeScreen(),
      },
    );
  }
}
