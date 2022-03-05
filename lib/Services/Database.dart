import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:next_level_admin/APIs/Configs/CardMarket.dart';
import 'package:next_level_admin/APIs/Configs/RoyalMail.dart';
import 'package:next_level_admin/Data%20Models/User.dart';


class Database
{
  final String uid = Auth.FirebaseAuth.instance.currentUser!.uid;
  
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("Users");
  final CollectionReference YuGiOhCardDatabase = FirebaseFirestore.instance.collection("YuGiOh Cards");
  final CollectionReference APIConfigs = FirebaseFirestore.instance.collection("API Configs");

  Future UploadCardToDatabase(Map<String, dynamic> Data) async
  {
    return YuGiOhCardDatabase.doc().set(Data);
  }

  Stream<CardMarket_API> get CardMarketAPI => APIConfigs.doc("CardMarket").snapshots().map(_cardMarketAPIFromSnapshots);

  //Characters from snapshot
  CardMarket_API _cardMarketAPIFromSnapshots(DocumentSnapshot snapshot) => CardMarket_API.setup(snapshot);

  Stream<RoyalMail_API> get RoyalMailAPI => APIConfigs.doc("RoyalMail").snapshots().map(_RoyalMailAPIFromSnapshots);

  RoyalMail_API _RoyalMailAPIFromSnapshots(DocumentSnapshot snapshot) => RoyalMail_API.setup(snapshot);

  Future getAPIData() async
  {
    if(!CardMarket_API.instance.hasData) {
      APIConfigs.doc("CardMarket").get().then((value) => CardMarket_API.setup(value));
    }
    if(!RoyalMail_API.instance.hasData) {
      APIConfigs.doc("RoyalMail")..get().then((value) => RoyalMail_API.setup(value));
    }
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
  Stream<User> get user => userCollection.doc(uid).snapshots().map(_userFromSnapshot);

  //User from snapshot
  User _userFromSnapshot(DocumentSnapshot snapshot) => User.documentSnapshot(snapshot);

}