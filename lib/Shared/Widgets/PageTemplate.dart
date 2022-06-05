import 'package:flutter/material.dart';
import 'package:next_level_admin/Shared/Widgets/NavigationBar/Widget_SideNavigationBar.dart';

class PageTemplate extends StatefulWidget {
  const PageTemplate({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<PageTemplate> createState() => _PageTemplateState();
}

class _PageTemplateState extends State<PageTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideNavigationBar(),
          widget.child
        ],
      ),
    );
  }
}
