import 'dart:convert';
import 'package:next_level_admin/APIs/APIHelper.dart';
import 'package:next_level_admin/APIs/CardMarket/Config.dart';
import 'package:next_level_admin/OrderSystem/OrderSystem.dart';
import 'package:nonce/nonce.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:xml/xml.dart';

import 'package:next_level_admin/APIs/CardMarket/CardMarket_Library.dart' as CM;

import '../CardMarket_Library.dart';

// ignore: camel_case_types
class CardMarket_Orders
{

  Future<String> getOrder(int orderID) async {
    String url = "https://api.cardmarket.com/ws/v2.0/order/$orderID";

    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: '${CM.CardMarket.getOAuth(url)}'
    };

    final response = await http.get(Uri.parse(url), headers: headers);

    if(response.statusCode == 200)
    {
      //This gets the file from the api body and lets me be able to do things to it
      String xml = utf8.decode(response.bodyBytes);

      Order order = new Order(XmlDocument.parse(xml));

      OrderSystem().uploadOrder("CM-${order.id}", order.toMap(), order.articles);

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

      document.findAllElements('order').forEach((element) {
        Order order = new Order.fromXmlElement(element);
        OrderSystem().uploadOrder("${Uuid().v1}", order.toMap(), order.articles);
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


  Future<String> getAccountData() async {


    String url = "https://api.cardmarket.com/ws/v2.0/account";

    int timeStamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    String nonce = Nonce.generate();
    String realm = url;

    Map<String, String> data = Map();
    data["oauth_consumer_key"] = CardMarket_API.getConsumerKey();
    data["oauth_signature_method"] = "HMAC-SHA1";
    data["oauth_timestamp"] = timeStamp.toString();
    data["oauth_nonce"] = nonce;
    data["oauth_token"] = CardMarket_API.getAccessToken();
    data["oauth_version"] = "1.0";

    String signature = APIHelper().generateSignature("GET", Uri.parse(url), data, CardMarket_API.getConsumerKeySecret(), CardMarket_API.getTokenSecret());

    String oAuth =
        'OAuth realm="$realm",' +
            'oauth_consumer_key="${CardMarket_API.getConsumerKey()}",' +
            'oauth_token="${CardMarket_API.getAccessToken()}",' +
            'oauth_token_secret="${CardMarket_API.getTokenSecret()}",' +
            'oauth_signature_method="HMAC-SHA1",' +
            'oauth_timestamp="$timeStamp",' +
            'oauth_nonce="$nonce",' +
            'oauth_version="1.0",' +
            'oauth_signature="$signature"';

    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: '$oAuth'
    };

    final response = await http.get(Uri.parse(url), headers: headers);

    if(response.statusCode == 200)
    {
      String xml = utf8.decode(response.bodyBytes);
      final document = XmlDocument.parse(xml);
      final titles = document.findAllElements('extra');
      //Need to clean up this part or standardise is but this works for getting node from XML - Maybe make some form of xml helper/parser class to sort this out into various data models
      titles
          .map((node) => node.text)
          .forEach(print);
      return "Got Order";
    }
    else
    {
      print(oAuth);
      print(response.statusCode.toString());
      return "This Failed";
    }
  }

}
