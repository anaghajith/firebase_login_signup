import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_start/features/app/splash_screen/splash_screen.dart';
import 'package:firebase_start/features/user_auth/presentation/pages/login_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBL3ByJMP29pBe13vXYg_szi8v1isAtJOA",
            appId: "1:844097682729:web:75887c6bc5dd72e4de4b38",
            messagingSenderId: "844097682729",
            projectId: "fir-login-3b7f8",
            storageBucket: "fir-login-3b7f8.appspot.com",
            authDomain: "fir-login-3b7f8.firebaseapp.com",
        ),
    );
  }else {
    await Firebase.initializeApp();
  }
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Firebase",
      home: SplashScreen(
        child: LoginPage(),
      ),
    );
  }
}

