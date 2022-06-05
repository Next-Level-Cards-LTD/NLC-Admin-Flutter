import 'package:flutter/material.dart';
import 'package:next_level_admin/APIs/CardMarket/Config.dart';
import 'package:next_level_admin/APIs/RoyalMail/Config.dart';

// ignore: must_be_immutable
class DashboardWrapper extends StatefulWidget {

  static const String route = "dashboard";

  int selectedIndex = 0;
  int? id;

  DashboardWrapper({required this.selectedIndex, this.id});

  @override
  _DashboardWrapperState createState() => _DashboardWrapperState();
}

class _DashboardWrapperState extends State<DashboardWrapper> {

  int _selectedIndex = 0;
  bool isSideBarExtended = false;


  @override
  initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    loadData();
  }

  @override
  Widget build(BuildContext context) {

          return Scaffold(
            body: Row(
              children: [
                NavigationRail(selectedIndex: _selectedIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                    });
                  },
                  labelType: NavigationRailLabelType.none,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.dashboard_outlined),
                      selectedIcon: Icon(Icons.dashboard),
                      label: Text('Dashboard',),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.all_inbox_outlined),
                      selectedIcon: Icon(Icons.all_inbox),
                      label: Text('Stock'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.archive_outlined),
                      selectedIcon: Icon(Icons.archive),
                      label: Text('Resource'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.border_color_outlined),
                      selectedIcon: Icon(Icons.border_color),
                      label: Text('Order'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.settings_outlined),
                      selectedIcon: Icon(Icons.settings),
                      label: Text('System Settings'),
                    ),
                  ],
                  extended: isSideBarExtended,
                  trailing: Align(alignment: isSideBarExtended ? Alignment.bottomRight : Alignment.bottomCenter, child: IconButton(onPressed: () => toggleSideBar(), icon: Icon(isSideBarExtended ? Icons.arrow_back_ios : Icons.arrow_forward_ios))),
                ),
              ],
            ),
          );
  }

  void toggleSideBar() {
    setState(() {
      isSideBarExtended = !isSideBarExtended;
    });
  }


  Future<void> loadData() async {
    CardMarket_API.getConfigData();
    RoyalMail_API.getConfigData();
  }
}