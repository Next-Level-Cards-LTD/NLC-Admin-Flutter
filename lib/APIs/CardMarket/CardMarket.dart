part of 'package:next_level_admin/APIs/CardMarket/CardMarket_Library.dart';



class CardMarket {


  Future UploadCardToDatabase(Map<String, dynamic> data) async => FirebaseFirestore.instance.collection(FirestoreDB.instance.YuGiOhCardDatabase).doc().set(data);


  Stream<CardMarket_API> get CardMarketAPI => FirebaseFirestore.instance.collection(FirestoreDB.instance.APIConfigsCollection).doc("CardMarket").snapshots().map(_cardMarketAPIFromSnapshots);


  CardMarket_API _cardMarketAPIFromSnapshots(DocumentSnapshot snapshot) => CardMarket_API.setup(snapshot);

  static Map<String, String> GenerateOAuthData() => {
    "oauth_consumer_key" : CardMarket_API.instance.ConsumerKey!,
    "oauth_signature_method" : "HMAC-SHA1",
    "oauth_timestamp" : (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString(),
    "oauth_nonce" : Nonce.generate(),
    "oauth_token" : CardMarket_API.instance.AccessToken!,
    "oauth_version" : "1.0",
  };

  static String getOAuthSignature(String url) => APIHelper().generateSignature("GET", Uri.parse(url), GenerateOAuthData(), CardMarket_API.instance.ConsumerKeySecret!, CardMarket_API.instance.TokenSecret!);

  static String getOAuth(String url) =>
      'OAuth realm="$url",' +
      'oauth_consumer_key="${CardMarket_API.instance.ConsumerKey!}",' +
      'oauth_token="${CardMarket_API.instance.AccessToken!}",' +
      'oauth_token_secret="${CardMarket_API.instance.TokenSecret!}",' +
      'oauth_signature_method="HMAC-SHA1",' +
      'oauth_timestamp="${DateTime.now().millisecondsSinceEpoch ~/ 1000}",' +
      'oauth_nonce="${Nonce.generate()}",' +
      'oauth_version="1.0",' +
      'oauth_signature="${getOAuthSignature(url)}"';

}