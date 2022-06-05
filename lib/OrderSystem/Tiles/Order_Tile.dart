import 'package:flutter/material.dart';

import '../Types/OrderTileType.dart';

class OrderTile extends StatelessWidget {

  final OrderTileType orderTile;

  OrderTile(this.orderTile);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
          color: Colors.white,
          child: GridTile(
              child: Row(
                children: [
                  Text(orderTile.source),
                  Text(orderTile.displayDate())
                ],
              )
          )
      ),
    );
  }
}
