import 'package:xml/xml.dart';

class Product{
  //product
  int gameID = 0;
  String enName = "";
  String locName = "";
  String expansion = "";
  String code = "";
  int expIcon = 0;
  String rarity = "";

  Product();

  Product.fromXml(XmlElement product){
    gameID = int.parse(product.findAllElements("idGame").single.text);
    enName = product.findAllElements("enName").single.text;
    locName = product.findAllElements("locName").single.text;
    expansion = product.findAllElements("expansion").single.text;
    code = product.findAllElements("nr").single.text;
    expIcon = int.parse(product.findAllElements("expIcon").single.text);
    rarity = product.findAllElements("rarity").single.text;
  }

  Map<String, dynamic> toMap() => {
    "gameID" : gameID,
    "en_name" : enName,
    "loc_name" : locName,
    "expansion" : expansion,
    "code" : code,
    "exp_icon" : expIcon,
    "rarity" : rarity
  };
}