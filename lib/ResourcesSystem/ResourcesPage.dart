import 'package:flutter/material.dart';
import 'package:next_level_admin/Shared/Widgets/PageTemplate.dart';

class ResourcesPage extends StatefulWidget {
  const ResourcesPage({Key? key}) : super(key: key);

  @override
  State<ResourcesPage> createState() => _ResourcesPageState();
}

class _ResourcesPageState extends State<ResourcesPage> {
  @override
  Widget build(BuildContext context) {
    return PageTemplate(child: Container(child: Text("Resources")));
  }
}
