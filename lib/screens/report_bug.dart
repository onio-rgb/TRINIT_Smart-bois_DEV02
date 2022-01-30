import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bugtracker/constants.dart';
import 'package:bugtracker/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bugtracker/components/Button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ReportBug extends StatefulWidget {
  const ReportBug({Key? key}) : super(key: key);

  @override
  _ReportBugState createState() => _ReportBugState();
}

class _ReportBugState extends State<ReportBug> {
  final _firestore = FirebaseFirestore.instance;
  bool showSpinner = false;
  String title = "";
  String description = "";

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: Colors.white,
      inAsyncCall: showSpinner,
      child: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          heading(text: "Name the bug appropriately !"),
          TextField(
              onChanged: (value) {
                title = value;
              },
              style: TextStyle(color: Colors.white),
              decoration: kDecoration.copyWith(
                  hintText: 'Enter the title . . . ',
                  hintStyle: TextStyle(
                    color: Colors.white38,
                  ))),
          heading(text: "Describe the bug !"),
          TextField(
              maxLines: 5,
              onChanged: (value) {
                description = value;
              },
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.multiline,
              style: TextStyle(color: Colors.white),
              decoration: kDecoration.copyWith(
                  hintText: 'Describe the behaviour . . .',
                  hintStyle: TextStyle(
                    color: Colors.white38,
                  ))),
          Button(
            title: 'Report Bug',
            color: Colors.grey.withOpacity(0.5),
            onPressed: () async {
              showSpinner = true;
              setState(() {});

              var loginuser = await _firestore.collection('bugs').add({
                'title': title,
                'description': description,
                'raisedby': LogginUser['uid'],
                'plvl': 1,
                'resolved': false
              });
              await _firestore
                  .collection('bugs')
                  .doc(loginuser.id)
                  .update({'bugid': loginuser.id});
              showSpinner = false;

              Navigator.pop(context);
            },
          )
        ],
      )),
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
            fontSize: 15, color: Colors.white, letterSpacing: 3),
      ),
    );
  }
}
