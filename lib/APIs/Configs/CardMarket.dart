import 'package:cloud_firestore/cloud_firestore.dart';

class CardMarket_API {
  static CardMarket_API? _instance = CardMarket_API._();

  static CardMarket_API get instance => _instance!;

  static set instance(CardMarket_API? instance) {
    _instance = instance;
  }

  CardMarket_API._();

  CardMarket_API.setup(DocumentSnapshot data)
  {
    ConsumerKey = data["ConsumerKey"];
    ConsumerKeySecret= data["ConsumerKeySecret"];
    AccessToken = data["AccessToken"];
    TokenSecret = data["TokenSecret"];
    instance = this;
  }


  CardMarket_API_Data? data;

  String? _ConsumerKey;

  String? get ConsumerKey => _ConsumerKey!;

  set ConsumerKey(String? ConsumerKey) {
    _ConsumerKey = ConsumerKey;
  }

  String? _ConsumerKeySecret;

  String? get ConsumerKeySecret => _ConsumerKeySecret;

  set ConsumerKeySecret(String? ConsumerKeySecret) {
    _ConsumerKeySecret = ConsumerKeySecret;
  }

  String? _AccessToken;

  String? get AccessToken => _AccessToken;

  set AccessToken(String? AccessToken) {
    _AccessToken = AccessToken;
  }

  String? _TokenSecret;

  String? get TokenSecret => _TokenSecret;

  set TokenSecret(String? TokenSecret) {
    _TokenSecret = TokenSecret;
  }
}

class CardMarket_API_Data
{
  String? ConsumerKey;
  String? ConsumerKeySecret;
  String? AccessToken;
  String? TokenSecret;

  CardMarket_API_Data(this.ConsumerKey, this.ConsumerKeySecret, this.AccessToken, this.TokenSecret);

  CardMarket_API_Data.documentSnapshot(DocumentSnapshot data)
  {
    print(data["ConsumerKey"]);

    ConsumerKey = data["ConsumerKey"];
    ConsumerKeySecret= data["ConsumerKeySecret"];
    AccessToken = data["AccessToken"];
    TokenSecret = data["TokenSecret"];

    //CardMarket_API.instance.setup("");

    CardMarket_API.instance.ConsumerKey = data["ConsumerKey"];

    CardMarket_API.instance = CardMarket_API.setup(data);
  }
}