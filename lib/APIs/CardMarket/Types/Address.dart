part of 'package:next_level_admin/APIs/CardMarket/CardMarket_Library.dart';

class Address {
  //Postal Address
  String name = "";
  String extra = "";
  String street = "";
  String postCode = "";
  String city = "";
  String country = "";

  Address();

  Address.fromXML(Iterable<XmlElement> address) {
    name = address.map((e) => e.findAllElements("name").single.text).single.toString();
    extra = address.map((e) => e.findAllElements("extra").single.text).single.toString();
    street = address.map((e) => e.findAllElements("street").single.text).single.toString();
    postCode = address.map((e) => e.findAllElements("zip").single.text).single.toString();
    city = address.map((e) => e.findAllElements("city").single.text).single.toString();
    country = address.map((e) => e.findAllElements("country").single.text).single.toString();
  }

  Address.fromSnapshot(DocumentSnapshot doc)
  {
    name = doc["name"];
    extra = doc["extra"];
    street = doc["street"];
    postCode = doc["postcode"];
    city = doc["city"];
    country = doc["country"];
  }

  Map<String, dynamic> toMap() => {
    "name" : name,
    "extra" : extra,
    "street" : street,
    "postcode" : postCode,
    "city" : city,
    "country" : country
  };
}