import 'package:bugtracker/screens/bugs_list.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          blocks(
            height: 300,
            width: double.infinity,
            child: Container(),
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
