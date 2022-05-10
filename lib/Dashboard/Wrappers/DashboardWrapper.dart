import 'package:flutter/material.dart';
import 'package:next_level_admin/Authentication/Types/User.dart';
import 'package:next_level_admin/Constants/Values/Constants_Enums.dart';
import 'package:next_level_admin/Dashboard/OrderSystem/Pages/OrderSystem.dart';
import 'package:next_level_admin/Dashboard/SystemSettings/Pages/SystemSettings.dart';
import 'package:next_level_admin/Helpers/APIHelper.dart';
import 'package:next_level_admin/Shared/Libraries/Database_Library.dart';
import 'package:next_level_admin/Shared/Widgets/Widget_Loading.dart';
import 'package:routemaster/routemaster.dart';

class DashboardWrapper extends StatefulWidget {

  static const String route = "dashboard";

  int selectedIndex = 0;
  Map<String, dynamic>? params;
  int? id;

  DashboardWrapper({required this.selectedIndex, this.id});

  @override
  _DashboardWrapperState createState() => _DashboardWrapperState();
}

class _DashboardWrapperState extends State<DashboardWrapper> {

  int _selectedIndex = 3;
  bool isSideBarExtended = false;


  @override
  void initState() {
    _selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: Authentication().user,
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
                      Routemaster.of(context).replace("/${getNavigationRoute(DashboardPage.values[_selectedIndex])}");
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
                //Navigator.of(context).pushNamed("/Dashboard")
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
    print(widget.params);
    switch(dp)
    {
      case DashboardPage.Dashboard: //Dashboard
        return Text("Dashboard");
      case DashboardPage.Stock: //Stock Management
        return Text("Stock");
      case DashboardPage.Resource: //Stock Management
        return Text("Resource");
      case DashboardPage.Order: //Order Management
        return OrderSystemPage(orderID: widget.id,);
      case DashboardPage.Settings: //System Settings
        return SystemSettings();
      default:
        return Row();
    }
  }

  String getNavigationRoute(DashboardPage dp)
  {

    //print(widget.params?["orderID"].toString());
    //String orderId = widget.params?["orderID"];
    switch(dp)
    {
      case DashboardPage.Dashboard: //Dashboard
        return "dashboard";
      case DashboardPage.Stock: //Stock Management
        return "stock";
      case DashboardPage.Resource: //Stock Management
        return "resource";
      case DashboardPage.Order: //Order Management
        return "orders";
      case DashboardPage.Settings: //System Settings
        return SystemSettings.route;
      default:
        return "dashboard";
    }
  }

  void LoadData()
  {
    APIHelper().getAPIData();
  }
}