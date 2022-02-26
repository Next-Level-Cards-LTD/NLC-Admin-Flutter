import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:flutter/material.dart';
import 'package:next_level_admin/Pages/Authentication/Login.dart';
import 'package:next_level_admin/Wrappers/DashboardWrapper.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Auth.User? currentUser = Provider.of<Auth.User?>(context);

    return currentUser != null ? DashboardWrapper() : Login();
  }
}