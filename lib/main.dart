// ignore_for_file: equal_keys_in_map

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:next_level_admin/Constants/Routes.dart';
import 'package:next_level_admin/Constants/Values/Constants_Colours.dart';
import 'package:next_level_admin/Constants/Values/Constants_Enums.dart';
import 'package:next_level_admin/Constants/Values/Constants_Strings.dart';
import 'package:next_level_admin/Shared/Configs/Firebase/Firebase.dart';
import 'package:next_level_admin/Shared/Libraries/Database_Library.dart';
import 'package:next_level_admin/Shared/Widgets/Widget_Loading.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:routemaster/routemaster.dart';


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
    return FutureBuilder(
      future: FirebaseConfig.initializeFirebase(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder<Auth.User?>(
              stream: Authentication().currentUser,
              initialData: null,
              builder:(context, snapshot) => MaterialApp.router(
                title: AppTitle,
                theme: ThemeData(primarySwatch: mainSwatch),
                debugShowCheckedModeBanner: false,
                routeInformationParser: RoutemasterParser(),
                routerDelegate: RoutemasterDelegate(routesBuilder: (_){
                  final appState = snapshot.hasData;
                  print(appState);
                  return appState ? loggedInRoutes : loggedOutRoutes;
                }
                )),
          );
        }
        return Loading(text: 'Starting Up!');
      },
    );
  }
}
