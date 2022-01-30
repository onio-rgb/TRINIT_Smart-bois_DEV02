import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bugtracker/components/db_api.dart';
import 'package:google_fonts/google_fonts.dart';

class TeamList extends StatefulWidget {
  const TeamList({Key? key}) : super(key: key);

  @override
  _TeamListState createState() => _TeamListState();
}

class _TeamListState extends State<TeamList> {
  var api_handler = new api();
  String decode(int authlvl) {
    if (authlvl == 4)
      return "MGR";
    else if (authlvl != 0)
      return ("SDE${authlvl}");
    else
      return "U";
  }

  double _value = 4;
  String uid = "";
  int? highlight = 100000;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: api_handler.getTeamList(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 20,
            backgroundColor: Color(0xFF292838),
            child: Column(
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  width: 300,
                  height: 600,
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        child: FlatButton(
                            onPressed: () {
                              uid = snapshot.data[index]['uid'];
                              Navigator.pop(context, [uid, _value.toInt()]);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  snapshot.data[index]['email'],
                                  style: GoogleFonts.oxygen(
                                      fontSize: 15, letterSpacing: 2),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: (snapshot.data[index]['authlvl'] ==
                                              4)
                                          ? (Colors.blue)
                                          : ((snapshot.data[index]['authlvl'] ==
                                                  3)
                                              ? (Colors.green)
                                              : ((snapshot.data[index]
                                                          ['authlvl'] ==
                                                      2)
                                                  ? Colors.orangeAccent
                                                  : Colors.orange)),
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  width: 50,
                                  height: 25,
                                  child: Center(
                                    child: Text(
                                      decode(snapshot.data[index]['authlvl']),
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.oxygen(
                                          fontSize: 13, letterSpacing: 1),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (snapshot.data[index]
                                                ['bugsresolved'] >
                                            9)
                                        ? (Colors.blue)
                                        : ((snapshot.data[index]
                                                    ['bugsresolved'] >
                                                6)
                                            ? (Colors.green)
                                            : ((snapshot.data[index]
                                                        ['bugsresolved'] >
                                                    3)
                                                ? Colors.orangeAccent
                                                : Colors.orange)),
                                    border: Border.all(color: Colors.black),
                                  ),
                                  width: 40,
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      "${snapshot.data[index]['bugsresolved']}",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.oxygen(
                                          fontSize: 13, letterSpacing: 1),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Choose Priority Level ",
                    style: GoogleFonts.oxygen(fontSize: 15, letterSpacing: 2),
                  ),
                ),
                Slider(
                  activeColor: Colors.blue,
                  value: _value,
                  max: 4,
                  divisions: 4,
                  label: _value.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _value = value;
                    });
                  },
                )
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
