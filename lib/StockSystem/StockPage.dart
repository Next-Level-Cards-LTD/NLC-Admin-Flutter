import 'package:flutter/material.dart';
import 'package:next_level_admin/Shared/Widgets/PageTemplate.dart';

class StockPage extends StatefulWidget {
  const StockPage({Key? key}) : super(key: key);

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  @override
  Widget build(BuildContext context) {
    return PageTemplate(child: Container(child: Text("Stock")));
  }
}
