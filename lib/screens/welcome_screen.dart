// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'onboard_screen.dart';

class WelcomeScreen extends StatelessWidget {
  // const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Stack(
          children: [
            Positioned(
              right: 0.0,
              top: 10.0,
              child: FlatButton(
                onPressed: () {},
                child: Text('Skip',
                    style: TextStyle(color: Colors.deepOrangeAccent)),
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: OnBoardScreen(),
                ),
                Text('Ready to order from your nearest shop?'),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
                  color: Colors.deepOrangeAccent,
                  child: Text(
                    'Set Deliver Location',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                ),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
                  onPressed: () {},
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an Customer ? ',
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: ' Login',
                          style: TextStyle(
                            color: Colors.deepOrangeAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
