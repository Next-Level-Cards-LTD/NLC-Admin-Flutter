import 'package:flutter/material.dart';
import 'package:next_level_admin/APIs/CardMarket/Requests/CardMarket_Orders.dart';

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
        ElevatedButton(onPressed: () => CardMarket_Orders().getOrder(1069499244), child: Text("Get Orders"))
      ],
    );
  }
}
