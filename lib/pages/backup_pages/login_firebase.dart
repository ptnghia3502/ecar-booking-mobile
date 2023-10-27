import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:vouch_tour_mobile/services/api_service.dart';

class LoginFirebasePage extends StatefulWidget {
  @override
  _LoginFirebasePageState createState() => _LoginFirebasePageState();
}

class _LoginFirebasePageState extends State<LoginFirebasePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _isLoading = false; // Track the loading state

  Future<User?> _signInWithGoogle() async {
    try {
      setState(() {
        _isLoading = true; // Set loading state to true when login starts
      });

      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      setState(() {
        _isLoading = false; // Set loading state to false when login is done
      });

      return user;
    } catch (e, stackTrace) {
      setState(() {
        _isLoading = false; // Set loading state to false in case of an error
      });
      print("Error signing in with Google: $e"); // Print the error message
      print("Stack Trace: $stackTrace");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "lib/assets/images/ecar.png",
                width: 250,
                height: 150,
              ),
              const SizedBox(height: 20),
              _isLoading // Check the loading state to show loading indicator or login buttons
                  ? const CircularProgressIndicator() // Show loading indicator
                  : Container(
                      width: 200,
                      height: 50, // Adjust the width as needed
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.black),
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _signInWithGoogle().then((userCredential) {
                            if (userCredential != null) {
                              // Login successful, navigate to HomePage
                              Navigator.pushNamed(context, "/home");
                            } else {
                              // Error signing in, display an error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text("Failed to sign in with Google."),
                                ),
                              );
                            }
                          });
                        },
                        icon: Image.asset(
                          "lib/assets/images/google_logo.png",
                          width: 24,
                          height: 24,
                        ),
                        label: const Text(
                          "Login with Google",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
