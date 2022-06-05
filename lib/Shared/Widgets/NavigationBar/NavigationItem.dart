import 'package:flutter/material.dart';

class NavigationItem extends NavigationRailDestination
{
  NavigationItem({required Widget icon, required Widget label, required Icon selectedIcon, required this.route}) : super(icon: icon, label: label);

  String route;
}