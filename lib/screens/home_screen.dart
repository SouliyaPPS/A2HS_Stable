// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_a2hs/providers/auth_provider.dart';
import 'package:flutter_web_a2hs/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  // const HomeScreen({ Key? key }) : super(key: key);
  static const String id = 'home-screen';

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RaisedButton(
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
          RaisedButton(
            child: Text('Home Screen'),
            onPressed: () {
              Navigator.pushNamed(context, WelcomeScreen.id);
            },
          ),
        ],
      )),
    );
  }
}
