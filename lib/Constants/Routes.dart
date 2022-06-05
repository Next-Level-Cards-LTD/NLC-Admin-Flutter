import 'package:flutter/material.dart';
import 'package:next_level_admin/Authentication/Pages/Login.dart';
import 'package:next_level_admin/Dashboard/DashboardPage.dart';
import 'package:next_level_admin/OrderSystem/Pages/OrderSystem.dart';
import 'package:next_level_admin/ResourcesSystem/ResourcesPage.dart';
import 'package:next_level_admin/StockSystem/StockPage.dart';
import 'package:next_level_admin/SystemSettings/Pages/SystemSettings.dart';
import 'package:routemaster/routemaster.dart';


//Route Values
const String dashboardRoute = "dashboard";
const String stockRoute = "stock";
const String resourcesRoute = "resources";
const String ordersRoute = "orders";
const String systemSettingsRoute = "systemsettings";
const String loginRoute = "login";


//Logged in Routes - These are only available while the user is logged in
final loggedInRoutes = RouteMap(
  routes: {
    //Change the first route to Dashboard once set up properly
    '/': (context) => MaterialPage(child: DashboardPage()),
    "/$dashboardRoute" : (context) => MaterialPage(child: DashboardPage()),
    "/$stockRoute" : (context) => MaterialPage(child: StockPage()),
    "/$resourcesRoute" : (context) => MaterialPage(child: ResourcesPage()),
    "/$ordersRoute" : (context) => MaterialPage(child: OrderSystemPage()),
    "/$systemSettingsRoute" : (context) => MaterialPage(child: SystemSettings()),
  },
);

//Logged out Routes - These are only available while the user is NOT logged in
final loggedOutRoutes = RouteMap(
  onUnknownRoute: (context) => Redirect('/'),
  routes: {
    '/': (context) => MaterialPage(child: Login()),
  },
);