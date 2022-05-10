import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:next_level_admin/APIs/CardMarket/Config.dart';
import 'package:next_level_admin/APIs/RoyalMail/Config.dart';
import 'package:next_level_admin/Shared/Libraries/Database_Library.dart';

class APIHelper {

  String generateSignature(String requestMethod, Uri url, Map<String, String> data, String ConsumerKeySecret, String TokenSecret) {
    var sigString = toQueryString(data);
    var fullSigData = "$requestMethod&${encode(url.toString())}&${encode(sigString)}";
    var bytes = utf8.encode("${ConsumerKeySecret}&${TokenSecret}");
    Hmac _sigHasher = new Hmac(sha1, bytes);

    return base64.encode(hash(fullSigData, _sigHasher));
  }

  String toQueryString(Map<String, String> data) {
    var items = data.keys.map((k) => "$k=${encode(data[k]!)}").toList();
    items.sort();

    return items.join("&");
  }

  List<int> hash(String data, Hmac sigHasher) => sigHasher.convert(data.codeUnits).bytes;

  String encode(String data) => percent.encode(data.codeUnits);

  Future getAPIData() async
  {
    if(!CardMarket_API.instance.hasData) {
      APIConfigs.doc("CardMarket").get().then((value) => CardMarket_API.setup(value));
    }
    if(!RoyalMail_API.instance.hasData) {
      APIConfigs.doc("RoyalMail").get().then((value) => RoyalMail_API.setup(value));
    }
  }
}