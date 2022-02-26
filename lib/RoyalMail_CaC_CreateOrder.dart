import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class RoyalMail {
  Future<void> createOrder() async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "AAccess-Control_Allow_Origin": "*",
      "Access-Control-Allow-Methods": "GET, HEAD",
      "Access-Control-Allow-Credentials": "true",
      "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept",
      HttpHeaders.authorizationHeader: "f3efbf7d-fc2a-4dc5-a286-442089e7e552"
    };

    final body = {
      "items": [
    {
    "orderReference": "1988",
    "recipient": {
    "address": {
    "fullName": "Ricky Barnett",
    "companyName": "",
    "addressLine1": "20 Lon Dderwen",
    "addressLine2": "Connah's Quay",
    "addressLine3": "",
    "city": "Deeside",
    "county": "Flintshire",
    "postcode": "CH5 4WG",
    "countryCode": "UK"
    },
    "phoneNumber": "",
    "emailAddress": "LevelUpTCGOffical@gamil.com",
    "addressBookReference": ""
    },
    "sender": {
    "tradingName": "Next Level Cards LTD",
    "phoneNumber": "07500005710",
    "emailAddress": "LevelUpTCGOffical@gamil.com"
    },
    "billing": {
    "address": {
    "fullName": "Ricky Barnett",
    "companyName": "",
    "addressLine1": "20 Lon Dderwen",
    "addressLine2": "Connah's Quay",
    "addressLine3": "",
    "city": "Deeside",
    "county": "Flintshire",
    "postcode": "CH5 4WG",
    "countryCode": "UK"
    },
    "phoneNumber": "",
    "emailAddress": "LevelUpTCGOffical@gamil.com"
    },
    "packages": [
    {
    "weightInGrams": 100,
    "packageFormatIdentifier": "undefined",
    "customPackageFormatIdentifier": "string",
    "dimensions": {
    "heightInMms": 10,
    "widthInMms": 10,
    "depthInMms": 10
    },
    "contents": [
    {
    "SKU": "1002",
    "quantity": 1
    }
    ]
    }
    ],
    "orderDate": "2021-01-08T14:15:22Z",
    "specialInstructions": "",
    "subtotal": 0,
    "shippingCostCharged": 0.85,
    "otherCosts": 0,
    "total": 5.85,
    "currencyCode": "GBP",
    "postageDetails": {
    "sendNotificationsTo": "sender",
    "serviceCode": "",
    "serviceRegisterCode": "",
    "consequentialLoss": 0,
    "receiveEmailNotification": false,
    "receiveSmsNotification": false,
    "guaranteedSaturdayDelivery": false,
    "requestSignatureUponDelivery": false,
    "isLocalCollect": false,
    "safePlace": "",
    "department": "",
    "AIRNumber": "",
    "IOSSNumber": "",
    "requiresExportLicense": false,
    "commercialInvoiceNumber": "string",
    "commercialInvoiceDate": "2021-01-08T14:15:22Z"
    }
    }]
    };

    final jsonString = json.encode(body);
    //final uri = Uri.http('https://api.parcel.royalmail.com/api/v1/orders', '');
    final response = await http.post(Uri.parse("https://api.parcel.royalmail.com/api/v1/orders"), headers: headers, body: jsonString);

    if(response.statusCode == 200)
    {
      //return "Order Sent";
    }
    else
    {
      //return "This Failed";
    }
  }
  
  Future<String> getVersion() async
  {
    /*Map<String, String> heads = {
      "Content-Type": "application/json",
      "AAccess-Control_Allow_Origin": "*",
      "Access-Control-Allow-Methods": "GET, HEAD",
      "Access-Control-Allow-Credentials": true,
      "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
    };*/
    //http.Request("", )
    final response = await http.get(Uri.parse("https://api.parcel.royalmail.com/api/v1/version"), headers: {
      "Content-Type": "application/xml",
      "AAccess-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET, HEAD",
      "Access-Control-Allow-Credentials": "true",
      "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
    });
   if(response.statusCode == 200)
      {
        Map<String, dynamic> m = jsonDecode(response.body);
        return m["build"].toString();
      }
    else if(response.statusCode == 500)
      {
        Map<String, dynamic> m = jsonDecode(response.body);
        return m["code"].toString();
      }
    else
      {
        return "This Failed";
      }
    return "Test";
  }
  
}