import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../constants.dart';

class OnBoardScreen extends StatefulWidget {
  OnBoardScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

final _controller = PageController(initialPage: 0);

int _currentPage = 0;

List<Widget> _pages = [
  Column(
    children: [
      Expanded(
        child: Image.asset(
          "./images/enteraddress.png",
          height: 400,
          width: 400,
        ),
      ),
      Text(
        'Set Your Deliver Location',
        // style: TextStyle(fontSize: 30),
        style: kPageViewTextStyle, textAlign: TextAlign.center,
      ),
    ],
  ),
  Column(
    children: [
      Expanded(
        child: Image.asset(
          './images/orderfood.png',
          height: 400,
          width: 400,
        ),
      ),
      Text(
        'Order Online from Your Favorite Store',
        // style: TextStyle(fontSize: 25),
        style: kPageViewTextStyle, textAlign: TextAlign.center,
      ),
    ],
  ),
  Column(
    children: [
      Expanded(
        child: Image.asset(
          './images/deliverfood.png',
          height: 400,
          width: 400,
        ),
      ),
      Text(
        'Quick Delivery to your Doorstep',
        // style: TextStyle(
        //   fontSize: 25,
        //   fontWeight: FontWeight.w700,
        // ),
        style: kPageViewTextStyle, textAlign: TextAlign.center,
      ),
    ],
  ),
];

class _OnBoardScreenState extends State<OnBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              children: _pages,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          DotsIndicator(
            dotsCount: _pages.length,
            position: _currentPage.toDouble(),
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              activeColor: Colors.deepOrangeAccent,
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
