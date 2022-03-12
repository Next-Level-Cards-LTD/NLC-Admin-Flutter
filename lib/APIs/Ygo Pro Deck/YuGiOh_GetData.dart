import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

class YuGiOh_GetData{

  String baseUrl = "https://db.ygoprodeck.com/api/v7/cardinfo.php?name=Dark Magician";

  GetData()
  async {
    final response = await http.get(Uri.parse(baseUrl));

    if(response.statusCode == 200)
    {
      Map<String, dynamic> source = jsonDecode(response.body);

      List<dynamic> Data = source["data"];
      SendToFirebase(source);
    }
  }

  Future SendToFirebase(Map<String, dynamic> Data) async
  {
    //List<dynamic> l = Data["data"];
    List<dynamic> info = Data["data"];
    log(info[0]);
    //Database().UploadCardToDatabase({"ID": "Test"});
  }
}