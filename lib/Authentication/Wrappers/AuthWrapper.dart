import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:flutter/material.dart';
import 'package:next_level_admin/Authentication/Pages/Login.dart';
import 'package:next_level_admin/Dashboard/Wrappers/DashboardWrapper.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class AuthWrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Auth.User? currentUser = Provider.of<Auth.User?>(context);

    if(currentUser != null)
      {
        Routemaster.of(context).push("dashboard");
      }
    
    return Padding(padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0), child: currentUser != null ? DashboardWrapper(selectedIndex: 0) : Login());
  }
}