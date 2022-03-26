import 'package:cloud_firestore/cloud_firestore.dart';

class OrderTileType{

  OrderTileType(this.ID, this.source, this.username, this.name, this.orderValue, this.orderDate);

  int ID = 0;

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