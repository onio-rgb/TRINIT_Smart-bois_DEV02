import 'dart:developer';

import 'package:bugtracker/components/Button.dart';
import 'package:bugtracker/main.dart';
import 'package:flutter/material.dart';

class BugElement extends StatefulWidget {
  String bugname;
  String description;
  String raisedBy;
  bool resolved;
  String currentUser;
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
            Text('Raised by '),
            Text('desciption'),
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
