import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:next_level_admin/Dashboard/Wrappers/DashboardWrapper.dart';
import 'package:next_level_admin/main.dart';

const String HomeRoute = "/home";
const String OrdersRoute = "/orders";
const String OrderDetailsRoute = "/order";

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static Handler _handler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) => MyHomePage());

  static Handler _DashboardHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) => DashboardWrapper(selectedIndex: 0));
  static Handler _OrdersHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) => DashboardWrapper(selectedIndex: 3));
  static Handler _OrderDetailsHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) => DashboardWrapper(selectedIndex: 3, id: params['id'][0]));

  static void setupRouter() {
    router.define(
      '/',
      handler: _handler
    );
    router.define(
        '/dashboard',
        handler: _DashboardHandler
    );
    router.define(
        '/orders',
        handler: _OrdersHandler
    );
    router.define(
        '/order/:id',
        handler: _OrderDetailsHandler
    );
  }

}