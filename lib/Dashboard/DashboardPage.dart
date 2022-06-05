import 'package:flutter/material.dart';
import 'package:next_level_admin/APIs/APIHelper.dart';
import 'package:next_level_admin/Shared/Widgets/PageTemplate.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return PageTemplate(child: Container(child: Text("Dashboard")));
  }

  @override
  void initState() {
    super.initState();
    APIHelper().loadData();
  }
}
