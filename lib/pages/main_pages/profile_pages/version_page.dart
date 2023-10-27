import 'package:flutter/material.dart';

class VersionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.orangeAccent, // Set the background color
      body: Center(
        child: Text(
          'Version 2023.10.27.0069',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white, // Set the text color to white
          ),
        ),
      ),
    );
  }
}
