import 'dart:developer';

import 'package:bugtracker/components/Button.dart';
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
          title: Row(children: [
            Text(widget.bugname),
            Container(
              width: 100,
              height: 50,
              color: (widget.resolved) ? (Colors.green) : (Colors.red),
            )
          ]),
          children: [
            Text('Raised by '),
            Text('desciption'),
            (widget.currentUser != '0')
                ? ((widget.currentUser == '4')
                    ? FlatButton(
                        color: Colors.green,
                        child: Text('Assign to'),
                        onPressed: () {})
                    : FlatButton(
                        color: Colors.green,
                        child: Text('Mark Resolved'),
                        onPressed: () {}))
                : Container(),
          ],
        ),
      ),
    );
  }
}
