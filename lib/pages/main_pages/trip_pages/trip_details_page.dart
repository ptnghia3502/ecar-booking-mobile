import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ecar_booking_mobile/models/trip_model.dart';
import 'package:ecar_booking_mobile/services/api_services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../../../models/order_createdto_model.dart';
import 'components/provider_detail_dialog.dart';
import 'components/route_detail_dialog.dart';
import 'components/vehicle_detail_dialog.dart';

class TripDetailsPage extends StatefulWidget {
  final Trip trip;

  TripDetailsPage(this.trip);

  @override
  _TripDetailsPageState createState() => _TripDetailsPageState();
}

class _TripDetailsPageState extends State<TripDetailsPage> {
  // Variables to store the trip details
  String tripName = '';
  int price = 0;
  String formattedDate = '';
  int seatRemain = 0;
  String vehicleName = '';
  String routeName = '';
  int distance = 0;
  int rating = 0;
  String status = '';

  String vehicleId = '';
  String routeId = '';
  String providerId = '';
  String driverId = '';

  int selectedQuantity = 1;
  TextEditingController orderNameController = TextEditingController();

  void showOrderDialog(BuildContext context) {
    // Ensure that trip details are fetched before showing the dialog
    if (tripName.isEmpty || price == 0 || seatRemain == 0) {
      // Fetch the details and show the dialog when they are available
      fetchTripDetails().then((_) {
        _showOrderDialog(context);
      });
    } else {
      // If details are already available, show the dialog immediately
      _showOrderDialog(context);
    }
  }

  void _showOrderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Create Order'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(tripName),
                  Text('Price: \$${price.toStringAsFixed(2)}'),
                  Text('Available Seats: $seatRemain'),
                  TextField(
                    controller: orderNameController,
                    decoration:
                        const InputDecoration(labelText: 'Name your order'),
                  ),
                  Row(
                    children: [
                      const Text('Select Quantity: '),
                      DropdownButton<int>(
                        value: selectedQuantity,
                        items: List.generate(seatRemain, (index) => index + 1)
                            .map((quantity) {
                          return DropdownMenuItem<int>(
                            value: quantity,
                            child: Text(quantity.toString()),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedQuantity = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    createOrder();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Create Order'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void createOrder() {
    final orderDto = OrderCreatedDto(
      name: orderNameController.text,
      tickets: [
        OrderTicketDto(
          tripId: widget.trip.id,
          quantity: selectedQuantity,
          name: tripName,
        ),
      ],
    );

    ApiService.createOrder(orderDto).then((response) {
      if (response.statusCode == 201) {
        // Order creation successful
        final Map<String, dynamic> orderResponse = json.decode(response.body);

        if (orderResponse.containsKey("id")) {
          final String orderId = orderResponse["id"] as String;

          // Handle order creation success
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Order created successfully.'),
            ),
          );

          // Now use the orderId to make the createPayment API call
          ApiService.createPayment(orderId);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to retrieve orderId from the response.'),
            ),
          );
        }
      } else {
        // Handle order creation failure
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create order: ${response.statusCode}'),
          ),
        );
      }
    }).catchError((error) {
      // Handle other errors, such as network issues
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    // Fetch the details of the trip when the page loads
    fetchTripDetails();
  }

  Future<void> fetchTripDetails() async {
    try {
      Trip tripDetails = await ApiService.getTripById(widget.trip.id);
      setState(() {
        tripName = tripDetails.name;
        price = tripDetails.price;
        formattedDate =
            DateFormat('dd-MM-yyyy').format(tripDetails.startedDate);
        seatRemain = tripDetails.seatRemain;
        vehicleName = tripDetails.vehicle.name;
        routeName = tripDetails.route.name;
        distance = tripDetails.distance;
        rating = tripDetails.rating;
        status = tripDetails.status;

        vehicleId = tripDetails.vehicle.id;
        routeId = tripDetails.route.id;
        providerId = tripDetails.route.providerId;
        driverId = tripDetails.vehicle.driverId;
      });
    } catch (e) {
      // Handle errors or exceptions here
      print('Error fetching trip details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Trip Details',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add the banner image here
            Image.asset(
              'lib/assets/images/trip_banner.jpg',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tripName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.orange,
                    ),
                  ),
                  Text(
                    '\$${price.toStringAsFixed(2)} • Seat Remain: $seatRemain',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Started Date: $formattedDate',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text('Distance: $distance Kilometers',
                      style: const TextStyle(fontSize: 18)),
                  Row(
                    children: [
                      Visibility(
                        visible: status == "Active",
                        replacement: const Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 20,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 20,
                        ),
                      ),
                      Text(
                        status,
                        style: TextStyle(
                          fontSize: 20,
                          color: status == "Active" ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      RatingBar(
                        itemSize: 24,
                        initialRating: 4,
                        minRating: 1,
                        maxRating: 5,
                        allowHalfRating: true,
                        ratingWidget: RatingWidget(
                          empty: const Icon(
                            Icons.star_border,
                            color: Colors.amber,
                          ),
                          full: const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          half: const Icon(
                            Icons.star_half_sharp,
                            color: Colors.amber,
                          ),
                        ),
                        onRatingUpdate: (value) => null,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              VehicleDetailDialog.show(context, vehicleId);
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  Colors.orangeAccent, // Text color
                              minimumSize: const Size(double.infinity,
                                  48), // Make button full-width
                            ),
                            child: const Text(
                              'View Vehicle',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(
                            width: 16), // Add a gap between the buttons
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              ProviderDetailDialog.show(context, providerId);
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  Colors.orangeAccent, // Text color
                              minimumSize: const Size(double.infinity,
                                  48), // Make button full-width
                            ),
                            child: const Text(
                              'View Provider',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        RouteDetailDialog.show(context, routeId);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue, // Text color
                        minimumSize: const Size(
                            double.infinity, 48), // Make button full-width
                      ),
                      child: const Text(
                        'View Route Details',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.green), // Border color
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          _showOrderDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.green[600],
                          backgroundColor: Colors.green,
                          minimumSize: const Size(double.infinity, 48),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons
                                  .shopping_cart, // You can use any desired icon
                              color: Colors.white,
                            ),
                            SizedBox(
                                width:
                                    8), // Add spacing between the icon and text
                            Text(
                              'Buy Ticket',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
