import 'package:next_level_admin/APIs/Configs/CardMarket.dart';
import 'package:nonce/nonce.dart';

class CardMarket {
  Map<String, String> GenerateOAuthData(String nonce, String TimeStamp) {
    Map<String, String> data = Map();
    data["oauth_consumer_key"] = CardMarket_API.instance.ConsumerKey!;
    data["oauth_signature_method"] = "HMAC-SHA1";
    data["oauth_timestamp"] = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    data["oauth_nonce"] = nonce;
    data["oauth_token"] = CardMarket_API.instance.AccessToken!;
    data["oauth_version"] = "1.0";

    return data;
  }
}