part of 'package:next_level_admin/APIs/CardMarket/CardMarket_Library.dart';

class ShippingMethod {
  //Shipping Method
  int shippingID = 0;
  String methodName = "";
  double shippingPrice = 0;
  int currencyID = 0;
  String currencyCode = "";
  bool isLetter = true;
  bool isInsured = false;

  ShippingMethod();

  ShippingMethod.fromXml(Iterable<XmlElement> method) {
    shippingID = int.parse(method.map((e) => e.findAllElements("idShippingMethod").single.text).single.toString());
    methodName = method.map((e) => e.findAllElements("name").single.text).single.toString();
    shippingPrice = double.parse(method.map((e) => e.findAllElements("price").single.text).single.toString());
    currencyID = int.parse(method.map((e) => e.findAllElements("idCurrency").single.text).single.toString());
    currencyCode = method.map((e) => e.findAllElements("currencyCode").single.text).single.toString();
    isLetter = method.map((e) => e.findAllElements("isLetter").single.text).single.toString() == 'true';
    isInsured = method.map((e) => e.findAllElements("isInsured").single.text).single.toString() == 'true';
  }

  ShippingMethod.fromSnapshot(DocumentSnapshot doc)
  {
    shippingID = doc["shippingID"];
    methodName = doc["method_name"];
    shippingPrice = doc["shipping_price"];
    currencyID = doc["currencyID"];
    currencyCode = doc["currency_code"];
    isLetter = doc["is_letter"];
    isInsured = doc["is_insured"];
  }

  Map<String, dynamic> toMap() => {
    "shippingID" : shippingID,
    "method_name" : methodName,
    "shipping_price" : shippingPrice,
    "currencyID" : currencyID,
    "currency_code" : currencyCode,
    "is_letter" : isLetter,
    "is_insured" : isInsured
  };

}