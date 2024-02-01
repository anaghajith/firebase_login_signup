import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_start/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:firebase_start/features/user_auth/presentation/pages/home_page.dart';
import 'package:firebase_start/features/user_auth/presentation/pages/phone_authentication.dart';
import 'package:firebase_start/features/user_auth/presentation/pages/sign_up_page.dart';
import 'package:firebase_start/features/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:firebase_start/global/common/toast.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_web_redirect/google_sign_in_web_redirect.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();


  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Text(
                "Login",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              FormContainerWidget(
                controller: _emailController,
                hintText: "Email",
                isPasswordField: false,
              ),
              SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _passwordController,
                hintText: "Password",
                isPasswordField: true,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: _signIn,
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: _isSigning ? CircularProgressIndicator(
                    color: Colors.white,): Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  _signInWithGoogle();

                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FontAwesomeIcons.google, color: Colors.white,),
                        SizedBox(width: 5,),
                        Text(
                          "Sign in with Google",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  SizedBox(width: 5,),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignUpPage()),(route) => false);
                    },
                    child: Text("Sign Up",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Authenticate with Phone number?"),
                  SizedBox(width: 5,),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PhoneAuthentication()),(route) => false);
                    },
                    child: Icon(FontAwesomeIcons.phone,color: Colors.blue,size: 15),
                    // Text("Sign Up",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      print("User successfully signin");
      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
      // Navigator.pushNamed(context, "/home");
    } else {
      print("Error occured");
    }
  }

  Future _signInWithGoogle()async{

    // final GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: ['email'],
      // clientId: '844097682729-ld7o8hjgi1mp66diai32fijtpmhrmfn2.apps.googleusercontent.com',
       clientId: '844097682729-o68g8vi674i0dc1pk97fd4e636sknl0d.apps.googleusercontent.com',

    );
    try {

      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      if(googleSignInAccount != null ){
        final GoogleSignInAuthentication googleSignInAuthentication = await
        googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await _firebaseAuth.signInWithCredential(credential);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
        // Navigator.pushNamed(context, "/home");
      }

    }catch(e) {
      showToast(message: "some error occured $e");
    }
  }

}
