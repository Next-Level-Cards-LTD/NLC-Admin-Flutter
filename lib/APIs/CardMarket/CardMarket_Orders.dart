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
  //TODO Need to move this to a data model and structure this out properly once it all works
  String source = "Card Market";
  int orderID = 0;

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
  DateTime? datePaid;
  DateTime? dateSent;
  DateTime? dateReceived;

  //Shipping Method
  int ShippingID = 0;
  String MethodName = "";
  double ShippingPrice = 0;
  int currencyID = 0;
  String CurrencyCode = "";
  bool isLetter = true;
  bool isInsured = false;

  String trackingNumber = "";
  bool isPresale = false;

  int articleCount = 0;


  //evaluation data
  int evaluationGrade = 0;
  int itemDescription = 0;
  int packaging = 0;
  String comment = "";
  
  List<Article> articles = new List.empty(growable: true);

  List<Map<String, dynamic>> test = new List.empty(growable: true);

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


      orderID = int.parse(document.findAllElements('idOrder').single.text);

      _getUserData(document.findAllElements('buyer'));
      _getStateData(document.findAllElements('state').first);
      _getPostalAddress(document.findAllElements('shippingAddress'));
      _getShippingMethod(document.findAllElements('shippingMethod'));
      trackingNumber = document.findAllElements('trackingNumber').single.text;
      isPresale = document.findAllElements('trackingNumber').single.text == 'true';

      articleCount = int.parse(document.findAllElements('articleCount').single.text);
      if(PurchaseState == "evaluated")
        {
          _getEvaluation(document.findAllElements('evaluation'));
        }

      _getArticles(document.findAllElements('article'));

      Database().UploadOrder("CM-$orderID", _createData(), test);

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
  }

  _getStateData(XmlElement state) {
    PurchaseState = state.findAllElements('state').single.text;
    dateBought = DateTime.parse(state.findAllElements('dateBought').single.text);


    //TODO See if I can reduce these if statements to one line
    if(state.findAllElements('datePaid').isNotEmpty)
    {
      datePaid = DateTime.parse(state.findAllElements('datePaid').single.text);
    }
    if(state.findAllElements('dateSent').isNotEmpty)
      {
        dateSent = DateTime.parse(state.findAllElements('dateSent').single.text);
      }
    if(state.findAllElements('dateReceived').isNotEmpty)
    {
      dateReceived = DateTime.parse(state.findAllElements('dateReceived').single.text);
    }
  }

  _getPostalAddress(Iterable<XmlElement> address){
    Name = address.map((e) => e.findAllElements("name").single.text).single.toString();
    Extra = address.map((e) => e.findAllElements("extra").single.text).single.toString();
    Street = address.map((e) => e.findAllElements("street").single.text).single.toString();
    PostCode = address.map((e) => e.findAllElements("zip").single.text).single.toString();
    City = address.map((e) => e.findAllElements("city").single.text).single.toString();
    Country = address.map((e) => e.findAllElements("country").single.text).single.toString();
  }

  _getShippingMethod(Iterable<XmlElement> method){
    ShippingID = int.parse(method.map((e) => e.findAllElements("idShippingMethod").single.text).single.toString());
    MethodName = method.map((e) => e.findAllElements("name").single.text).single.toString();
    ShippingPrice = double.parse(method.map((e) => e.findAllElements("price").single.text).single.toString());
    currencyID = int.parse(method.map((e) => e.findAllElements("idCurrency").single.text).single.toString());
    CurrencyCode = method.map((e) => e.findAllElements("currencyCode").single.text).single.toString();
    isLetter = method.map((e) => e.findAllElements("isLetter").single.text).single.toString() == 'true';
    isInsured = method.map((e) => e.findAllElements("isInsured").single.text).single.toString() == 'true';
  }

  _getEvaluation(Iterable<XmlElement> evaluation){
    evaluationGrade = int.parse(evaluation.map((e) => e.findAllElements("evaluationGrade").single.text).single.toString());
    itemDescription = int.parse(evaluation.map((e) => e.findAllElements("itemDescription").single.text).single.toString());
    packaging = int.parse(evaluation.map((e) => e.findAllElements("packaging").single.text).single.toString());
    comment = evaluation.map((e) => e.findAllElements("comment").single.text).single.toString();
  }

  _getArticles(Iterable<XmlElement> Articles){
    Articles.forEach((element) => test.add(Article(element).getMap()));
  }

  Map<String, dynamic> _createData() {
    Map<String, dynamic> data = Map();

    data["source"] = source;
    data["orderID"] = orderID;

    //Buyer ID
    data["buyerID"] = buyerID;
    data["username"] = Username;
    //Postal Address
    data["name"] = Name;
    data["extra"] = Extra;
    data["street"] = Street;
    data["postcode"] = PostCode;
    data["city"] = City;
    data["country"] = Country;
    //Order State
    data["purchase_state"] = PurchaseState;
    data["dateBought"] = dateBought;
    data["datePaid"] = datePaid;
    data["dataSent"] = dateSent;
    data["dateReceived"] = dateReceived;
    //Shipping Method
    data["shippingID"] = ShippingID;
    data["method_name"] = MethodName;
    data["shipping_price"] = ShippingPrice;
    data["currencyID"] = currencyID;
    data["currency_code"] = CurrencyCode;
    data["is_letter"] = isLetter;
    data["is_insured"] = isInsured;

    data["tracking_number"] = trackingNumber;
    data["is_presale"] = isPresale;
    data["article_count"] = articleCount;

    //evaluation
    data["evaluation_grade"] = evaluationGrade;
    data["item_description_evaluation"] = itemDescription;
    data["packaging_evaluation"] = packaging;
    data["comment_evaluation"] = comment;

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

class Article{
  int articleID = 0;
  int productID = 0;
  int languageID = 0;
  String languageName = "";
  double pricePer = 0.0;
  int currencyID = 0;
  String currencyCode = "";
  int articleCount = 0;
  
  //product
  int gameID = 0;
  String enName = "";
  String locName = "";
  String expansion = "";
  String code = "";
  int expIcon = 0;
  String rarity = "";
  
  String condition = "";
  bool isSigned = false;
  bool isFirstED = false;
  bool isAltered = false;
  
  Article(XmlElement xml) {
    articleID = int.parse(xml.findAllElements("idArticle").single.text);

  }

  Map<String, dynamic> getMap() {
    Map<String, dynamic> data = Map();

    data["article_ID"] = articleID;

    return data;
  }
}