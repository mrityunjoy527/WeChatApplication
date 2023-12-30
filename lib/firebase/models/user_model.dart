import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String username;
  final String myUid;

  UserModel({required this.myUid, required this.username});

  UserModel.fromFirebase(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : username = snapshot.data()['username'],
        myUid = snapshot.id;
}
