import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:flutter/material.dart';
import 'package:next_level_admin/APIs/APIHelper.dart';
import 'package:next_level_admin/Constants/Routes.dart';
import 'package:next_level_admin/Shared/Widgets/Widget_Loading.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class AuthWrapper extends StatefulWidget {

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    final Auth.User? currentUser = Provider.of<Auth.User?>(context);

    print(currentUser);
    if(currentUser != null)
      {
        APIHelper().loadData();
        print("Logged in");
        //jump();
        //Routemaster.of(context).push("/$systemSettingsRoute");
        return Loading(text: "text");
      }
    return Loading(text: "text2");
  }

Future<void> jump()
async {
    setState(() {
      Routemaster.of(context).push("/$systemSettingsRoute");
    });

}
}