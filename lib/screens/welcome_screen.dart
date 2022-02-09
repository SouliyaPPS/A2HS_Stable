// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_web_a2hs/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'onboard_screen.dart';

// ignore: must_be_immutable
class WelcomeScreen extends StatelessWidget {
  // const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    bool _validPhoneNumber = false;
    var _phoneNumberController = TextEditingController();
    void showBottomSheet(context) {
      showModalBottomSheet(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, StateSetter myState) {
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: auth.error == 'Invalid OTP' ? true : false,
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              auth.error,
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      'Login',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Enter your phone number',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        prefixText: '+85620',
                        labelText: '8 digits mobile number',
                      ),
                      autofocus: true,
                      keyboardType: TextInputType.phone,
                      maxLength: 8,
                      controller: _phoneNumberController,
                      onChanged: (value) {
                        if (value.length == 8) {
                          myState(() {
                            _validPhoneNumber = true;
                          });
                        } else {
                          myState(() {
                            _validPhoneNumber = false;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: AbsorbPointer(
                            absorbing: _validPhoneNumber ? false : true,
                            child: FlatButton(
                              color: _validPhoneNumber
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey,
                              child: Text(
                                  _validPhoneNumber
                                      ? 'CONTINUE'
                                      : 'ENTER PHONE NUMBER',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                String number =
                                    '+85620${_phoneNumberController.text}';
                                auth.verifyPhone(context, number).then((value) {
                                  _phoneNumberController.clear();
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
    }

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
                Text('Ready to order from your nearest shop?',
                    style: TextStyle(color: Colors.grey)),
                SizedBox(
                  height: 10,
                ),
                FlatButton(
                  color: Colors.deepOrangeAccent,
                  child: Text(
                    'SET DELIVERY LOCATION',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                ),
                SizedBox(
                  height: 10,
                ),
                FlatButton(
                  onPressed: () {
                    showBottomSheet(context);
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an Customer ? ',
                      style: TextStyle(color: Colors.grey),
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
