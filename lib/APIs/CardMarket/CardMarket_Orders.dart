import 'dart:convert';
import 'dart:developer';

import 'package:next_level_admin/APIs/APIHelper.dart';
import 'package:next_level_admin/APIs/Configs/CardMarket.dart';
import 'package:nonce/nonce.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:xml/xml.dart';

class CardMarket_Orders
{

  Future<String> GetOrder(int OrderID) async {
    String url = "https://api.cardmarket.com/ws/v2.0/order/$OrderID";

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
      final titles = document.findAllElements('firstName');
      //Need to clean up this part or standardise is but this works for getting node from XML - Maybe make some form of xml helper/parser class to sort this out into various data models
      titles
          .map((node) => node.text)
          .forEach(print);
      //log(document.findElements("").toString());
      log("Got Order");
      log(OrderID.toString());
      return "Got Order";
    }
    else
    {
      print(OAuth);
      print(response.statusCode.toString());
      return "This Failed";
    }
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