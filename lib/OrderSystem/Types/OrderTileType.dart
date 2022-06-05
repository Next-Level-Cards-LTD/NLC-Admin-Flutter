import 'package:cloud_firestore/cloud_firestore.dart';

class OrderTileType{

  OrderTileType(this.id, this.source, this.username, this.name, this.orderValue, this.orderDate);

  int id = 0;

  String source = "";

  String username = "";

  String name = "";

  double orderValue = 0.0;

  Timestamp orderDate;


  String displayDate() {
    DateTime dt = orderDate.toDate();
    return "${dt.day}/${dt.month}/${dt.year} - ${dt.hour}:${dt.minute}";
  }

}