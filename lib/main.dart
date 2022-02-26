import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:next_level_admin/APIs/CardMarket/CardMarket_Orders.dart';
import 'package:next_level_admin/APIs/Configs/CardMarket.dart';
import 'package:next_level_admin/RoyalMail_CaC_CreateOrder.dart';
import 'package:next_level_admin/Services/Authentication.dart';
import 'package:next_level_admin/Services/Database.dart';
import 'package:next_level_admin/Shared/Widgets/Widget_Loading.dart';
import 'package:next_level_admin/Wrappers/AuthWrapper.dart';
import 'package:next_level_admin/YuGiOh_GetData.dart';
import 'package:next_level_admin/flavor.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MultiProvider(providers: [
        Provider<Flavor>.value(value: Flavor.dev),
      ],
        child: MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);




  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _selectedIndex = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp(name: "Next Level Cards Admin",
        options: FirebaseOptions(
            appId: '1:104061090278:android:fb1ffcb1f2e99887b87e27',
            apiKey: 'AIzaSyDXN4NeVuDwpl8j2UPoqll4ZoVot2eisSw',
            messagingSenderId: '104061090278',
            projectId: 'nlc-admin-dev'));
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.done)
            {
              return StreamProvider<Auth.User?>.value(
              value: Authentication().currentUser,
              initialData: null,
              child: AuthWrapper());
            }
            return Loading(text: 'Starting Up!');
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => CardMarket_Orders().GetAccountData(), //CardMarket_Orders().GetAccountData(), //YuGiOh_GetData().GetData(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
