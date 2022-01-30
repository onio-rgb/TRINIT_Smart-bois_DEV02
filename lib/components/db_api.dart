import 'package:cloud_firestore/cloud_firestore.dart';

class api {
  Future<List<Map<String, dynamic>>> getUserBugs(String uid) async {
    final _firestore = FirebaseFirestore.instance;
    Map<String, dynamic> user = await getUserDetails(uid);
    List<Map<String, dynamic>> bugs = [];
    var data;
    if (user['authlvl'] != 4) {
      data = await _firestore
          .collection('bugs')
          .where('assignto', isEqualTo: user['uid'])
          .get();
    } else {
      data = await _firestore.collection('bugs').get();
    }
    //print("VERMA ${data.docs.length}");
    var list = data.docs;
    for (var bug in list) {
      if (bug.data()['plvl'] <= user['authlvl'] || user['authlvl'] == 4) ;
      bugs.add(bug.data());
    }
    return bugs;
  }

  Future<List<Map<String, dynamic>>> getPublicBugs() async {
    final _firestore = FirebaseFirestore.instance;
    List<Map<String, dynamic>> bugs = [];
    var data =
        await _firestore.collection('bugs').where('plvl', isEqualTo: 0).get();
    var list = data.docs;
    for (var bug in list) {
      bugs.add(bug.data());
    }
    return bugs;
  }

  Future<Map<String, dynamic>> getUserDetails(String uid) async {
    final _firestore = FirebaseFirestore.instance;
    var data =
        await _firestore.collection('users').where('uid', isEqualTo: uid).get();
    var user = data.docs;
    return user[0].data();
  }

  Future<List<Map<String, dynamic>>> getTeamList() async {
    final _firestore = FirebaseFirestore.instance;
    List<Map<String, dynamic>> teamMembers = [];
    var data = await _firestore
        .collection('users')
        .where('authlvl', isNotEqualTo: 0)
        .orderBy('authlvl', descending: true)
        .orderBy('bugsresolved', descending: true)
        .get();
    var list = data.docs;
    for (var member in list) {
      teamMembers.add(member.data());
    }
    return teamMembers;
  }
}
