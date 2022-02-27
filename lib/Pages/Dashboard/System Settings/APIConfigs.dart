import 'package:flutter/material.dart';
import 'package:next_level_admin/APIs/Configs/CardMarket.dart';
import 'package:next_level_admin/APIs/Configs/RoyalMail.dart';
import 'package:next_level_admin/Services/Database.dart';
import 'package:next_level_admin/Shared/Widgets/Widget_Loading.dart';
import 'package:provider/provider.dart';

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
        Text("${CardMarket_API.instance.ConsumerKey}"),
        Text("${CardMarket_API.instance.ConsumerKeySecret}"),
        Text("${CardMarket_API.instance.AccessToken}"),
        Text("${CardMarket_API.instance.TokenSecret}"),
        Text(""),
        Text("Royal Mail"),
        Text("${RoyalMail_API.instance.BearerToken}")
      ],
    );
  }
}
