part of 'package:next_level_admin/APIs/CardMarket/CardMarket_Library.dart';



class CardMarket {
  Future UploadCardToDatabase(Map<String, dynamic> Data) async
  {
    return YuGiOhCardDatabase.doc().set(Data);
  }

  Stream<CardMarket_API> get CardMarketAPI => APIConfigs.doc("CardMarket").snapshots().map(_cardMarketAPIFromSnapshots);

  CardMarket_API _cardMarketAPIFromSnapshots(DocumentSnapshot snapshot) => CardMarket_API.setup(snapshot);

  static String nonce = Nonce.generate();
  static int TimeStamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

  static Map<String, String> GenerateOAuthData(String nonce, String TimeStamp) => {
    "oauth_consumer_key" : CardMarket_API.instance.ConsumerKey!,
    "oauth_signature_method" : "HMAC-SHA1",
    "oauth_timestamp" : (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString(),
    "oauth_nonce" : nonce,
    "oauth_token" : CardMarket_API.instance.AccessToken!,
    "oauth_version" : "1.0",
  };

  static String getOAuthSignature(String url) => APIHelper().generateSignature("GET", Uri.parse(url), GenerateOAuthData(nonce, TimeStamp.toString()), CardMarket_API.instance.ConsumerKeySecret!, CardMarket_API.instance.TokenSecret!);

  static String getOAuth(String url) =>
      'OAuth realm="$url",' +
      'oauth_consumer_key="${CardMarket_API.instance.ConsumerKey!}",' +
      'oauth_token="${CardMarket_API.instance.AccessToken!}",' +
      'oauth_token_secret="${CardMarket_API.instance.TokenSecret!}",' +
      'oauth_signature_method="HMAC-SHA1",' +
      'oauth_timestamp="$TimeStamp",' +
      'oauth_nonce="$nonce",' +
      'oauth_version="1.0",' +
      'oauth_signature="${getOAuthSignature(url)}"';

}