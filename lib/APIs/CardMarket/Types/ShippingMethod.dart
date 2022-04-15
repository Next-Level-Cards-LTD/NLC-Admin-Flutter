part of 'package:next_level_admin/APIs/CardMarket/CardMarket_Library.dart';

class ShippingMethod {
  //Shipping Method
  int ShippingID = 0;
  String MethodName = "";
  double ShippingPrice = 0;
  int currencyID = 0;
  String CurrencyCode = "";
  bool isLetter = true;
  bool isInsured = false;

  ShippingMethod();

  ShippingMethod.fromXml(Iterable<XmlElement> method) {
    ShippingID = int.parse(method.map((e) => e.findAllElements("idShippingMethod").single.text).single.toString());
    MethodName = method.map((e) => e.findAllElements("name").single.text).single.toString();
    ShippingPrice = double.parse(method.map((e) => e.findAllElements("price").single.text).single.toString());
    currencyID = int.parse(method.map((e) => e.findAllElements("idCurrency").single.text).single.toString());
    CurrencyCode = method.map((e) => e.findAllElements("currencyCode").single.text).single.toString();
    isLetter = method.map((e) => e.findAllElements("isLetter").single.text).single.toString() == 'true';
    isInsured = method.map((e) => e.findAllElements("isInsured").single.text).single.toString() == 'true';
  }

  ShippingMethod.fromSnapshot(DocumentSnapshot doc)
  {
    ShippingID = doc["shippingID"];
    MethodName = doc["method_name"];
    ShippingPrice = doc["shipping_price"];
    currencyID = doc["currencyID"];
    CurrencyCode = doc["currency_code"];
    isLetter = doc["is_letter"];
    isInsured = doc["is_insured"];
  }

  Map<String, dynamic> toMap() => {
    "shippingID" : ShippingID,
    "method_name" : MethodName,
    "shipping_price" : ShippingPrice,
    "currencyID" : currencyID,
    "currency_code" : CurrencyCode,
    "is_letter" : isLetter,
    "is_insured" : isInsured
  };

}