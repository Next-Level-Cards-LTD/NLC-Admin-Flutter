import 'package:flutter/material.dart';
import 'package:next_level_admin/APIs/CardMarket/Types/OrderListener.dart';
import 'package:next_level_admin/APIs/CardMarket/CardMarket_Library.dart' as CM;
import 'package:next_level_admin/Dashboard/OrderSystem/OrderSystem.dart';
import 'package:next_level_admin/Shared/Widgets/Widget_Loading.dart';


class OrderDisplay extends StatefulWidget {

  String orderID;

  OrderDisplay({required this.orderID});

  @override
  _OrderDisplayState createState() => _OrderDisplayState();
}

class _OrderDisplayState extends State<OrderDisplay> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CM.Order>(
      stream: OrderSystem().order,
      builder: (context, snapshot) {

        if(!snapshot.hasData)
          {
            Loading(text: "Getting Order");
          }

        CM.Order? order = snapshot.data;

        return Container(child: Column(
          children: [
            ElevatedButton(onPressed: () => OrderListener.clearActiveOrderUID(), child: Text("Back")),
            Text(widget.orderID),
          ],
        ));
      }
    );
  }
}
