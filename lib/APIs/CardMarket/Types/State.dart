part of 'package:next_level_admin/APIs/CardMarket/CardMarket_Library.dart';

class State {

  String purchaseState = "";

  Timestamp dateBought = new Timestamp.now();
  Timestamp? datePaid;
  Timestamp? dateSent;
  Timestamp? dateReceived;

  State();

  State.fromXml(XmlElement state) {

    purchaseState = state.findAllElements('state').single.text;
    dateBought = Timestamp.fromDate(DateTime.parse(state.findAllElements('dateBought').single.text));
    datePaid = state.findAllElements('datePaid').isNotEmpty ? Timestamp.fromDate(DateTime.parse(state.findAllElements('datePaid').single.text)) : datePaid;
    dateSent = state.findAllElements('dateSent').isNotEmpty ? Timestamp.fromDate(DateTime.parse(state.findAllElements('dateSent').single.text)) : dateSent;
    dateReceived = state.findAllElements('dateReceived').isNotEmpty ? Timestamp.fromDate(DateTime.parse(state.findAllElements('dateReceived').single.text)) : dateReceived;
  }

  State.fromSnapshot(DocumentSnapshot doc)
  {
    purchaseState = doc["purchase_state"];
    dateBought = doc["dateBought"];
    datePaid = doc["datePaid"];
    dateSent = doc["dataSent"];
    dateReceived = doc["dateReceived"];
  }

  Map<String, dynamic> toMap() => {
    "purchase_state" : purchaseState,
    "dateBought" : dateBought,
    "datePaid" : datePaid,
    "dateSent" : dateSent,
    "dateReceived" : dateReceived
  };

  bool hasEvaluated() => purchaseState == "evaluated";


  //These will be combined into a single method on a refactor
  String displayDateBought() {
    DateTime dt = dateBought.toDate();
    return "${dt.day}/${dt.month}/${dt.year} - ${dt.hour}:${dt.minute}";
  }

  String displayDatePaid() {
    if(datePaid == null)
      {
        return "N/A";
      }
    DateTime dt = datePaid!.toDate();
    return "${dt.day}/${dt.month}/${dt.year} - ${dt.hour}:${dt.minute}";
  }

  String displayDateSent() {
    if(dateSent == null)
    {
      return "N/A";
    }
    DateTime dt = dateSent!.toDate();
    return "${dt.day}/${dt.month}/${dt.year} - ${dt.hour}:${dt.minute}";
  }

  String displayDateReceived() {
    if(dateReceived == null)
    {
      return "N/A";
    }
    DateTime dt = dateReceived!.toDate();
    return "${dt.day}/${dt.month}/${dt.year} - ${dt.hour}:${dt.minute}";
  }
}
