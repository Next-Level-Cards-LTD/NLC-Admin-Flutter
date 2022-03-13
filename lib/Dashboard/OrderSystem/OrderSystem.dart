import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:next_level_admin/APIs/CardMarket/CardMarket_Library.dart';
import 'package:next_level_admin/Shared/Libraries/Database_Library.dart';

class OrderSystem{

  Future UploadOrder(String docName, Map<String, dynamic> data, Articles articles) async {
    DocumentSnapshot doc = await orderCollection.doc(docName).get();
    if(doc.exists)
    {
      print("Update");
      data["updated_on"] = DateTime.now();
      data["updated_by"] = "Ricky"; //Need to change this to get logged in username
      return await orderCollection.doc(docName).update(data).then((value) =>
      {
        //Update shouldn't need to update the articles
        articles.articles.forEach((element) {
          orderCollection.doc(docName).collection("Articles").doc(element.articleID.toString()).set(element.toMap());
        })
      });
    }
    else
    {
      print("Create");
      data["created_on"] = DateTime.now();
      data["created_by"] = "Ricky"; //Need to change this to get logged in username
      return await orderCollection.doc(docName).set(data).then((value) =>
      {
        articles.articles.forEach((element) {
          orderCollection.doc(docName).collection("Articles").doc(element.articleID.toString()).set(element.toMap());
        })
      });
    }
  }
}