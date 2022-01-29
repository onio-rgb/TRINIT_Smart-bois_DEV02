import 'package:flutter/material.dart';
import '../components/Button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  // late AnimationController controller;
  // late Animation animation;
  @override
  // void initState() {
  //   super.initState();
  //   controller = AnimationController(
  //     duration: Duration(seconds: 3),
  //     vsync: this,
  //   );
  //   animation =
  //       ColorTween(begin: Colors.red, end: Colors.blue).animate(controller);
  //   controller.forward();
  //   animation.addStatusListener((status) {
  //     if (status == AnimationStatus.completed)
  //       controller.reverse(from: 1);
  //     else if (status == AnimationStatus.dismissed) controller.forward();
  //   });
  //   controller.addListener(() {
  //     setState(() {});
  //   });
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'logo',
              child: Container(
                child: Image.asset(
                  'images/logo.png',
                  color: Colors.blue,
                  width: 300,
                  height: 400,
                ),
              ),
            ),
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
              onPressed: () {
                
                Navigator.pushNamed(context, 'registration_screen');
              },
            ),
          ],
        ),
      ),
    );
  }
}
