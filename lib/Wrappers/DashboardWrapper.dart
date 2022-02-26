import 'package:flutter/material.dart';
import 'package:next_level_admin/Data%20Models/User.dart';
import 'package:next_level_admin/Services/Database.dart';
import 'package:next_level_admin/Shared/Widgets/Widget_Loading.dart';

class DashboardWrapper extends StatefulWidget {
  @override
  _DashboardWrapperState createState() => _DashboardWrapperState();
}

class _DashboardWrapperState extends State<DashboardWrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: Database().user,
        builder: (context, snapshot) {
          if(!snapshot.hasData)
          {
            return Loading(text: 'Loading Profile...');
          }
          return Scaffold(
            body: Row(),
          );
        }
    );
  }
}