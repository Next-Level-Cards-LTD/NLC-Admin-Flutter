import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:next_level_admin/APIs/CardMarket/Config.dart';
import 'package:next_level_admin/APIs/RoyalMail/Config.dart';

class APIHelper {

  String generateSignature(String requestMethod, Uri url, Map<String, String> data, String consumerKeySecret, String tokenSecret) {
    var sigString = toQueryString(data);
    var fullSigData = "$requestMethod&${encode(url.toString())}&${encode(sigString)}";
    var bytes = utf8.encode("$consumerKeySecret&$tokenSecret");
    Hmac _sigHash = new Hmac(sha1, bytes);

    return base64.encode(hash(fullSigData, _sigHash));
  }

  String toQueryString(Map<String, String> data) {
    var items = data.keys.map((k) => "$k=${encode(data[k]!)}").toList();
    items.sort();

    return items.join("&");
  }

  List<int> hash(String data, Hmac sigHash) => sigHash.convert(data.codeUnits).bytes;

  String encode(String data) => percent.encode(data.codeUnits);

  loadData()
  {
    CardMarket_API.getConfigData();
    RoyalMail_API.getConfigData();
  }
}