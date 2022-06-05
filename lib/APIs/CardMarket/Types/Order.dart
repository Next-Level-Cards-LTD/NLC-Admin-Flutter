part of 'package:next_level_admin/APIs/CardMarket/CardMarket_Library.dart';

class Order {

  String source = "Card Market";

  int id = 0;

  String trackingNumber = "";
  bool isPresale = false;

  int articleCount = 0;

  late User buyer;
  late Address address;
  late State state;
  late ShippingMethod shippingMethod;
  late Evaluation evaluation;
  late Articles articles;

  double articleValue = 0.0;
  double totalValue = 0.0;

  Order.FromSnapshot(DocumentSnapshot doc)
  {
    id = doc["orderID"];
    source = doc["source"];
    trackingNumber = doc["tracking_number"];
    isPresale = doc["is_presale"];
    articleCount = doc["article_count"];

    buyer = User.fromSnapshot(doc);
    address = Address.fromSnapshot(doc);
    state = State.fromSnapshot(doc);
    shippingMethod = ShippingMethod.fromSnapshot(doc);
    evaluation = Evaluation.fromSnapshot(doc);


    articleValue = doc["article_value"];
    totalValue = doc["total_value"];
  }

  Order(XmlDocument doc){
    id = int.parse(doc.findAllElements('idOrder').single.text);

    buyer = User.fromXml(doc.findAllElements('buyer'));
    address = Address.fromXML(doc.findAllElements('shippingAddress'));
    state = State.fromXml(doc.findAllElements('state').first);
    shippingMethod = ShippingMethod.fromXml(doc.findAllElements('shippingMethod'));

    articles = Articles.fromXml(doc.findAllElements('article'));

    trackingNumber = doc.findAllElements('trackingNumber').single.text;
    isPresale = doc.findAllElements('trackingNumber').single.text == 'true';

    articleCount = int.parse(doc.findAllElements('articleCount').single.text);

    if(state.hasEvaluated()) {
      evaluation = Evaluation.fromXml(doc.findAllElements('evaluation'));
    }

    articleValue = double.parse(doc.findAllElements('articleValue').single.text);
    totalValue = double.parse(doc.findAllElements('totalValue').single.text);
  }

  Order.fromXmlElement(XmlElement doc) {
    id = int.parse(doc.findAllElements('idOrder').single.text);

    buyer = User.fromXml(doc.findAllElements('buyer'));
    address = Address.fromXML(doc.findAllElements('shippingAddress'));
    state = State.fromXml(doc.findAllElements('state').first);
    shippingMethod = ShippingMethod.fromXml(doc.findAllElements('shippingMethod'));

    articles = Articles.fromXml(doc.findAllElements('article'));

    trackingNumber = doc.findAllElements('trackingNumber').single.text;
    isPresale = doc.findAllElements('trackingNumber').single.text == 'true';

    articleCount = int.parse(doc.findAllElements('articleCount').single.text);

    if(state.hasEvaluated()) {
      evaluation = Evaluation.fromXml(doc.findAllElements('evaluation'));
    }

    articleValue = double.parse(doc.findAllElements('articleValue').single.text);
    totalValue = double.parse(doc.findAllElements('totalValue').single.text);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> orderData = new Map();

    orderData["source"] = source;
    orderData["orderID"] = id;

    orderData.addAll(buyer.toMap());
    orderData.addAll(address.toMap());
    orderData.addAll(state.toMap());
    orderData.addAll(shippingMethod.toMap());

    orderData["tracking_number"] = trackingNumber;
    orderData["is_presale"] = isPresale;
    orderData["article_count"] = articleCount;

    orderData["article_value"] = articleValue;
    orderData["total_value"] = totalValue;

    return orderData;
  }
}

