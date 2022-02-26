import 'package:flutter/material.dart';
import 'package:next_level_admin/Data%20Models/User.dart';
import 'package:next_level_admin/Services/Database.dart';
import 'package:next_level_admin/Shared/Widgets/Widget_Loading.dart';

class DashboardWrapper extends StatefulWidget {
  @override
  _DashboardWrapperState createState() => _DashboardWrapperState();
}

class _DashboardWrapperState extends State<DashboardWrapper> {

  int _selectedIndex = 0;
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
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(selectedIndex: _selectedIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  labelType: NavigationRailLabelType.none,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite_border),
                      selectedIcon: Icon(Icons.favorite),
                      label: Text('First',),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.bookmark_border),
                      selectedIcon: Icon(Icons.book),
                      label: Text('Second'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.star_border),
                      selectedIcon: Icon(Icons.star),
                      label: Text('Third'),
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
}