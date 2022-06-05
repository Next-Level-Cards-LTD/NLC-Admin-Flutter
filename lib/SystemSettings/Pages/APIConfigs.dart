import 'package:flutter/material.dart';
import 'package:next_level_admin/APIs/RoyalMail/Config.dart';
import 'package:next_level_admin/APIs/CardMarket/Config.dart';

class APIConfigs extends StatefulWidget {
  const APIConfigs({Key? key}) : super(key: key);

  @override
  _GeneralState createState() => _GeneralState();
}

class _GeneralState extends State<APIConfigs> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("CardMarket"),
        Text(CardMarket_API.getConsumerKey()),
        Text(CardMarket_API.getConsumerKeySecret()),
        Text(CardMarket_API.getAccessToken()),
        Text(CardMarket_API.getTokenSecret()),
        Text(""),
        Text("Royal Mail"),
        Text("${RoyalMail_API.getBearerToken()}")
      ],
    );
  }
}
