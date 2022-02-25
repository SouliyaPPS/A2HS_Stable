import 'package:flutter_web_a2hs/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:universal_html/js.dart" as js;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OLX Shop',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

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
  }

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Color.fromARGB(255, 255, 157, 28),
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 50.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'Horizon',
    );
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: true,
      //   centerTitle: true,
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                js.context.callMethod("presentAddToHome");
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const HomeScreen(),
                  ),
                );
              }, // Handle your callback.
              splashColor: Colors.brown.withOpacity(0.5),
              child: Ink(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  // ignore: unnecessary_const
                  image: const DecorationImage(
                    image: AssetImage('./assets/screen.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  'OLX Shopping',
                  textStyle: colorizeTextStyle,
                  colors: colorizeColors,
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.add_to_home_screen,
                color: Colors.white,
                size: 30.0,
              ),
              label: const Text('Add to Home Screen'),
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 28),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onPressed: () {
                js.context.callMethod("presentAddToHome");
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const HomeScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 25.0),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.menu_open,
                color: Colors.white,
                size: 32,
              ),
              label: const Text('Go to App'),
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onPressed: () {
                // js.context.callMethod("presentAddToHome");
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const HomeScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 27.0),
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
                  child: Text("Yes"))
            ],
          ),
        ),
      );
    },
  );
}
