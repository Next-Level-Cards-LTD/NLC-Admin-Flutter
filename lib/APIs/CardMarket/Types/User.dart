part of 'package:next_level_admin/APIs/CardMarket/CardMarket_Library.dart';

class User {
  //Buyer ID
  String buyerID = "";
  String Username = "";

  User();

  User.fromXml(Iterable<XmlElement> buyer){
    buyerID = buyer.map((e) => e.findAllElements("idUser").single.text).single.toString();
    Username = buyer.map((e) => e.findAllElements("username").single.text).single.toString();
  }

  Map<String, dynamic> toMap() => {
    "buyerId" : buyerID,
    "username" : Username
  };

}