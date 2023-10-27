import 'package:flutter/material.dart';

import '../../../../services/api_services.dart';

class ProviderDetailDialog {
  static void show(BuildContext context, String providerId) {
    ApiService.getProviderById(providerId).then((provider) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(
              child: Text(
                'Provider Detail',
                style: TextStyle(
                  color: Colors.orangeAccent, // Set the text color to orange
                  fontWeight: FontWeight.bold, // Make the text bold
                ),
              ),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Display the image at the center-top
                Center(
                  child: Image.asset(
                    'lib/assets/images/provider.jpg',
                    width: 180, // You can adjust the width to your preference
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home_rounded),
                  title: Text('${provider.name}'),
                ),
                ListTile(
                  leading: const Icon(Icons.location_on_rounded),
                  title: Text('Address: ${provider.address}'),
                ),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: Text('Phone: ${provider.phoneNumber}'),
                ),
                ListTile(
                  leading: const Icon(Icons.check_circle),
                  title: Text('Status: ${provider.status}'),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }).catchError((error) {
      print('Error fetching vehicle details: $error');
      // Handle the error as needed
    });
  }
}
