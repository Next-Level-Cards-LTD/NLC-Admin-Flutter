import 'package:flutter/material.dart';
import 'package:next_level_admin/Constants/Routes.dart';
import 'package:next_level_admin/Shared/Widgets/NavigationBar/NavigationItem.dart';
import 'package:next_level_admin/Shared/Widgets/Widget_ValueListeners.dart';
import 'package:routemaster/routemaster.dart';

class SideNavigationBar extends StatefulWidget {
  const SideNavigationBar({Key? key}) : super(key: key);

  @override
  State<SideNavigationBar> createState() => _SideNavigationBarState();
}

class _SideNavigationBarState extends State<SideNavigationBar> {

  bool isSideBarExtended = false;

  List<NavigationItem> ni = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    buildNavigationItemsList();
  }

  @override
  Widget build(BuildContext context) {


    return NavigationRail(selectedIndex: SelectedPageIndex.selectedIndex.value,
      onDestinationSelected: (int index) {
        setState(() {
          SelectedPageIndex.selectedIndex.value = index;
          Routemaster.of(context).push("/${ni[index].route}");
        });
      },
      labelType: NavigationRailLabelType.none,
      destinations: ni,
      extended: isSideBarExtended,
      trailing: Align(alignment: isSideBarExtended ? Alignment.bottomRight : Alignment.bottomCenter, child: IconButton(onPressed: () => toggleSideBar(), icon: Icon(isSideBarExtended ? Icons.arrow_back_ios : Icons.arrow_forward_ios))),
    );
  }

  void toggleSideBar() {
    setState(() {
      isSideBarExtended = !isSideBarExtended;
    });
  }

  void buildNavigationItemsList()
  {
    ni.add(NavigationItem(route: dashboardRoute, icon: Icon(Icons.dashboard_outlined), label: Text('Dashboard',), selectedIcon: Icon(Icons.dashboard)));
    ni.add(NavigationItem(route: stockRoute, icon: Icon(Icons.all_inbox_outlined), label: Text('Stock',), selectedIcon: Icon(Icons.all_inbox)));
    ni.add(NavigationItem(route: resourcesRoute, icon: Icon(Icons.archive_outlined), label: Text('Resource',), selectedIcon: Icon(Icons.archive)));
    ni.add(NavigationItem(route: ordersRoute, icon: Icon(Icons.border_color_outlined), label: Text('Order',), selectedIcon: Icon(Icons.border_color)));
    ni.add(NavigationItem(route: systemSettingsRoute, icon: Icon(Icons.settings_outlined), label: Text('System Settings',), selectedIcon: Icon(Icons.settings)));
  }
}
