// import 'package:firebase_start/features/user_auth/presentation/pages/home_page.dart';
// import 'package:firebase_start/features/user_auth/presentation/widgets/form_container_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
// import 'package:firebase_phone_auth_handler_flave/firebase_phone_auth_handler_flave.dart';
//
// class PhoneAuthentication extends StatefulWidget {
//   @override
//   _PhoneAuthenticationState createState() => _PhoneAuthenticationState();
// }
//
// class _PhoneAuthenticationState extends State<PhoneAuthentication> {
//   TextEditingController phoneNumberController = TextEditingController();
//   TextEditingController otpController = TextEditingController();
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   String verificationId = "";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "Phone Authentication",
//                 style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               FormContainerWidget(
//                 controller: phoneNumberController,
//                 hintText: "Phone Number",
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: () async {
//                   String phoneNumber = phoneNumberController.text.trim();
//                   await verifyPhoneNumber(phoneNumber);
//                 },
//                 child: Text('Send OTP'),
//               ),
//               SizedBox(height: 16.0),
//               FormContainerWidget(
//                 controller: otpController,
//                 hintText: "OTP",
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: () async {
//                   String otp = otpController.text.trim();
//                   await signInWithOTP(otp);
//                 },
//                 child: Text('Verify OTP'),
//               ),
//             ],
//           ),
//         ),
//         );
//   }
//
//   Future<void> verifyPhoneNumber(String phoneNumber) async {
//     try {
//       await _auth.verifyPhoneNumber(
//         phoneNumber: phoneNumber,
//         verificationCompleted: (PhoneAuthCredential credential) async {
//
//           await _auth.signInWithCredential(credential);
//           navigateToHomePage();
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           print('Verification Failed: $e');
//         },
//         codeSent: (String verificationId, int? resendToken) {
//
//           print('Code Sent: $verificationId');
//           setState(() {
//             this.verificationId = verificationId;
//           });
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {
//           print('Auto Retrieval Timeout: $verificationId');
//         },
//       );
//     } catch (e) {
//       print('Error during phone number verification: $e');
//     }
//   }
//
//   Future<void> signInWithOTP(String otp) async {
//     try {
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: verificationId,
//         smsCode: otp,
//       );
//
//       await _auth.signInWithCredential(credential);
//       navigateToHomePage();
//     } catch (e) {
//       print('Error signing in with OTP: $e');
//     }
//   }
//
//   void navigateToHomePage() {
//     Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
//   }
// }

import 'package:firebase_start/features/user_auth/presentation/pages/home_page.dart';
import 'package:firebase_start/features/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';

class PhoneAuthentication extends StatefulWidget {
  @override
  _PhoneAuthenticationState createState() => _PhoneAuthenticationState();
}

class _PhoneAuthenticationState extends State<PhoneAuthentication> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Phone Authentication",
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                FormContainerWidget(
                  controller: phoneNumberController,
                  hintText: "Phone Number",
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    String phoneNumber = phoneNumberController.text.trim();
                    await verifyPhoneNumber(phoneNumber);
                  },
                  child: Text('Send OTP'),
                ),
                SizedBox(height: 16.0),
                FormContainerWidget(
                  controller: otpController,
                  hintText: "OTP",
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    String otp = otpController.text.trim();
                    await signInWithOTP(otp);
                  },
                  child: Text('Verify OTP'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  verifyPhoneNumber(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        navigateToHomePage();
      },
      verificationFailed: (FirebaseAuthException e) {

        print('Verification Failed: $e');
      },
      codeSent: (String verificationId, int? resendToken) {
        print('Code Sent: $verificationId');
        setState(() {
          this.verificationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('Auto Retrieval Timeout: $verificationId');
      },
    );
  }

  signInWithOTP(String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      await _auth.signInWithCredential(credential);
      navigateToHomePage();
    } catch (e) {
      print('Error signing in with OTP: $e');
    }
  }

  void navigateToHomePage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
  }
}
