import 'package:flutter/material.dart';

import '../../../../services/api_services.dart';

class VehicleDetailDialog {
  static void show(BuildContext context, String vehicleId) {
    ApiService.getVehicleById(vehicleId).then((vehicle) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(
              child: Text(
                'Vehicle Detail',
                style: TextStyle(
                  color: Colors.orangeAccent,
                  fontWeight: FontWeight.bold,
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
                    'lib/assets/images/golf_car.jpg',
                    width: 180, // You can adjust the width to your preference
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.directions_car),
                  title: Text(vehicle.name),
                ),
                ListTile(
                  leading: const Icon(Icons.event_seat),
                  title: Text('Total Seats: ${vehicle.totalSeat}'),
                ),
                ListTile(
                  leading: const Icon(Icons.card_membership_outlined),
                  title: Text('License Plate: ${vehicle.licensePlate}'),
                ),
                ListTile(
                  leading: const Icon(Icons.check_circle),
                  title: Text('Status: ${vehicle.status}'),
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
