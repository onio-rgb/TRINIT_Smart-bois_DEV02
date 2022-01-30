import 'package:bugtracker/screens/bugs_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:bugtracker/constant.dart';
import 'package:bugtracker/components/db_api.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool showSpinner = false;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late String pos;

  var api_handler = new api();
  @override
  Future<void> getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        //print("Verma ${logginUser.uid}");
        LogginUser = await api_handler.getUserDetails(user.uid);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getCurrentUserDetails() async {
    QuerySnapshot<Map<String, dynamic>> user = await _firestore
        .collection('user')
        .where('email', isEqualTo: LogginUser['email'])
        .get();
    return user;
  }

  String decode(int authlvl) {
    if (authlvl == 4)
      return "Project Manager";
    else if (authlvl != 0)
      return ("Software Developer Engineer ${authlvl}");
    else
      return "Software User";
  }

  Widget build(BuildContext context) {
    // print("Astitva ${logginUser.email}");
    return FutureBuilder(
        future: getCurrentUser(),
        builder: (context, snapshot) {
          // print("Astitva ${logginUser.email}");
          return Scaffold(
              // backgroundColor: Colors.black,
              body: Center(
            child: ListView(
              children: [
                blocks(
                  radius: 25,
                  height: 600,
                  width: double.infinity,
                  child: Center(
                    child: ModalProgressHUD(
                        inAsyncCall: showSpinner,
                        child: FutureBuilder(
                          future: _firestore
                              .collection('users')
                              .where("email", isEqualTo: LogginUser['email'])
                              .get(),
                          builder: (context, snapshot1) {
                            if (snapshot1.connectionState ==
                                    ConnectionState.done &&
                                snapshot1.hasData) {
                              //print("Astitva ${logginUser.email}");
                              var res = snapshot1.data
                                  as QuerySnapshot<Map<String, dynamic>>;
                              List<QueryDocumentSnapshot<Map<String, dynamic>>>
                                  data = res.docs;
                              pos = decode(data[0].data()['authlvl']);
                              // print("Astitva ${data.length}");
                              showSpinner = false;
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage('images/avatar2.png'),
                                  ),
                                  heading(text: "Email"),
                                  Info(text: data[0].data()['email']),
                                  heading(text: "Job Position"),
                                  Info(text: pos),
                                  heading(text: "Bugs Resolved"),
                                  Info(
                                      text:
                                          "${data[0].data()['bugsresolved']}"),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          },
                        )),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    blocks(
                      height: 130,
                      width: 175,
                      child: Container(),
                      radius: 15,
                    ),
                    blocks(
                      height: 130,
                      width: 175,
                      child: Container(),
                      radius: 15,
                    ),
                  ],
                )
              ],
            ),
          ));
        });
  }
}

class blocks extends StatelessWidget {
  double height;
  double width;
  Widget child;
  double radius;
  blocks(
      {required this.height,
      required this.width,
      required this.child,
      required this.radius});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 25),
      child: Container(
        height: height,
        width: width,
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius))),
          // color: Colors.grey,
          child: child,
        ),
      ),
    );
  }
}

class heading extends StatelessWidget {
  String text;
  heading({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Text(
        text,
        style: GoogleFonts.oxygen(
            fontSize: 15, color: Colors.white38, letterSpacing: 3),
      ),
    );
  }
}

class Info extends StatelessWidget {
  String text;
  Info({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Text(
        text,
        style: GoogleFonts.oxygen(fontSize: 17, letterSpacing: 3),
      ),
    );
  }
}
