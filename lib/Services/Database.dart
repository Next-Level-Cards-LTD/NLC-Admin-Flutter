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
  final CollectionReference orderCollection = FirebaseFirestore.instance.collection("Orders");

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
      APIConfigs.doc("RoyalMail").get().then((value) => RoyalMail_API.setup(value));
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


  Future UploadOrder(String docName, Map<String, dynamic> data, List<Map<String, dynamic>> articles) async {
    DocumentSnapshot doc = await orderCollection.doc(docName).get();
    if(doc.exists)
      {
        print("Update");
        return await orderCollection.doc(docName).update(data).then((value) =>
        {
          //Update shouldn't need to update the articles
          articles.forEach((element) {
            orderCollection.doc(docName).collection("Articles").doc(element.values.first.toString()).set(element);
          })
        });
      }
    else
      {
        print("Create");
        return await orderCollection.doc(docName).set(data).then((value) =>
        {
          articles.forEach((element) {
            orderCollection.doc(docName).collection("Articles").doc(element.values.first.toString()).set(element);
          })
        });
      }
  }
}