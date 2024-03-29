import 'package:flutter/material.dart';
import 'package:next_level_admin/Data%20Models/User.dart';
import 'package:next_level_admin/Pages/Dashboard/System%20Settings/SystemSettings.dart';
import 'package:next_level_admin/Services/Database.dart';
import 'package:next_level_admin/Shared/Values/Constants_Enums.dart';
import 'package:next_level_admin/Shared/Widgets/Widget_Loading.dart';

class DashboardWrapper extends StatefulWidget {
  @override
  _DashboardWrapperState createState() => _DashboardWrapperState();
}

class _DashboardWrapperState extends State<DashboardWrapper> {

  int _selectedIndex = 4;
  bool isSideBarExtended = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: Database().user,
        builder: (context, snapshot) {

          if(!snapshot.hasData)
          {
            return Loading(text: 'Loading Profile...');
          }

          LoadData();

          return Scaffold(
            body: Row(
              children: [
                NavigationRail(selectedIndex: _selectedIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;
                      SetActiveWidget(DashboardPage.values[_selectedIndex]);
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
                  trailing: Align(alignment: isSideBarExtended ? Alignment.bottomRight : Alignment.bottomCenter, child: IconButton(onPressed: () => ToggleSideBar(), icon: Icon(isSideBarExtended ? Icons.arrow_back_ios : Icons.arrow_forward_ios))),
                  //minExtendedWidth: 10,
                ),
                SetActiveWidget(DashboardPage.values[_selectedIndex])
              ],
            ),
          );
        }
    );
  }

  void ToggleSideBar() {
    setState(() {
      isSideBarExtended = !isSideBarExtended;
    });
  }

  Widget SetActiveWidget(DashboardPage dp)
  {
    switch(dp)
    {
      case DashboardPage.Dashboard: //Dashboard
        return Text("Dashboard");
      case DashboardPage.Stock: //Stock Management
        return Text("Stock");
      case DashboardPage.Resource: //Stock Management
        return Text("Resource");
      case DashboardPage.Order: //Order Management
        return Text("Order");
      case DashboardPage.Settings: //System Settings
        return SystemSettings();
      default:
        return Row();
    }
  }

  void LoadData()
  {
    Database().getAPIData();
  }
}