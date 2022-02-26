import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:next_level_admin/APIs/CardMarket/CardMarket_Orders.dart';
import 'package:next_level_admin/APIs/Configs/CardMarket.dart';
import 'package:next_level_admin/RoyalMail_CaC_CreateOrder.dart';
import 'package:next_level_admin/Services/Database.dart';
import 'package:next_level_admin/YuGiOh_GetData.dart';
import 'package:next_level_admin/flavor.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MultiProvider(providers: [
        Provider<Flavor>.value(value: Flavor.prod),
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
            appId: '1:539259005890:android:92ad409820786282df445b',
            apiKey: 'AIzaSyCnkAWQh2k1mID_KaiquDPqTEYyYVQCl9Y',
            messagingSenderId: '539259005890',
            projectId: 'next-level-cards-admin-dev'));
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
              return Center(
              child: HomeScreen()
            );
    }

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => CardMarket_Orders().GetAccountData(), //CardMarket_Orders().GetAccountData(), //YuGiOh_GetData().GetData(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget HomeScreen()
  {
    return StreamBuilder<CardMarket_API>(
        stream: Database().CardMarketAPI,
        builder: (context, snapshot) {

          if(!snapshot.hasData)
          {
            return Row(); //Will be loading instead or something else once this gets fleshed out
          }

          return Row(
            children: [
                NavigationRail(selectedIndex: _selectedIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  labelType: NavigationRailLabelType.none,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite_border),
                      selectedIcon: Icon(Icons.favorite),
                      label: Text('First',),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.bookmark_border),
                      selectedIcon: Icon(Icons.book),
                      label: Text('Second'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.star_border),
                      selectedIcon: Icon(Icons.star),
                      label: Text('Third'),
                    ),
                  ],
                  extended: isSideBarExtended,
                  trailing: Align(alignment: Alignment.bottomCenter, child: ElevatedButton(onPressed: () => ToggleSideBar(), child: Text("Toggle Side Bar"))),
                  //minExtendedWidth: 10,
                ),

            ],
          );
        }
    );
  }

  bool isSideBarExtended = false;

  void ToggleSideBar() {
    setState(() {
      isSideBarExtended = !isSideBarExtended;
    });
  }
}
