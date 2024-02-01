import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_start/features/user_auth/presentation/pages/login_page.dart';
import 'package:firebase_start/global/common/toast.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Column(
        children: [
          SizedBox(height: 30,),
          Center(
            child: Text("Welcome :)"),
          ),
          SizedBox(height: 30,),
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(context,MaterialPageRoute(builder: (content)=>LoginPage()));
              showToast(message: "Successfully signed out");
            },
            child: Container(
              width: 100,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Sign Out",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),

    );
  }
}
