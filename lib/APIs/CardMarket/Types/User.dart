part of 'package:next_level_admin/APIs/CardMarket/CardMarket_Library.dart';

class User {
  //Buyer ID
  String buyerID = "";
  String username = "";

  User();

  User.fromXml(Iterable<XmlElement> buyer){
    buyerID = buyer.map((e) => e.findAllElements("idUser").single.text).single.toString();
    username = buyer.map((e) => e.findAllElements("username").single.text).single.toString();
  }

  User.fromSnapshot(DocumentSnapshot doc)
  {
    buyerID = doc["buyerId"];
    username = doc["username"];
  }

  Map<String, dynamic> toMap() => {
    "buyerId" : buyerID,
    "username" : username
  };

}