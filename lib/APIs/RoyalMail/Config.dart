import 'package:cloud_firestore/cloud_firestore.dart';

class RoyalMail_API {
  static RoyalMail_API? _instance = RoyalMail_API._();

  static RoyalMail_API get instance => _instance!;

  static set instance(RoyalMail_API? instance) {
    _instance = instance;
  }

  RoyalMail_API._();

  RoyalMail_API.setup(DocumentSnapshot data)
  {
    print("RM Load");
    BearerToken = data["BearerToken"];
    hasData = true;
    instance = this;
  }

  bool _hasData = false;

  bool get hasData => _hasData;

  set hasData(bool hasData) {
    _hasData = hasData;
  }

  String? _BearerToken;

  String? get BearerToken => _BearerToken!;

  set BearerToken(String? BearerToken) {
    _BearerToken = BearerToken;
  }
}
