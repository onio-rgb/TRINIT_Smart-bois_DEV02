import 'dart:developer';

import 'package:bugtracker/components/Button.dart';
import 'package:bugtracker/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bugtracker/components/db_api.dart';
import 'package:google_fonts/google_fonts.dart';

class BugElement extends StatefulWidget {
  String bugname;
  String description;
  String raisedBy;
  bool resolved;
  int currentUser;
  BugElement(
      {required this.bugname,
      required this.description,
      required this.raisedBy,
      required this.resolved,
      required this.currentUser});

  @override
  _BugElementState createState() => _BugElementState();
}

class _BugElementState extends State<BugElement> {
  final _auth = FirebaseAuth.instance;
  var api_handler = new api();
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ExpansionTile(
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              widget.bugname,
              style: TextStyle(color: Colors.white),
            ),
            Container(
              decoration: BoxDecoration(
                  color: (widget.resolved) ? (Colors.green) : (Colors.red),
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              width: 110,
              height: 25,
              child: (widget.resolved)
                  ? (Text(
                      'Resolved',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ))
                  : (Text(
                      'Not Resolved',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    )),
            )
          ]),
          children: [
            FutureBuilder(
              future: api_handler.getUserDetails(widget.raisedBy),
              builder: (context, AsyncSnapshot snapshot) {
                return Text(
                  "Raised by : ${snapshot.data['email']}",
                  style: GoogleFonts.oxygen(
                      fontSize: 15, color: Colors.white, letterSpacing: 3),
                );
              },
            ),
            Text(
              widget.description,
              style: GoogleFonts.oxygen(
                  fontSize: 15, color: Colors.white, letterSpacing: 3),
            ),
            (widget.currentUser != '0' && !widget.resolved)
                ? ((widget.currentUser == '4')
                    ? Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            border: Border.all(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: FlatButton(
                            color: Colors.transparent,
                            child: Text('Assign to'),
                            onPressed: () {}),
                      )
                    : Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            border: Border.all(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: FlatButton(
                            color: Colors.transparent,
                            child: Text('Mark Resolved'),
                            onPressed: () {}),
                      ))
                : Container(),
          ],
        ),
      ),
    );
  }
}
