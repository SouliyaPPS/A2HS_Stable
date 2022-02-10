import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_web_a2hs/providers/auth_provider.dart';
// import 'package:flutter_web_a2hs/screens/home_screen.dart';
import 'package:flutter_web_a2hs/screens/register_screen.dart';
import 'package:flutter_web_a2hs/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:universal_html/js.dart" as js;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
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
      ),
      home: MyHomePage(title: 'Grocery Store'),
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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        final _prefs = await SharedPreferences.getInstance();
        final _isWebDialogShownKey = "is-web-dialog-shown";
        final _isWebDialogShown = _prefs.getBool(_isWebDialogShownKey) ?? false;
        if (!_isWebDialogShown) {
          final bool isDeferredNotNull =
              js.context.callMethod("isDeferredNotNull") as bool;

          if (isDeferredNotNull) {
            debugPrint(">>> Add to HomeScreen prompt is ready.");
            await showAddHomePageDialog(context);
            _prefs.setBool(_isWebDialogShownKey, true);
          } else {
            debugPrint(">>> Add to HomeScreen prompt is not ready yet.");
          }
        }
      });
    }

    // Timer(
    //   Duration(seconds: 8),
    //   () {
    //     FirebaseAuth.instance.authStateChanges().listen((User? user) async {
    //       if (user == null) {
    //         Navigator.pushReplacement(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => HomeScreen(),
    //             ));
    //       }
    //     });
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    // final ButtonStyle style =
    //     ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Scaffold(
      appBar: AppBar(
        title: new Text(widget.title, textAlign: TextAlign.center),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                js.context.callMethod("presentAddToHome");
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => WelcomeScreen(),
                  ),
                );
              }, // Handle your callback.
              splashColor: Colors.brown.withOpacity(0.5),
              child: Ink(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            ElevatedButton.icon(
              icon: Icon(
                Icons.add_to_home_screen,
                color: Colors.white,
                size: 30.0,
              ),
              label: Text('Add to Home Screen'),
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 28),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                ),
              ),
              onPressed: () {
                js.context.callMethod("presentAddToHome");
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => WelcomeScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 25.0),
            ElevatedButton.icon(
              icon: Icon(
                Icons.menu_open,
                color: Colors.white,
                size: 32,
              ),
              label: Text('Go to App'),
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 25),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                ),
              ),
              onPressed: () {
                // js.context.callMethod("presentAddToHome");
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => WelcomeScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 27.0),
            ElevatedButton.icon(
              icon: Icon(
                Icons.app_registration,
                color: Colors.white,
                size: 32,
              ),
              label: Text('Register App'),
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 25),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                ),
              ),
              onPressed: () {
                // js.context.callMethod("presentAddToHome");
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const RegisterScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool?> showAddHomePageDialog(BuildContext context) async {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                  child: Icon(
                Icons.add_circle,
                size: 70,
                color: Theme.of(context).primaryColor,
              )),
              SizedBox(height: 20.0),
              Text(
                'Add to Homepage',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20.0),
              Text(
                'Want to add this application to home screen?',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  js.context.callMethod("presentAddToHome");
                  Navigator.pop(context, false);
                },
                child: Text("Yes!"),
              ),
            ],
          ),
        ),
      );
    },
  );
}
