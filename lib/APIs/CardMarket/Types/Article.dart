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

  late Product product;

  String condition = "";
  bool isSigned = false;
  bool isFirstED = false;
  bool isAltered = false;

  Article();

  Article.fromXml(XmlElement xml) {
    articleID = int.parse(xml.findAllElements("idArticle").single.text);
    productID = int.parse(xml.findAllElements("idProduct").single.text);
    languageID = int.parse(xml.findAllElements("idLanguage").single.text);
    languageName = xml.findAllElements("languageName").single.text;
    pricePer = double.parse(xml.findAllElements("price").single.text);
    currencyID = int.parse(xml.findAllElements("idCurrency").single.text);
    currencyCode = xml.findAllElements("currencyCode").single.text;
    articleCount = int.parse(xml.findAllElements("count").single.text);

    product = Product.fromXml(xml.findAllElements("product").single);

    condition = xml.findAllElements("condition").single.text;
    isSigned = xml.findAllElements("isSigned").single.text == 'true';
    isFirstED = xml.findAllElements("isFirstEd").single.text == 'true';
    isAltered = xml.findAllElements("isAltered").single.text == 'true';
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

    data.addAll(product.toMap());

    data["condition"] = condition;
    data["is_signed"] = isSigned;
    data["is_first_ed"] = isFirstED;
    data["is_altered"] = isAltered;

    return data;
  }
}