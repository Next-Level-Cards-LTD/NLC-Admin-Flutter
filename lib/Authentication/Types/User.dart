import 'package:cloud_firestore/cloud_firestore.dart';

class UserMini {
  final String uid;

  UserMini({required this.uid});
}

class User {
  final String uid;
  final String email;
  final String username;

  User({required this.uid, required this.email, required this.username});

  //User.fromDocumentSnapshot(DocumentSnapshot data) : this(data['uid'], data['email'], data['username']);

  factory User.fromFirestore(Map data) {
    //Map data = doc.data as Map;

    return User(
      uid: data['uid'] ?? "",
      email: data['email'] ?? "",
      username: data['username'] ?? ""
    );
  }

  static setup(String uid) async {
    if(!isLoggedIn())
      {
        print("User Logged In");
        var data = await FirebaseFirestore.instance.collection("Users").doc(uid).get().then((value) => User.fromFirestore(value.data()!));
        _instance = data;
      }
  }


  static User? _instance = User(uid: "", email: "", username: "");

  static User get instance => _instance!;

  static set instance(User? instance) {
    _instance = instance;
  }

  static bool isLoggedIn() => getUID().isNotEmpty && getUID() != "";


  @override
  String toString() {
    return "User [uid=${this.uid}, email=${this.email}, username=${this.username}]";
  }

  Map<String, dynamic> toMap()  => {
    "uid" : uid,
    "username" : username,
    "email": email
  };

  static String getEmail() => _instance!.email;

  static String getUID() => _instance!.uid;

  static String getUsername() => _instance!.email;
}