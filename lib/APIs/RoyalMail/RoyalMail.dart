import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:next_level_admin/APIs/CardMarket/Config.dart';
import 'package:next_level_admin/Shared/Libraries/Database_Library.dart';

import 'Config.dart';

class RoyalMail {
  Stream<RoyalMail_API> get RoyalMailAPI => FirebaseFirestore.instance.collection(APIConfigsCollection).doc("RoyalMail").snapshots().map(_RoyalMailAPIFromSnapshots);

  RoyalMail_API _RoyalMailAPIFromSnapshots(DocumentSnapshot snapshot) => RoyalMail_API.setup(snapshot);


}