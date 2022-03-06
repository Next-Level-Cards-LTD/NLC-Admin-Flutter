import 'dart:convert';
import 'dart:developer';

import 'package:next_level_admin/APIs/APIHelper.dart';
import 'package:next_level_admin/APIs/CardMarket/CardMarket_Base.dart';
import 'package:next_level_admin/APIs/Configs/CardMarket.dart';
import 'package:next_level_admin/Data%20Models/User.dart';
import 'package:next_level_admin/Services/Database.dart';
import 'package:nonce/nonce.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:xml/xml.dart';

class CardMarket_Orders
{

  //Buyer ID
  String buyerID = "";
  String Username = "";

  //Postal Address
  String Name = "";
  String Extra = "";
  String Street = "";
  String PostCode = "";
  String City = "";
  String Country = "";

  //Order State
  String PurchaseState = "";
  DateTime dateBought = new DateTime.now();
  DateTime datePaid = new DateTime.now();

  Future<String> GetOrder(int OrderID) async {
    String url = "https://api.cardmarket.com/ws/v2.0/order/$OrderID";
    String realm = url;

    String nonce = Nonce.generate();
    int TimeStamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    Map<String, String> data = Map();
    data["oauth_consumer_key"] = CardMarket_API.instance.ConsumerKey!;
    data["oauth_signature_method"] = "HMAC-SHA1";
    data["oauth_timestamp"] = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    data["oauth_nonce"] = nonce;
    data["oauth_token"] = CardMarket_API.instance.AccessToken!;
    data["oauth_version"] = "1.0";



    String Signature = APIHelper().generateSignature("GET", Uri.parse(url), data, CardMarket_API.instance.ConsumerKeySecret!, CardMarket_API.instance.TokenSecret!);

    String OAuth =
        'OAuth realm="$realm",' +
            'oauth_consumer_key="${CardMarket_API.instance.ConsumerKey!}",' +
            'oauth_token="${CardMarket_API.instance.AccessToken!}",' +
            'oauth_token_secret="${CardMarket_API.instance.TokenSecret!}",' +
            'oauth_signature_method="HMAC-SHA1",' +
            'oauth_timestamp="$TimeStamp",' +
            'oauth_nonce="$nonce",' +
            'oauth_version="1.0",' +
            'oauth_signature="$Signature"';

    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: '$OAuth'
    };

    final response = await http.get(Uri.parse(url), headers: headers);

    if(response.statusCode == 200)
    {
      //This gets the file from the api body and lets me be able to do things to it
      String xml = utf8.decode(response.bodyBytes);
      final document = XmlDocument.parse(xml);


      final buyer = document.findAllElements('buyer');
      _getUserData(buyer);

      final state = document.findAllElements('state').first;
      _getStateData(state);


      Database().UploadOrder(_createData());

      return "Got Order";
    }
    else
    {
      return "This Failed";
    }
  }


  _getUserData(Iterable<XmlElement> buyer) {

    buyerID = buyer.map((e) => e.findAllElements("idUser").single.text).single.toString();
    Username = buyer.map((e) => e.findAllElements("username").single.text).single.toString();

    final address = buyer.map((e) => e.findAllElements("address"));
    Name = address.map((e) => e.map((e) => e.findAllElements("name").single.text).single).single..toString();
    Extra = address.map((e) => e.map((e) => e.findAllElements("extra").single.text).single).single..toString();
    Street = address.map((e) => e.map((e) => e.findAllElements("street").single.text).single).single..toString();
    PostCode = address.map((e) => e.map((e) => e.findAllElements("zip").single.text).single).single..toString();
    City = address.map((e) => e.map((e) => e.findAllElements("city").single.text).single).single..toString();
    Country = address.map((e) => e.map((e) => e.findAllElements("country").single.text).single).single..toString();
  }

  _getStateData(XmlElement state) {
    PurchaseState = state.findAllElements('state').single.text;
    dateBought = DateTime.parse(state.findAllElements('dateBought').single.text);
    datePaid = DateTime.parse(state.findAllElements('datePaid').single.text);
  }

  Map<String, dynamic> _createData() {
    Map<String, dynamic> data = Map();
    data["buyerID"] = buyerID;
    data["username"] = Username;
    data["name"] = Name;
    data["extra"] = Extra;
    data["street"] = Street;
    data["postcode"] = PostCode;
    data["city"] = City;
    data["country"] = Country;
    data["purchase_state"] = PurchaseState;
    data["dateBought"] = dateBought;
    data["datePaid"] = datePaid;

    return data;
  }



  Future<String> GetAccountData() async {


    String url = "https://api.cardmarket.com/ws/v2.0/account";

    int TimeStamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    String nonce = Nonce.generate();
    String realm = url;

    Map<String, String> data = Map();
    data["oauth_consumer_key"] = CardMarket_API.instance.ConsumerKey!;
    data["oauth_signature_method"] = "HMAC-SHA1";
    data["oauth_timestamp"] = TimeStamp.toString();
    data["oauth_nonce"] = nonce;
    data["oauth_token"] = CardMarket_API.instance.AccessToken!;
    data["oauth_version"] = "1.0";

    String Signature = APIHelper().generateSignature("GET", Uri.parse(url), data, CardMarket_API.instance.ConsumerKeySecret!, CardMarket_API.instance.TokenSecret!);

    String OAuth =
        'OAuth realm="$realm",' +
            'oauth_consumer_key="${CardMarket_API.instance.ConsumerKey!}",' +
            'oauth_token="${CardMarket_API.instance.AccessToken!}",' +
            'oauth_token_secret="${CardMarket_API.instance.TokenSecret!}",' +
            'oauth_signature_method="HMAC-SHA1",' +
            'oauth_timestamp="$TimeStamp",' +
            'oauth_nonce="$nonce",' +
            'oauth_version="1.0",' +
            'oauth_signature="$Signature"';

    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: '$OAuth'
    };

    final response = await http.get(Uri.parse(url), headers: headers);

    if(response.statusCode == 200)
    {
      String xml = utf8.decode(response.bodyBytes);
      //log(xml);
      final document = XmlDocument.parse(xml);
      final titles = document.findAllElements('extra');
      //Need to clean up this part or standardise is but this works for getting node from XML - Maybe make some form of xml helper/parser class to sort this out into various data models
      titles
          .map((node) => node.text)
          .forEach(print);
      //log(document.findElements("").toString());
      return "Got Order";
    }
    else
    {
      print(OAuth);
      print(response.statusCode.toString());
      return "This Failed";
    }
  }


}