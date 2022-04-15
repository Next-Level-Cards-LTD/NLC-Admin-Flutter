import 'package:flutter/material.dart';
import 'package:next_level_admin/APIs/CardMarket/Requests/CardMarket_Orders.dart';
import 'package:next_level_admin/APIs/CardMarket/Types/OrderListener.dart';
import 'package:next_level_admin/Dashboard/OrderSystem/Pages/OrderDisplay.dart';
import 'package:next_level_admin/Dashboard/OrderSystem/Types/OrderTileType.dart';
import '../OrderSystem.dart';

class OrderSystemPage extends StatefulWidget {
  const OrderSystemPage({Key? key}) : super(key: key);

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

        List<OrderTileType>? orders = snapshot.data;

        return ValueListenableBuilder<String>(
          valueListenable: OrderListener.activeOrderUID,
          builder: (context, value, _) {
            return value != '' ? OrderDisplay(orderID: value): Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Order System"),
                ElevatedButton(onPressed: () => CardMarket_Orders().syncAllOrders(), child: Text("Get Orders")),
                Container(width: MediaQuery.of(context).size.width * 0.8, child: createDataTable(orders!)),
                //createDataTable(orders!)
              ],
            );
          },
        );
      }
    );
  }


  Widget createDataTable(List<OrderTileType> orders) {
    List<DataRow> dr = [];

    orders.forEach((element) {
      DataRow d = new DataRow(cells: [
        DataCell(Text(element.source)),
        DataCell(GestureDetector(onTap:() => print("tapped ${element.ID.toString()}"),child: Text(element.ID.toString()))),
        DataCell(Text(element.username)),
        DataCell(Text(element.name)),
        DataCell(Text(element.orderValue.toString())),
        DataCell(Text(element.displayDate())),
        DataCell(Row(
          children: [
            ElevatedButton(onPressed: () => OrderListener.setActiveOrderUID(element.ID.toString()), child: Text("View"),),
            ElevatedButton(onPressed: () => print("tapped ${element.ID.toString()}"), child: Icon(Icons.open_in_new),),
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


//!snapshot.hasData ? Loading(text: 'Loading...') : Container(
//               height: 500,
//               width: 500,
//               child: ListView.builder(
//                 shrinkWrap: true,
//                   itemCount: orders!.length,
//                   itemBuilder: (context, index) {
//                     return OrderTile(orders[index]);
//                   }
//               ),
//             )