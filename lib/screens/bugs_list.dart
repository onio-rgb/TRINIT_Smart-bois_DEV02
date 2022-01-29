import 'package:bugtracker/constant.dart';
import 'package:flutter/material.dart';
import 'package:bugtracker/components/bugs_list_element.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bugtracker/components/db_api.dart';

class BugList extends StatefulWidget {
  const BugList({Key? key}) : super(key: key);

  @override
  _BugListState createState() => _BugListState();
}

class _BugListState extends State<BugList> {
  var api_handler = new api();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, 'report_bug');
          },
        ),
        body: FutureBuilder(
          future: (LogginUser['authlvl'] != 0)
              ? api_handler.getUserBugs(_auth.currentUser!.uid)
              : api_handler.getPublicBugs(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.none &&
                snapshot.hasData == null) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return BugElement(
                      bugname: snapshot.data[index]['title'],
                      description: snapshot.data[index]['description'],
                      raisedBy: snapshot.data[index]['raisedby'],
                      resolved: snapshot.data[index]['resolved'],
                      currentUser: LogginUser['authlvl']);
                },
              );
            }
            return Container(
              width: double.infinity,
              height: 305,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.black45,
                ),
              ),
            );
          },
        ));
  }
}
