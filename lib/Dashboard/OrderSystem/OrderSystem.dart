import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:next_level_admin/APIs/CardMarket/CardMarket_Library.dart' as CM;
import 'package:next_level_admin/APIs/CardMarket/Types/OrderListener.dart';
import 'package:next_level_admin/Shared/FirestoreDB.dart';
import 'package:next_level_admin/Shared/Libraries/Database_Library.dart';
import 'Types/OrderTileType.dart';

class OrderSystem{

  Future UploadOrder(String docName, Map<String, dynamic> data, CM.Articles articles) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection(FirestoreDB.instance.orderCollection).doc(docName).get();
    if(doc.exists)
    {
      print("Update");
      data["updated_on"] = DateTime.now();
      data["updated_by"] = "Ricky"; //Need to change this to get logged in username
      return await FirebaseFirestore.instance.collection(FirestoreDB.instance.orderCollection).doc(docName).update(data).then((value) =>
      {
        //Update shouldn't need to update the articles
        articles.articles.forEach((element) {
          FirebaseFirestore.instance.collection(FirestoreDB.instance.orderCollection).doc(docName).collection("Articles").doc(element.articleID.toString()).set(element.toMap());
        })
      });
    }
    else
    {
      print("Create");
      data["created_on"] = DateTime.now();
      data["created_by"] = "Ricky"; //Need to change this to get logged in username
      return await FirebaseFirestore.instance.collection(FirestoreDB.instance.orderCollection).doc(docName).set(data).then((value) =>
      {
        articles.articles.forEach((element) {
          FirebaseFirestore.instance.collection(FirestoreDB.instance.orderCollection).doc(docName).collection("Articles").doc(element.articleID.toString()).set(element.toMap());
        })
      });
    }
  }
  
  Stream <List<OrderTileType>?> get paidOrders {
    return FirebaseFirestore.instance.collection(FirestoreDB.instance.orderCollection).where('purchase_state', isEqualTo: 'paid').snapshots().map(_displayPaidOrdersFromSnapshot);
  }

  List<OrderTileType>? _displayPaidOrdersFromSnapshot(QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        return OrderTileType(
            doc["orderID"],
            doc["source"],
            doc["username"],
            doc["name"],
            doc["total_value"],
            doc["datePaid"]
        );
      }).toList();
  }

  Stream<CM.Order> get order => FirebaseFirestore.instance.collection(FirestoreDB.instance.orderCollection).doc("CM-${OrderListener.activeOrderUID.value}").snapshots().map(_getOrderFromSnapshot);


  CM.Order _getOrderFromSnapshot(DocumentSnapshot snapshot)
  {
    return CM.Order.FromSnapshot(snapshot);
  }
}