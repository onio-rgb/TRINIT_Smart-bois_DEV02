import 'package:bugtracker/screens/bugs_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool showSpinner = false;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User logginUser;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        logginUser = user;
        
      }
    } catch (e) {
      print(e);
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getCurrentUserDetails() async {
    QuerySnapshot<Map<String, dynamic>> user = await _firestore
        .collection('user')
        .where('email', isEqualTo: logginUser.email)
        .get();
    return user;
  }

  Widget build(BuildContext context) {
    print("Astitva ${logginUser.email}");
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          blocks(
            height: 300,
            width: double.infinity,
            child: Center(
              child: ModalProgressHUD(
                  inAsyncCall: showSpinner,
                  child: FutureBuilder(
                    future: _firestore
                        .collection('user')
                        .where('email', isEqualTo: logginUser.email)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        QuerySnapshot<Map<String, dynamic>> res = snapshot.data
                            as QuerySnapshot<Map<String, dynamic>>;
                        List<QueryDocumentSnapshot<Map<String, dynamic>>> data =
                            res.docs;
                        showSpinner = false;
                        return Column(
                          children: [
                            Text("Email : "),
                            Text(data[0].data()['email']),
                            Text("Job Position : "),
                            Text(data[0].data()['authlvl']),
                            Text("Bugs Resolved : "),
                            Text(data[0].data()['bugsresolved']),
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
              blocks(height: 130, width: 130, child: Container()),
              SizedBox(
                width: 30,
              ),
              blocks(height: 130, width: 130, child: Container()),
            ],
          )
        ],
      ),
    ));
  }
}

class blocks extends StatelessWidget {
  double height;
  double width;
  Widget child;
  blocks({required this.height, required this.width, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 40),
      child: Container(
        height: height,
        width: width,
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(30),
          color: Colors.black,
          shadowColor: Colors.white30,
          child: child,
        ),
      ),
    );
  }
}
