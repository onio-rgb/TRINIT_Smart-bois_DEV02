import 'package:flutter/material.dart';
import '../components/Button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button(
              title: 'Log In',
              color: Colors.grey.withOpacity(0.5),
              onPressed: () {
                Navigator.pushNamed(context, 'login_screen');
              },
            ),
            SizedBox(
              height: 48.0,
            ),
            Button(
              title: 'Register',
              color: Colors.grey.withOpacity(0.5),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
