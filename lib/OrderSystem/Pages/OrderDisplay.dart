import 'package:flutter/material.dart';
import 'package:next_level_admin/APIs/CardMarket/Types/OrderListener.dart';
import 'package:next_level_admin/APIs/CardMarket/CardMarket_Library.dart' as CM;
import 'package:next_level_admin/OrderSystem/OrderSystem.dart';
import 'package:next_level_admin/Shared/Widgets/Widget_Loading.dart';


// ignore: must_be_immutable
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

            CM.Order? order = snapshot.data ?? null;

            return Container(child: Column(
              children: [
                ElevatedButton(onPressed: () => OrderListener.clearActiveOrderUID(), child: Text("Back")),
                snapshot.hasData ? displayOrderInformation(order) : Loading(text: "Getting Order"),
              ],
            ));
          }
    );
  }

  Widget displayOrderInformation(CM.Order? order)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Order ID: ${order?.id ?? "-1"}"),
        Text("Source: ${order?.source ?? "None"}"),
        Text("Tracking Number: ${order?.trackingNumber ?? ""}"),
        Text("Is Presale?: ${order?.isPresale ?? "false"}"),
        Text("Article Count: ${order?.articleCount ?? "0"}"),

        //Very hacky need to change to some form of line break
        Text(""),
        Text("Buyer Information", textScaleFactor: 1.5,),
        Text("Buyer ID: ${order?.buyer.buyerID ?? "0"}"),
        Text("Username: ${order?.buyer.username ?? ""}"),

        //Very hacky need to change to some form of line break
        Text(""),
        Text("Buyer Address", textScaleFactor: 1.5,),
        Text("Name: ${order?.address.name ?? ""}"),
        Text("Street: ${order?.address.street ?? ""}"),
        Text("Extra: ${order?.address.extra ?? ""}"),
        Text("City: ${order?.address.city ?? ""}"),
        Text("Country: ${order?.address.country ?? ""}"),
        Text("PostCode: ${order?.address.postCode ?? ""}"),

        //Very hacky need to change to some form of line break
        Text(""),
        Text("Order State", textScaleFactor: 1.5,),
        Text("Purchase State: ${order?.state.purchaseState ?? ""}"),
        //Text("Date Bought: ${order?.state.displayDateBought()}"),
        //Text("Date Paid: ${order?.state.displayDatePaid() ?? ""}"),
        //Text("Date Sent: ${order?.state.displayDateSent() ?? ""}"),
        //Text("Date Received: ${order?.state.displayDateReceived() ?? ""}"),

        //Very hacky need to change to some form of line break
        Text(""),
        Text("Evaluation", textScaleFactor: 1.5,),
        //order!.state.hasEvaluated() ? Text("Evaluation Grade: ${order?.evaluation.evaluationGrade ?? "-1"}") : Text("Evaluation Grade: Not Evaluated Yet"),
        //order!.state.hasEvaluated() ? Text("Item Description: ${order?.evaluation.itemDescription ?? "-1"}") : Text("Item Description: Not Evaluated Yet"),
        //order!.state.hasEvaluated() ? Text("Packaging Grade: ${order?.evaluation.packaging ?? "-1"}") : Text("Packaging Grade: Not Evaluated Yet"),
        //order!.state.hasEvaluated() ? Text("Comment: ${order?.evaluation.comment ?? "-1"}") : Text("Comment: Not Evaluated Yet"),

        //Very hacky need to change to some form of line break
        Text(""),
        Text("Shipping Method", textScaleFactor: 1.5,),
        Text("Shipping ID: ${order?.shippingMethod.shippingID ?? "-1"}"),
        Text("Method Name: ${order?.shippingMethod.methodName ?? ""}"),
        Text("Shipping Price: ${order?.shippingMethod.shippingPrice ?? ""}"),
        Text("Currency ID: ${order?.shippingMethod.currencyID ?? "-1"}"),
        Text("Currency Code: ${order?.shippingMethod.currencyCode ?? "-1"}"),
        Text("Is Letter: ${order?.shippingMethod.isLetter ?? "false"}"),
        Text("Is Insured: ${order?.shippingMethod.isInsured ?? "false"}"),
        //Very hacky need to change to some form of line break
        Text(""),
        Text("Order Value", textScaleFactor: 1.5,),
        Text("Article Value: £${order?.articleValue ?? "0"}"),
        Text("Total Value: £${order?.totalValue ?? "0"}"),
      ],
    );
  }
}
