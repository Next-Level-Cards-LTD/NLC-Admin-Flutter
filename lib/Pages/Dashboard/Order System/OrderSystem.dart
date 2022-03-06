import 'package:flutter/material.dart';
import 'package:next_level_admin/APIs/CardMarket/CardMarket_Orders.dart';

class OrderSystem extends StatefulWidget {
  const OrderSystem({Key? key}) : super(key: key);

  @override
  _OrderSystemState createState() => _OrderSystemState();
}

class _OrderSystemState extends State<OrderSystem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Order System"),
        ElevatedButton(onPressed: () => CardMarket_Orders().GetOrder(1071241409), child: Text("Get Orders"))
      ],
    );
  }
}
