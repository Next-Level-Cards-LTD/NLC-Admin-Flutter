import 'dart:convert';
import 'package:next_level_admin/Dashboard/OrderSystem/OrderSystem.dart';
import 'package:next_level_admin/Helpers/APIHelper.dart';
import 'package:next_level_admin/APIs/CardMarket/Config.dart';
import 'package:nonce/nonce.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

import 'package:next_level_admin/APIs/CardMarket/CardMarket_Library.dart' as CM;

import '../CardMarket_Library.dart';

class CardMarket_Orders
{

  Future<String> getOrder(int OrderID) async {
    String url = "https://api.cardmarket.com/ws/v2.0/order/$OrderID";

    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: '${CM.CardMarket.getOAuth(url)}'
    };

    final response = await http.get(Uri.parse(url), headers: headers);

    if(response.statusCode == 200)
    {
      //This gets the file from the api body and lets me be able to do things to it
      String xml = utf8.decode(response.bodyBytes);

      Order order = new Order(XmlDocument.parse(xml));

      OrderSystem().UploadOrder("CM-${order.ID}", order.toMap(), order.articles);

      return "Got Order";
    }
    else
    {
      return "This Failed";
    }
  }

  Future<String> getAllPaidOrders() async {
    String url = "https://api.cardmarket.com/ws/v2.0/orders/1/2";

    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: '${CM.CardMarket.getOAuth(url)}'
    };

    return getResponse(url, headers);
  }

  Future<String> getAllSentOrders() async {
    String url = "https://api.cardmarket.com/ws/v2.0/orders/1/4";

    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: '${CM.CardMarket.getOAuth(url)}'
    };

    return getResponse(url, headers);
  }

  Future<String> getAllReceivedOrders(int start) async {
    print("running");

    String url = "https://api.cardmarket.com/ws/v2.0/orders/1/8/$start";

    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: '${CM.CardMarket.getOAuth(url)}'
    };

    return await getResponse(url, headers);
  }

  Future<String> getResponse(String url, Map<String, String> headers)
  async {

  final response = await http.get(Uri.parse(url), headers: headers);

    if(response.statusCode == 200 || response.statusCode == 206)
    {
      //This gets the file from the api body and lets me be able to do things to it
      String xml = utf8.decode(response.bodyBytes);

      XmlDocument document = XmlDocument.parse(xml);
      print(document.findAllElements('order').length);
      document.findAllElements('order').forEach((element) {
        Order order = new Order.fromXmlElement(element);
        OrderSystem().UploadOrder("CM-${order.ID}", order.toMap(), order.articles);
      });
      print("Finished - Worked");
      return "Got Order";
    }
    else
    {
      print("Finished - Failed");
      print("${response.statusCode}");
      return "This Failed";
    }
  }

  syncAllOrders()
  {
    getAllPaidOrders();
    getAllSentOrders();
    //Will bring this back at a later point, as really only want it to go through the sent orders and check if those have been received
    //getAllReceivedOrders(1);
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
