import 'package:bugtracker/screens/login_screen.dart';
import 'package:bugtracker/screens/registation_screen.dart';
import 'package:bugtracker/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/user.dart';
import 'screens/postlogin_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/report_bug.dart';

void main() {
  runApp(const BugTracker());
}

class BugTracker extends StatelessWidget {
  const BugTracker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          textTheme: TextTheme(
              bodyText1: TextStyle(color: Colors.white),
              bodyText2: TextStyle(color: Colors.white)),
          cardColor: Color(0xFF393A4E),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              foregroundColor: Colors.white,
              backgroundColor: Color(0xFF292838)),
          primaryColor: Color(0xFF292838),
          backgroundColor: Colors.black,
          scaffoldBackgroundColor: Color(0xFF171922),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.black, selectedItemColor: Colors.white)),
      initialRoute: 'welcome_screen',
      routes: {
        'welcome_screen': (context) => WelcomeScreen(),
        'login_screen': (context) => LoginScreen(),
        'user_screen': (context) => UserScreen(),
        'postlogin_screen': (context) => PostLoginScreen(),
        'registration_screen': (context) => RegistrationScreen(),
        'report_bug': (context) => ReportBug()
      },
    );
  }
}
