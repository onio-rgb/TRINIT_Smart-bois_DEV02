import 'dart:developer';

import 'package:bugtracker/components/Button.dart';
import 'package:bugtracker/constant.dart';
import 'package:bugtracker/main.dart';
import 'package:bugtracker/screens/team_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bugtracker/components/db_api.dart';
import 'package:google_fonts/google_fonts.dart';

class BugElement extends StatefulWidget {
  String docid;
  String bugname;
  String description;
  String raisedBy;
  bool resolved;
  int currentUser;
  int plvl;
  String assignedto;
  BugElement(
      {required this.bugname,
      required this.description,
      required this.raisedBy,
      required this.resolved,
      required this.currentUser,
      required this.docid,
      required this.plvl,
      required this.assignedto});

  @override
  _BugElementState createState() => _BugElementState();
}

class _BugElementState extends State<BugElement> {
  late Color thrtcolor;
  var res = [];
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  var api_handler = new api();
  MaterialColor threatlvl(int plvl) {
    if (plvl == 4)
      return Colors.red;
    else if (plvl == 3)
      return Colors.orange;
    else if (plvl == 2)
      return Colors.green;
    else
      return Colors.blue;
  }

  void assign() {
    thrtcolor = threatlvl(widget.plvl);
  }

  @override
  Widget build(BuildContext context) {
    assign();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: thrtcolor,
        ),
        child: ExpansionTile(
          backgroundColor: thrtcolor,
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
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Text(
                    "Raised by : ${snapshot.data['email']}",
                    style: GoogleFonts.oxygen(
                        fontSize: 15, color: Colors.white, letterSpacing: 3),
                  );
                } else
                  return Container();
              },
            ),
            (widget.assignedto != "")
                ? FutureBuilder(
                    future: api_handler.getUserDetails(widget.assignedto),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData &&
                          snapshot.data != null) {
                        return Text(
                          "Assigned to : ${snapshot.data['email']}",
                          style: GoogleFonts.oxygen(
                              fontSize: 15,
                              color: Colors.white,
                              letterSpacing: 3),
                        );
                      } else
                        return Container();
                    },
                  )
                : Container(),
            Text(
              widget.description,
              style: GoogleFonts.oxygen(
                  fontSize: 15, color: Colors.white, letterSpacing: 3),
            ),
            (widget.currentUser != 0 && !widget.resolved)
                ? ((widget.currentUser == 4)
                    ? (widget.assignedto == "")
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
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          TeamList()).then((value) {
                                    res = value;
                                    //print("Vermaaaa ${res}");
                                    _firestore
                                        .collection('bugs')
                                        .doc(widget.docid)
                                        .update({
                                      'assignto': res[0],
                                      'plvl': res[1],
                                      'resolved': false
                                    });

                                    setState(() {
                                      widget.assignedto = res[0];
                                      widget.plvl = res[1];
                                      assign();
                                    });
                                  });
                                }),
                          )
                        : Container()
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
                            onPressed: () {
                              _firestore
                                  .collection('bugs')
                                  .doc(widget.docid)
                                  .update({
                                'resolved': true,
                              });
                              print("Astitvaaaa ${LogginUser['docid']}");
                              widget.resolved = true;
                              _firestore
                                  .collection('users')
                                  .doc(LogginUser['docid'])
                                  .update({
                                'bugsresolved': (LogginUser['bugsresolved'] + 1)
                              });
                              setState(() {});
                            }),
                      ))
                : Container(),
          ],
        ),
      ),
    );
  }
}
