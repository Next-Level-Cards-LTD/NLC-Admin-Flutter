part of 'package:next_level_admin/APIs/CardMarket/CardMarket_Library.dart';

class Address {
  //Postal Address
  String Name = "";
  String Extra = "";
  String Street = "";
  String PostCode = "";
  String City = "";
  String Country = "";

  Address();

  Address.fromXML(Iterable<XmlElement> address) {
    Name = address.map((e) => e.findAllElements("name").single.text).single.toString();
    Extra = address.map((e) => e.findAllElements("extra").single.text).single.toString();
    Street = address.map((e) => e.findAllElements("street").single.text).single.toString();
    PostCode = address.map((e) => e.findAllElements("zip").single.text).single.toString();
    City = address.map((e) => e.findAllElements("city").single.text).single.toString();
    Country = address.map((e) => e.findAllElements("country").single.text).single.toString();
  }

  Map<String, dynamic> toMap() => {
    "name" : Name,
    "extra" : Extra,
    "street" : Street,
    "postcode" : PostCode,
    "city" : City,
    "country" : Country
  };
}