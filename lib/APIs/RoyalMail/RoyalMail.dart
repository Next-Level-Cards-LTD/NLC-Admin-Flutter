import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Shared/FirestoreDB.dart';
import 'Config.dart';

class RoyalMail {
  Stream<RoyalMail_API> get RoyalMailAPI => FirebaseFirestore.instance.collection(FirestoreDB.instance.APIConfigsCollection).doc("RoyalMail").snapshots().map(_RoyalMailAPIFromSnapshots);

  RoyalMail_API _RoyalMailAPIFromSnapshots(DocumentSnapshot snapshot) => RoyalMail_API.setup(snapshot);


}