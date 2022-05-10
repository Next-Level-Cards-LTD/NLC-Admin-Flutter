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
    gameID = product.findAllElements("idGame").isNotEmpty ? int.parse(product.findAllElements("idGame").single.text) : 0;
    enName = product.findAllElements("enName").isNotEmpty ? product.findAllElements("enName").single.text : "";
    locName = product.findAllElements("locName").isNotEmpty ? product.findAllElements("locName").single.text : "";
    expansion = product.findAllElements("expansion").isNotEmpty ? product.findAllElements("expansion").single.text : "";
    code = product.findAllElements("nr").isNotEmpty ? product.findAllElements("nr").single.text : "";
    expIcon = product.findAllElements("expIcon").isNotEmpty ? int.parse(product.findAllElements("expIcon").single.text) : 0;
    rarity = product.findAllElements("rarity").isNotEmpty ? product.findAllElements("rarity").single.text : "";
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