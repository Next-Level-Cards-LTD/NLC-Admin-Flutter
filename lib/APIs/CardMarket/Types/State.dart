part of 'package:next_level_admin/APIs/CardMarket/CardMarket_Library.dart';

class State {

  String purchaseState = "";
  DateTime dateBought = new DateTime.now();
  DateTime? datePaid;
  DateTime? dateSent;
  DateTime? dateReceived;

  State();

  State.fromXml(XmlElement state) {
    purchaseState = state.findAllElements('state').single.text;
    dateBought = DateTime.parse(state.findAllElements('dateBought').single.text);
    datePaid = state.findAllElements('datePaid').isNotEmpty ? DateTime.parse(state.findAllElements('datePaid').single.text) : datePaid;
    dateSent = state.findAllElements('dateSent').isNotEmpty ? DateTime.parse(state.findAllElements('dateSent').single.text) : dateSent;
    dateReceived = state.findAllElements('dateReceived').isNotEmpty ? DateTime.parse(state.findAllElements('dateReceived').single.text) : dateReceived;
  }

  Map<String, dynamic> toMap() => {
    "purchase_state" : purchaseState,
    "dateBought" : dateBought,
    "datePaid" : datePaid,
    "dataSent" : dateSent,
    "dateReceived" : dateReceived
  };

  bool hasEvaluated() => purchaseState == "evaluated";

}
