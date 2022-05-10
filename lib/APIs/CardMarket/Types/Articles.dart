part of 'package:next_level_admin/APIs/CardMarket/CardMarket_Library.dart';

class Articles {
  List<Article> articles = List.empty(growable: true);


  Articles.fromXml(Iterable<XmlElement> Articles) {
    Articles.forEach((element) => articles.add(Article.fromXml(element)));
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = Map();

    articles.forEach((element) => data.addAll(element.toMap()));

    return data;
  }
}