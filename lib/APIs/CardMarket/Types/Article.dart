part of 'package:next_level_admin/APIs/CardMarket/CardMarket_Library.dart';

class Article{
  int articleID = 0;
  int productID = 0;
  int languageID = 0;
  String languageName = "";
  double pricePer = 0.0;
  int currencyID = 0;
  String currencyCode = "";
  int articleCount = 0;

  late Product products;

  String condition = "";
  bool isSigned = false;
  bool isFirstED = false;
  bool isAltered = false;

  Article();

  Article.fromXml(XmlElement xml) {
    articleID = xml.findAllElements("idArticle").isNotEmpty ? int.parse(xml.findAllElements("idArticle").single.text) : 0;
    productID = xml.findAllElements("idProduct").isNotEmpty ? int.parse(xml.findAllElements("idProduct").single.text) : 0;
    languageID = xml.findAllElements("idLanguage").isNotEmpty ? int.parse(xml.findAllElements("idLanguage").single.text) : 0;
    languageName = xml.findAllElements("languageName").isNotEmpty ? xml.findAllElements("languageName").single.text : "";
    pricePer = xml.findAllElements("languageName").isNotEmpty ? double.parse(xml.findAllElements("price").single.text) : 0;
    currencyID = xml.findAllElements("idCurrency").isNotEmpty ? int.parse(xml.findAllElements("idCurrency").single.text) : 0;
    currencyCode = xml.findAllElements("currencyCode").isNotEmpty ? xml.findAllElements("currencyCode").single.text : "";
    articleCount = xml.findAllElements("count").isNotEmpty ? int.parse(xml.findAllElements("count").single.text) : 0;

    products = Product.fromXml(xml.findAllElements("product").single);

    condition = xml.findAllElements("condition").isNotEmpty ? xml.findAllElements("condition").single.text : "";
    isSigned = xml.findAllElements("isSigned").isNotEmpty ? xml.findAllElements("isSigned").single.text == 'true' : false;
    isFirstED = xml.findAllElements("isFirstEd").isNotEmpty ? xml.findAllElements("isFirstEd").single.text == 'true' : false;
    isAltered = xml.findAllElements("isAltered").isNotEmpty ? xml.findAllElements("isAltered").single.text == 'true' : false;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = Map();

    data["article_ID"] = articleID;
    data["product_ID"] = productID;
    data["language_ID"] = languageID;
    data["language_name"] = languageName;
    data["price_per"] = pricePer;
    data["currency_ID"] = currencyID;
    data["currency_code"] = currencyCode;
    data["article_count"] = articleCount;

    data.addAll(products.toMap());

    data["condition"] = condition;
    data["is_signed"] = isSigned;
    data["is_first_ed"] = isFirstED;
    data["is_altered"] = isAltered;

    return data;
  }
}