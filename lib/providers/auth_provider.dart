import 'package:firebase_auth/firebase_auth.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_a2hs/screens/home_screen.dart';
import 'package:flutter_web_a2hs/services/user_services.dart';

class AuthProvider with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  late String smsOtp;
  late String verificationId;
  String error = '';
  UserServices _userServices = UserServices();

  Future<void> verifyPhone(BuildContext context, String number) async {
    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential credential) async {
      await _auth.signInWithCredential(credential);
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException e) async {
      print(e.code);
    };

    final PhoneCodeSent smsOtpSend = (String verId, int? resentToken) async {
      this.verificationId = verId;
      //open dialog to enter received otp sms
      smsOtpDialog(context, number);
    };

    try {
      _auth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: smsOtpSend,
        codeAutoRetrievalTimeout: (String verId) {
          this.verificationId = verId;
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> smsOtpDialog(BuildContext context, String number) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Text("Enter OTP"),
              SizedBox(
                height: 6,
              ),
              Text(
                  "Enter 6 digit OTP received as SMS, We have sent an OTP to $number"),
            ],
          ),
          content: Container(
            height: 85,
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 6,
              onChanged: (value) {
                this.smsOtp = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "OTP",
              ),
            ),
          ),
          actions: [
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () async {
                try {
                  PhoneAuthCredential phoneAuthCredential =
                      PhoneAuthProvider.credential(
                          verificationId: verificationId, smsCode: smsOtp);
                  final user =
                      (await _auth.signInWithCredential(phoneAuthCredential))
                          .user;
                  // create use data in firebase after user successfully Registered
                  _createUser(
                      id: user!.uid, number: user.phoneNumber.toString());
                  // navigate to home page after login
                  // ignore: unnecessary_null_comparison
                  if (user != null) {
                    Navigator.of(context).pop();
                    // don't want come back to welcome screen after loged in
                    Navigator.pushReplacementNamed(context, HomeScreen.id);
                  } else {
                    print("Login Failed");
                  }
                } catch (e) {
                  this.error = 'Invalid OTP';
                  print(e.toString());
                  Navigator.of(context).pop();
                }
              },
              child: Text(
                'DONE',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ],
        );
      },
    );
  }

  void _createUser({required String id, required String number}) {
    _userServices.createUserData({
      'id': id,
      'number': number,
    });
  }
}
