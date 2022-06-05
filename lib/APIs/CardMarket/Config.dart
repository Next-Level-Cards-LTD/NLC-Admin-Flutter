import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: camel_case_types
class CardMarket_API {
  static CardMarket_API? _instance = CardMarket_API(consumerKey: "", consumerKeySecret: "", accessToken: "", tokenSecret:"");

  static CardMarket_API get instance => _instance!;

  static set instance(CardMarket_API? instance) {
    _instance = instance;
  }

  CardMarket_API({required this.tokenSecret, required this.accessToken, required this.consumerKey, required this.consumerKeySecret});


  factory CardMarket_API.fromFirestore(Map data) => CardMarket_API(
        consumerKey: data["ConsumerKey"] ?? "t",
        consumerKeySecret: data["ConsumerKeySecret"] ?? "",
        accessToken: data["AccessToken"] ?? "",
        tokenSecret: data["TokenSecret"] ?? "");


  Map<String, dynamic> toMap()  => {
    "ConsumerKey" : consumerKey,
    "ConsumerKeySecret" : consumerKeySecret,
    "AccessToken": accessToken,
    "TokenSecret": tokenSecret,
  };

  String tokenSecret;
  String accessToken;
  String consumerKeySecret;
  String consumerKey;


  static String getTokenSecret() => _instance!.tokenSecret;

  static String getAccessToken() => _instance!.accessToken;

  static String getConsumerKey() => _instance!.consumerKey;

  static String getConsumerKeySecret() => _instance!.consumerKeySecret;

  static bool hasData() => getTokenSecret().isNotEmpty && getAccessToken().isNotEmpty && getConsumerKey().isNotEmpty && getConsumerKeySecret().isNotEmpty;


  static Future<void> getConfigData() async
  {
    if(!hasData())
      {
        print("CM Load");
        var data = await FirebaseFirestore.instance.collection("API Configs").doc("CardMarket").get().then((value) => CardMarket_API.fromFirestore(value.data()!));
        _instance = data;
      }
  }
}