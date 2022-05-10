import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:next_level_admin/Constants/Values/Constants_Enums.dart';
import 'package:next_level_admin/Dashboard/OrderSystem/OrderSystem.dart';
import 'package:next_level_admin/Dashboard/OrderSystem/Pages/OrderSystem.dart';
import 'package:next_level_admin/Dashboard/SystemSettings/Pages/SystemSettings.dart';
import 'package:next_level_admin/Routes.dart';
import 'package:next_level_admin/Shared/Libraries/Database_Library.dart';
import 'package:next_level_admin/Shared/Widgets/Widget_Loading.dart';
import 'package:next_level_admin/Authentication/Wrappers/AuthWrapper.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:routemaster/routemaster.dart';

import 'Dashboard/Wrappers/DashboardWrapper.dart';


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

//      initialRoute: '/',
//       onGenerateRoute: Flurorouter.router.generator,
//       routes: {
//         MyHomePage.route : (context) => MyHomePage(),
//         "/${DashboardWrapper.route}" : (context) => DashboardWrapper(selectedIndex: 0),
//         "/stock" : (context) => DashboardWrapper(selectedIndex: 1),
//         "/resource" : (context) => DashboardWrapper(selectedIndex: 2),
//         "/${OrderSystemPage.route}" : (context) => DashboardWrapper(selectedIndex: 3),
//         "/${SystemSettings.route}" : (context) => DashboardWrapper(selectedIndex: 4),
//         '/login' : (context) => AuthWrapper()

//    return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.red,
//       ),
//       //home: MyHomePage(),
//
//       }
//     );

final routes = RouteMap(
  routes: {
    '/': (_) => TabPage(
      child: MyHomePage(),
      paths: ['feed', 'settings'],
    ),
        "/${DashboardWrapper.route}" : (context) => MaterialPage(child: DashboardWrapper(selectedIndex: 0)),
        "/stock" : (context) => MaterialPage(child: DashboardWrapper(selectedIndex: 1)),
        "/resource" : (context) => MaterialPage(child: DashboardWrapper(selectedIndex: 2)),
        "/${OrderSystemPage.route}" : (context) => MaterialPage(child: DashboardWrapper(selectedIndex: 3)),
        "/${SystemSettings.route}" : (context) => MaterialPage(child: DashboardWrapper(selectedIndex: 4)),
        '/login' : (context) => MaterialPage(child: AuthWrapper())
  },
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: "Next Level Admin",
        theme: ThemeData(primarySwatch: Colors.red,),
        debugShowCheckedModeBanner: false,
        routeInformationParser: RoutemasterParser(),
        routerDelegate: RoutemasterDelegate(routesBuilder: (_) => routes));
  }
}

class MyHomePage extends StatefulWidget {

  static const String route = "/";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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
    );
  }
}
