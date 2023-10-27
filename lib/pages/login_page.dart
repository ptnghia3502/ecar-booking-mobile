import 'package:flutter/material.dart';
import 'package:ecar_booking_mobile/services/authentication_api.dart';

import 'main_pages/sign_up_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  Future<void> _handleLogin() async {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      // If email or password is empty, show a warning
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Login Failed',
              style: TextStyle(color: Colors.red),
            ),
            content: const Text('Email and password are required.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      try {
        final result = await AuthenticationApi.login(email, password);
        final currentData = await AuthenticationApi.getCustomerDetails();
        if (result != null && currentData != null) {
          Navigator.pushNamed(context, '/home');
        }
        // Handle the successful login by navigating to the home screen
      } catch (e) {
        // Handle login failure by showing an error message
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                'Login Failed',
                style: TextStyle(color: Colors.red),
              ),
              content:
                  const Text('Failed to login. Please check your credentials.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orangeAccent,
        body: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.orangeAccent, Color.fromARGB(179, 255, 242, 175)],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Logo at the top
                    Image.asset('lib/assets/images/logo.png',
                        width: 160, height: 160),

                    const SizedBox(height: 50),

                    Container(
                      width: 240,
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          filled: true,
                          fillColor:
                              Colors.white, // Set the background color to white
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Set the border radius
                            borderSide: const BorderSide(
                                color: Colors
                                    .black), // Set the border color to black
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Container(
                      width: 240,
                      child: TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          filled: true,
                          fillColor:
                              Colors.white, // Set the background color to white
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Set the border radius
                            borderSide: const BorderSide(
                                color: Colors
                                    .black), // Set the border color to black
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        obscureText: _obscurePassword,
                      ),
                    ),

                    const SizedBox(height: 20),
                    Container(
                      width: 100, // Set the desired width
                      child: ElevatedButton(
                        onPressed: _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                              0xFF4285F4), // Set the background color to #4285F4
                        ),
                        child: const Text('Login',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to the registration page
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage()));
                        },
                        child: const Text(
                          "You don't have an account? Register here!",
                          style: TextStyle(
                            color: Color(
                                0xFF4285F4), // Change the text color to a link color
                            decoration: TextDecoration
                                .underline, // Add an underline effect
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
