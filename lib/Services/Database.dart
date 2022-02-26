import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:next_level_admin/APIs/Configs/CardMarket.dart';


class Database
{
  //final String uid = FirebaseAuth.instance.currentUser!.uid;

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
}