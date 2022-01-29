import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:bugtracker/components/Button.dart';
import 'package:bugtracker/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  bool showSpinner = false;
  late String password;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  style: TextStyle(color: Colors.white),
                  decoration:
                      kDecoration.copyWith(hintText: 'Enter your email')),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  onChanged: (value) {
                    password = value;
                  },
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                  decoration:
                      kDecoration.copyWith(hintText: 'Enter your password')),
              SizedBox(
                height: 24.0,
              ),
              Button(
                title: 'Log In',
                color: Colors.grey.withOpacity(0.5),
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  // try {
                  //   final user = await _auth.signInWithEmailAndPassword(
                  //       email: email, password: password);
                  //   if (user != null) {
                  //     Navigator.pushNamed(context, 'chat_screen');
                  //   }
                  //   setState(() {
                  //     showSpinner = false;
                  //   });
                  //   email = "";
                  //   password = "";
                  // } catch (e) {
                  //   print(e);
                  // }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
