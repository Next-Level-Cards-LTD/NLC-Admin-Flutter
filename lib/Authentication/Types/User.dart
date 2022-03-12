import 'package:cloud_firestore/cloud_firestore.dart';

class UserMini {
  final String uid;

  UserMini({required this.uid});
}

class User {
  String uid = "";
  String email= "";
  String username = "";

  User(this.uid, this.email, this.username);

  User.documentSnapshot(DocumentSnapshot data) : this(data['uid'], data['email'], data['username']);


  @override
  String toString() {
    return "User [uid=${this.uid}, email=${this.email}, username=${this.username}]";
  }
}