import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_a2hs/providers/auth_provider.dart';
import 'package:flutter_web_a2hs/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Center(
        // ignore: deprecated_member_use
        child: RaisedButton(
          child: Text('Sign Out'),
          onPressed: () {
            auth.error = '';
            FirebaseAuth.instance.signOut().then((value) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WelcomeScreen(),
                ),
              );
            });
          },
        ),
      ),
    );
  }
}
