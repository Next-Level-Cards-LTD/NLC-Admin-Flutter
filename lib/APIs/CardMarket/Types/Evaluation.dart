part of 'package:next_level_admin/APIs/CardMarket/CardMarket_Library.dart';

class Evaluation{

  int evaluationGrade = 0;
  int itemDescription = 0;
  int packaging = 0;
  String comment = "";

  Evaluation();

  Evaluation.fromXml(Iterable<XmlElement> evaluation) {
    evaluationGrade = int.parse(evaluation.map((e) => e.findAllElements("evaluationGrade").single.text).single.toString());
    itemDescription = int.parse(evaluation.map((e) => e.findAllElements("itemDescription").single.text).single.toString());
    packaging = int.parse(evaluation.map((e) => e.findAllElements("packaging").single.text).single.toString());
    comment = evaluation.map((e) => e.findAllElements("comment").single.text).single.toString();
  }

  Map<String, dynamic> toMap() => {
    "evaluation_grade" : evaluationGrade,
    "item_description_evaluation" : itemDescription,
    "packaging_evaluation" : packaging,
    "comment_evaluation" : comment
  };

}