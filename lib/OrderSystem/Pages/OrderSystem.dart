import 'package:flutter/material.dart';
import 'package:next_level_admin/APIs/CardMarket/Requests/CardMarket_Orders.dart';
import 'package:next_level_admin/APIs/CardMarket/Types/OrderListener.dart';
import 'package:next_level_admin/OrderSystem/OrderSystem.dart';
import 'package:next_level_admin/OrderSystem/Pages/OrderDisplay.dart';
import 'package:next_level_admin/OrderSystem/Types/OrderTileType.dart';
import 'package:next_level_admin/Shared/Widgets/PageTemplate.dart';

// ignore: must_be_immutable
class OrderSystemPage extends StatefulWidget {

  OrderSystemPage({this.orderID});
  int? orderID;

  static const String route = "orders";

  @override
  _OrderSystemPageState createState() => _OrderSystemPageState();
}

class _OrderSystemPageState extends State<OrderSystemPage> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<OrderTileType>?>(
      stream: OrderSystem().paidOrders,
      builder: (context, snapshot) {
        List<OrderTileType>? orders = snapshot.data ?? List.empty();

        return PageTemplate(
          child: ValueListenableBuilder<String>(
            valueListenable: OrderListener.activeOrderUID,
            builder: (context, value, _) {
              return value != '' ? OrderDisplay(orderID: value): Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Order System"),
                  ElevatedButton(onPressed: () => CardMarket_Orders().syncAllOrders(), child: Text("Get Orders")),
                  Container(width: MediaQuery.of(context).size.width * 0.9, child: createDataTable(orders)),
                ],
              );
            },
          ),
        );
      }
    );
  }


  Widget createDataTable(List<OrderTileType> orders) {
    List<DataRow> dr = [];

    orders.forEach((element) {
      DataRow d = new DataRow(cells: [
        DataCell(Text(element.source)),
        DataCell(GestureDetector(onTap:() => print("tapped ${element.id.toString()}"),child: Text(element.id.toString()))),
        DataCell(Text(element.username)),
        DataCell(Text(element.name)),
        DataCell(Text(element.orderValue.toString())),
        DataCell(Text(element.displayDate())),
        DataCell(Row(
          children: [
            ElevatedButton(onPressed: () => OrderListener.setActiveOrderUID(element.id.toString()), child: Text("View"),),
            ElevatedButton(onPressed: () => print("tapped ${element.id.toString()}"), child: Icon(Icons.open_in_new),),
          ],
        ))
      ]);
      dr.add(d);
    });

    return DataTable(columns: [
      DataColumn(label: Text("Source")),
      DataColumn(label: Text("Order ID")),
      DataColumn(label: Text("Username")),
      DataColumn(label: Text("Name")),
      DataColumn(label: Text("Value")),
      DataColumn(label: Text("Date Paid")),
      DataColumn(label: Text("")), //Buttons for viewing
    ],
      rows: dr,
    );
  }
}