import 'package:cloud_firestore/cloud_firestore.dart';

class api {
  Future<List<Map<String, dynamic>>> getUserBugs(String uid) async {
    final _firestore = FirebaseFirestore.instance;
    Map<String, dynamic> user = await getUserDetails(uid);
    List<Map<String, dynamic>> bugs = [];
    var data = await _firestore
        .collection('bugs')
        .where('assignedto', isEqualTo: uid)
        .get();
    var list = data.docs;
    for (var bug in list) {
      if (bug.data()['plvl'] <= user['authlvl']) ;
      bugs.add(bug.data());
    }
    return bugs;
  }

  Future<List<Map<String, dynamic>>> getPublicBugs() async {
    final _firestore = FirebaseFirestore.instance;
    List<Map<String, dynamic>> bugs = [];
    var data = await _firestore
        .collection('bugs')
        .where('plvl', isEqualTo: 0)
        .get();
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
}
