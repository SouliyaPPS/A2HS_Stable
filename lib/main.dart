import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_web_a2hs/providers/auth_provider.dart';
import 'package:flutter_web_a2hs/providers/location_provider.dart';
import 'package:flutter_web_a2hs/screens/MyHomePage.dart';
import 'package:flutter_web_a2hs/screens/home_screen.dart';
import 'package:flutter_web_a2hs/screens/map_screen.dart';
import 'package:flutter_web_a2hs/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  // await Firebase.initializeApp(
  //   options: FirebaseOptions(
  //     apiKey: "AIzaSyAxGc789lnPyPn4K9Z76VS768s6DbueaEY",
  //     authDomain: "grocery-store-5d527.firebaseapp.com",
  //     projectId: "grocery-store-5d527",
  //     storageBucket: "grocery-store-5d527.appspot.com",
  //     messagingSenderId: "113866553527",
  //     appId: "1:113866553527:web:e0e9477256950f58bd3532",
  //     measurementId: "G-LYW13M3SKE",
  //   ),
  // );

  runApp(MyApp());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LocationProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grocery Store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'BaiHyar',
      ),
      // home: MyHomePage(title: 'Grocery Store'),
      initialRoute: MyHomePage.id,
      routes: {
        MyHomePage.id: (context) => MyHomePage(
              title: 'Grocery Store',
            ),
        HomeScreen.id: (context) => HomeScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        MapScreen.id: (context) => MapScreen(),
      },
      // home: FutureBuilder(
      //   future: _checkFirstSeen(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       return snapshot.data != null ? WelcomeScreen() : RegisterScreen();
      //     }
      //     return Container();
      //   },
      // ),
    );
  }

  // Future<bool> _checkFirstSeen() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool _seen = (prefs.getBool('seen') ?? false);

  //   if (_seen) {
  //     return false;
  //   } else {
  //     await prefs.setBool('seen', true);
  //     return true;
  //   }
  // }
}
