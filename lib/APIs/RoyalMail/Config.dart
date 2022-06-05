import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: camel_case_types
class RoyalMail_API {
  static RoyalMail_API? _instance = RoyalMail_API(bearerToken: "");

  static RoyalMail_API get instance => _instance!;

  static set instance(RoyalMail_API? instance) {
    _instance = instance;
  }

  RoyalMail_API({required this.bearerToken});

  String bearerToken;

  static String getBearerToken() => _instance!.bearerToken;

  static Future<void> getConfigData() async
  {
    if(!hasData())
      {
        print("RM Load");
        var data = await FirebaseFirestore.instance.collection("API Configs").doc("RoyalMail").get().then((value) => RoyalMail_API.fromFirestore(value.data()!));
        _instance = data;
      }
  }

  factory RoyalMail_API.fromFirestore(Map data) => RoyalMail_API(bearerToken: data["BearerToken"] ?? "");


  Map<String, dynamic> toMap()  => {
  "BearerToken": bearerToken
  };

  static bool hasData() => getBearerToken().isNotEmpty;
}
