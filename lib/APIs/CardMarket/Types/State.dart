part of 'package:next_level_admin/APIs/CardMarket/CardMarket_Library.dart';

class State {

  String PurchaseState = "";
  DateTime dateBought = new DateTime.now();
  DateTime? datePaid;
  DateTime? dateSent;
  DateTime? dateReceived;

  State();

  State.fromXml(XmlElement state) {
    PurchaseState = state.findAllElements('state').single.text;
    dateBought = DateTime.parse(state.findAllElements('dateBought').single.text);

    //TODO See if I can reduce these if statements to one line
    datePaid = state.findAllElements('datePaid').isNotEmpty ? DateTime.parse(state.findAllElements('datePaid').single.text) : datePaid;

    if(state.findAllElements('dateSent').isNotEmpty)
    {
      dateSent = DateTime.parse(state.findAllElements('dateSent').single.text);
    }
    if(state.findAllElements('dateReceived').isNotEmpty)
    {
      dateReceived = DateTime.parse(state.findAllElements('dateReceived').single.text);
    }
  }

  Map<String, dynamic> toMap() => {
    "purchase_state" : PurchaseState,
    "dateBought" : dateBought,
    "datePaid" : datePaid,
    "dataSent" : dateSent,
    "dateReceived" : dateReceived
  };

  bool hasEvaluated() => PurchaseState == "evaluated";

}
