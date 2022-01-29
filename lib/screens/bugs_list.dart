import 'package:flutter/material.dart';
import 'package:bugtracker/components/bugs_list_element.dart';
class BugList extends StatefulWidget {
  const BugList({ Key? key }) : super(key: key);

  @override
  _BugListState createState() => _BugListState();
}

class _BugListState extends State<BugList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        BugElement(bugname: "bugname", description: "description", raisedBy: "raised by", resolved: false, currentUser: "4"),
        BugElement(bugname: "bugname", description: "description", raisedBy: "raised by", resolved: false, currentUser: "3"),
        BugElement(bugname: "bugname", description: "description", raisedBy: "raised by", resolved: true, currentUser: "4"),
        BugElement(bugname: "bugname", description: "description", raisedBy: "raised by", resolved: false, currentUser: "0"),
      ],
    );
  }
}