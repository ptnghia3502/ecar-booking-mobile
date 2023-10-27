import 'package:flutter/material.dart';

class ChangePassPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.orangeAccent, // Set the background color
      body: Center(
        child: Text(
          'The feature is on maintaining!',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white, // Set the text color to white
          ),
        ),
      ),
    );
  }
}
