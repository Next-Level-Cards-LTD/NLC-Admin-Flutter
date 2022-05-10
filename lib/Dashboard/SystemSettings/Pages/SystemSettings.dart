import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:next_level_admin/Dashboard/SystemSettings/Wrappers/SystemSettingsWrapper.dart';

class SystemSettings extends StatefulWidget {
  const SystemSettings({Key? key}) : super(key: key);

  static const String route = "systemsettings";

  @override
  _SystemSettingsState createState() => _SystemSettingsState();
}

class _SystemSettingsState extends State<SystemSettings> {

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("System Settings"),
          Row(
            children: [
              ElevatedButton(onPressed: () => setSelectedIndex(0), child: Text("General")),
              ElevatedButton(onPressed: () => setSelectedIndex(1), child: Text("Theme")),
              ElevatedButton(onPressed: () => setSelectedIndex(2), child: Text("API Configs")),
            ],
          ),
          SystemSettingsWrapper(index: _selectedIndex,),
        ],
      ),
    );
  }

  void setSelectedIndex(int index)
  {
    setState(() {
      _selectedIndex = index;
    });
  }
}
