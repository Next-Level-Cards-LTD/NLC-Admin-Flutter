import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:flutter/material.dart';
import 'package:next_level_admin/Pages/Authentication/Login.dart';
import 'package:next_level_admin/Wrappers/DashboardWrapper.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Auth.User? currentUser = Provider.of<Auth.User?>(context);

    return Padding(padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0), child: currentUser != null ? DashboardWrapper() : Login());
  }
}