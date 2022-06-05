part of 'package:next_level_admin/APIs/CardMarket/CardMarket_Library.dart';



class CardMarket {


  Future uploadCardToDatabase(Map<String, dynamic> data) async => FirebaseFirestore.instance.collection(YuGiOhCardDatabase).doc().set(data);

  static Map<String, String> generateOAuthData() => {
    "oauth_consumer_key" : CardMarket_API.getConsumerKey(),
    "oauth_signature_method" : "HMAC-SHA1",
    "oauth_timestamp" : (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString(),
    "oauth_nonce" : Nonce.generate(),
    "oauth_token" : CardMarket_API.getAccessToken(),
    "oauth_version" : "1.0",
  };

  static String getOAuthSignature(String url) => APIHelper().generateSignature("GET", Uri.parse(url), generateOAuthData(), CardMarket_API.getConsumerKeySecret(), CardMarket_API.getTokenSecret());

  static String getOAuth(String url) =>
      'OAuth realm="$url",' +
      'oauth_consumer_key="${CardMarket_API.getConsumerKey()}",' +
      'oauth_token="${CardMarket_API.getAccessToken()}",' +
      'oauth_token_secret="${CardMarket_API.getTokenSecret()}",' +
      'oauth_signature_method="HMAC-SHA1",' +
      'oauth_timestamp="${DateTime.now().millisecondsSinceEpoch ~/ 1000}",' +
      'oauth_nonce="${Nonce.generate()}",' +
      'oauth_version="1.0",' +
      'oauth_signature="${getOAuthSignature(url)}"';

}