import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:next_level_admin/APIs/Configs/CardMarket.dart';
import 'package:next_level_admin/Data%20Models/User.dart';


class Database
{
  final String uid = Auth.FirebaseAuth.instance.currentUser!.uid;

  //final String uid = FirebaseAuth.instance.currentUser!.uid;
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("Users");
  final CollectionReference YuGiOhCardDatabase = FirebaseFirestore.instance.collection("YuGiOh Cards");
  final CollectionReference APIConfigs = FirebaseFirestore.instance.collection("API Config");

  Future UploadCardToDatabase(Map<String, dynamic> Data) async
  {
    return YuGiOhCardDatabase.doc().set(Data);
  }

  Stream<CardMarket_API> get CardMarketAPI
  {
    return APIConfigs.doc("CardMarket").snapshots().map(_displayCharactersFromSnapshots);
  }

  //Characters from snapshot
  CardMarket_API _displayCharactersFromSnapshots(DocumentSnapshot snapshot) {
    return CardMarket_API.setup(snapshot);
  }

  Future createUser(String userName, String email) async
  {
    return await userCollection.doc(uid).set({
      'uid': uid,
      'username': userName,
      'email': email,
    });
  }

  //get User doc stream
  Stream<User> get user {
    return userCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }

  //User from snapshot
  User _userFromSnapshot(DocumentSnapshot snapshot) {
    return User.documentSnapshot(snapshot);
  }
}