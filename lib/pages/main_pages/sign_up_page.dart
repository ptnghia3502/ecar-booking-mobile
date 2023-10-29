import 'package:ecar_booking_mobile/pages/login_page.dart';
import 'package:flutter/material.dart';

import '../../models/registration_model.dart';
import '../../services/authentication_api.dart';
import '../../utils/global_message.dart'; // Import your registration request model

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Text editing controllers for input fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  String _errorText = '';
  late GlobalMessage globalMessage;

  @override
  Widget build(BuildContext context) {
    globalMessage = GlobalMessage(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Sign Up',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                _buildTextField(
                  controller: _emailController,
                  label: 'Email',
                  validator: (value) {
                    if (value!.isEmpty || !isValidEmail(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  controller: _passwordController,
                  label: 'Password',
                  isPassword: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (!_isPasswordValid(value)) {
                      return 'Contain at least 1 uppercase letter, 1 special character, and 1 number.';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  controller: _phoneNumberController,
                  label: 'Phone Number',
                  validator: (value) {
                    if (value!.isEmpty || value.length < 10) {
                      return 'Phone number must be at least 10 characters';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  controller: _nameController,
                  label: 'Name',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                if (_errorText.isNotEmpty)
                  Text(
                    _errorText,
                    style: const TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _signUp,
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.orange),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: const Text('Sign Up'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    bool isPassword = false, // Specify if it's a password field
  }) {
    bool _obscureText = isPassword;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black), // Black border outline
        borderRadius: BorderRadius.circular(8.0), // Border radius
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none, // Remove default border
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 12.0, vertical: 8.0), // Padding for the label
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: Icon(_obscureText ? Icons.lock : Icons.lock_open),
                )
              : null,
        ),
        validator: validator,
        obscureText: isPassword ? _obscureText : false,
      ),
    );
  }

  bool isValidEmail(String email) {
    // Use a regular expression to check for a valid email format
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (email.isEmpty) {
      return false;
    }
    if (!emailRegExp.hasMatch(email)) {
      return false;
    }
    if (!email.endsWith('.com')) {
      return false;
    }
    return true;
  }

  // Add this function to check password validity
  bool _isPasswordValid(String password) {
    // Use a regular expression to check the password format
    final passwordRegExp = RegExp(r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*])');
    return passwordRegExp.hasMatch(password);
  }

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      // Validation successful, proceed with registration
      final registrationRequest = RegistrationRequest(
          email: _emailController.text,
          password: _passwordController.text,
          phoneNumber: _phoneNumberController.text,
          name: _nameController.text
          //roleName: "Customer",
          );

      try {
        await AuthenticationApi.register(registrationRequest);
        // Registration successful, handle the response as needed
        globalMessage.showSuccessMessage("Your account have been created!");
        await Future.delayed(const Duration(seconds: 10));
        // ignore: use_build_context_synchronously
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } catch (e) {
        // Registration failed, handle the error
        globalMessage.showErrorMessage("Something wrong, please try again!");
        setState(() {
          _errorText = 'Registration failed: $e';
        });
      }
    }
  }
}
