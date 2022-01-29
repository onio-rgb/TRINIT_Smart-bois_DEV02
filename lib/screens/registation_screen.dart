import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:bugtracker/components/Button.dart';
import 'package:bugtracker/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late int authlvl;
  late String email;
  late String pos;
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
              TextField(
                  onChanged: (value) {
                    pos = value;
                  },
                  style: TextStyle(color: Colors.white),
                  decoration:
                      kDecoration.copyWith(hintText: 'Enter your post')),
              Button(
                title: 'Register',
                color: Colors.grey.withOpacity(0.5),
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final user = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (pos == 'manager')
                      authlvl = 4;
                    else if (pos == 'SDE3')
                      authlvl = 3;
                    else if (pos == 'SDE2')
                      authlvl = 2;
                    else if (pos == 'SDE1')
                      authlvl = 1;
                    else
                      authlvl = 0;
                    if (user != null) {
                      if (email.length > 12 &&
                          email.substring(email.length - 12) ==
                              '@company.com') {
                        _firestore.collection('users').add({
                          'email': email,
                          'password': password,
                          'authlvl': authlvl
                        });
                      }
                      Navigator.pushNamed(context, 'postlogin_screen');
                    }
                    setState(() {
                      showSpinner = false;
                    });
                    email = "";
                    password = "";
                  } catch (e) {
                    print(e);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
