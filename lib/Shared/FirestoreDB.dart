class FirestoreDB
{
  static FirestoreDB? _instance = FirestoreDB._();

  static FirestoreDB get instance => _instance!;

  static set instance(FirestoreDB? instance) {
    _instance = instance;
  }

  FirestoreDB._();

  //Collections
  final String userCollection = "Users";
  final String YuGiOhCardDatabase = "YuGiOh Cards";
  final String APIConfigsCollection = "API Configs";
  final String orderCollection = "Orders";



}