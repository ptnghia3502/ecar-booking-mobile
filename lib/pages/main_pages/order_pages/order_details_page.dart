import 'package:ecar_booking_mobile/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/order_model.dart';
import '../trip_pages/components/route_detail_dialog.dart';

class OrderDetailsPage extends StatelessWidget {
  final Order order;

  OrderDetailsPage({required this.order});

  @override
  Widget build(BuildContext context) {
    ApiService.getTripById(order.tickets[0].tripId).then((tripData) {
      final currentRouteId = tripData.route.id;
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Order Details',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.microwave_outlined,
                          color: Colors.white), // Icon for customer
                      SizedBox(
                          width: 8), // Add some space between the icon and text
                      Text(
                        'Your Ticket',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  for (final ticket in order.tickets)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Ticket Name
                        Row(
                          children: [
                            const Icon(Icons.pages,
                                color: Colors.white), // Icon
                            Text(
                              ticket.name,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        // Ticket ID
                        Row(
                          children: [
                            const Icon(Icons.confirmation_number,
                                color: Colors.white), // Icon
                            Text(
                              'Ticket ID: ${ticket.id.substring(0, 22)}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        // Trip ID
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                color: Colors.white), // Icon
                            Text(
                              'Trip ID: ${ticket.tripId.substring(0, 22)}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        // Total Price
                        Row(
                          children: [
                            const Icon(Icons.attach_money,
                                color: Colors.white), // Icon
                            Text(
                              'Total Price: ${ticket.price}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                      ],
                    )
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.person,
                          color: Colors.white), // Icon for customer
                      SizedBox(
                          width: 8), // Add some space between the icon and text
                      Text(
                        'Customer Information',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.mode_edit_outline_rounded,
                          color: Colors.white), // Icon for customer name
                      const SizedBox(width: 8),
                      Text('Customer Name: ${order.customer.name}',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.wc, color: Colors.white), // Icon for sex
                      const SizedBox(width: 8),
                      Text(
                        'Sex: ${order.customer.sex != null ? (order.customer.sex != null ? 'Male' : 'Female') : 'N/A'}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.cake,
                          color: Colors.white), // Icon for date of birth
                      const SizedBox(width: 8),
                      Text(
                        'Date of Birth: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(order.customer.dateOfBirth!))}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.email,
                          color: Colors.white), // Icon for email
                      const SizedBox(width: 8),
                      Text('Email: ${order.customer.email}',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.phone,
                          color: Colors.white), // Icon for phone number
                      const SizedBox(width: 8),
                      Text('Phone Number: ${order.customer.phoneNumber}',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Icon(Icons.inventory_outlined,
                          color: Colors.white), // Icon for customer
                      SizedBox(
                          width: 8), // Add some space between the icon and text
                      Text(
                        'Order Status',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.shopping_bag,
                          color: Colors.white), // Icon for phone number
                      const SizedBox(width: 8),
                      Text('Order Name: ${order.name}',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          color: Colors.white), // Icon for phone number
                      const SizedBox(width: 8),
                      Text(
                        'Creation Date: ${DateFormat('dd-MM-yyyy').format(order.creationDate)}',
                        style: const TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.monetization_on_outlined,
                          color: Colors.white), // Icon for phone number
                      const SizedBox(width: 8),
                      Text('Creation Date: ${order.total}',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.info_outline_rounded,
                          color: Colors.white), // Icon for phone number
                      const SizedBox(width: 8),
                      Text('Status: ${order.status}',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder<String>(
                future: ApiService.getTripById(order.tickets[0].tripId)
                    .then((tripData) {
                  return tripData.route.id;
                }),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While waiting for the data to load, you can show a loading indicator.
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    // Handle errors here.
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final currentRouteId = snapshot.data;

                    return ElevatedButton(
                      onPressed: () {
                        RouteDetailDialog.show(context, currentRouteId!);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.orangeAccent, // Text color
                        minimumSize: const Size(
                            double.infinity, 48), // Make button full-width
                      ),
                      child: const Text(
                        'View Route Details',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
