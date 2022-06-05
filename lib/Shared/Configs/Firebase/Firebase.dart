import 'package:firebase_core/firebase_core.dart';
import 'Configs.dart';

class FirebaseConfig {
  static Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp(name: APPNAME,
        options: FirebaseOptions(
            appId: APPID,
            apiKey: APIKEY,
            messagingSenderId: MESSAGINGSENDERID,
            projectId: PROJECTID));
    return firebaseApp;
  }
}