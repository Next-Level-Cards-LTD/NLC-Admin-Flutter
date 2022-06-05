import 'package:flutter/material.dart';
import 'package:next_level_admin/Constants/Values/Constants_Enums.dart';
import 'package:next_level_admin/SystemSettings/Pages/APIConfigs.dart';
import 'package:next_level_admin/SystemSettings/Pages/General.dart';
import 'package:next_level_admin/SystemSettings/Pages/Themes.dart';


class SystemSettingsWrapper extends StatelessWidget {

  int index = 0;

  SystemSettingsWrapper({required this.index});



  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetSelectedWidget(SystemSettingsPage.values[index])
    );
  }

  Widget GetSelectedWidget(SystemSettingsPage ssp)
  {
    switch(ssp)
    {
      case SystemSettingsPage.General:
        return General();
      case SystemSettingsPage.Themes:
        return Themes();
      case SystemSettingsPage.APIConfigs:
        return APIConfigs();
    }
  }
}
