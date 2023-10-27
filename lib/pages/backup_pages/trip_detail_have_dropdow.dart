import 'package:flutter/material.dart';
import 'package:ecar_booking_mobile/models/trip_model.dart';
import 'package:ecar_booking_mobile/services/api_services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class TripDetailsPage123 extends StatefulWidget {
  final Trip trip;

  TripDetailsPage123(this.trip);

  @override
  _TripDetailsPage123State createState() => _TripDetailsPage123State();
}

class _TripDetailsPage123State extends State<TripDetailsPage123> {
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

  // Create a list of ExpansionPanel items
  final List<ExpansionPanelItem> _expansionPanelItems = [
    ExpansionPanelItem(
      headerText: 'Vehicle Info',
      bodyText: '', // Initially empty
      isExpanded: false, // Start collapsed
    ),
    ExpansionPanelItem(
      headerText: 'Route Info',
      bodyText: '', // Initially empty
      isExpanded: false, // Start collapsed
    ),
  ];

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

        // Update the ExpansionPanel items with the vehicle and route details
        _expansionPanelItems[0].bodyText = 'Vehicle Name: $vehicleName';
        _expansionPanelItems[1].bodyText = 'Route Name: $routeName';
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
        title: const Text('Trip Details'),
      ),
      body: Column(
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
          ExpansionPanelList(
            elevation: 1,
            expandedHeaderPadding: const EdgeInsets.all(16.0),
            expansionCallback: (int panelIndex, bool isExpanded) {
              setState(() {
                _expansionPanelItems[panelIndex].isExpanded = !isExpanded;
              });
            },
            children: [
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return const ListTile(
                    title: Text('Vehicle Info'),
                  );
                },
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Vehicle Name: $vehicleName'),
                      Text('Total Seats: ${widget.trip.vehicle.totalSeat}'),
                      Text(
                          'License Plate: ${widget.trip.vehicle.licensePlate}'),
                      Text('Status: ${widget.trip.vehicle.status}'),
                    ],
                  ),
                ),
                isExpanded: _expansionPanelItems[0].isExpanded,
              ),
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return const ListTile(
                    title: Text('Route Info'),
                  );
                },
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Route Name: $routeName'),
                      Text('Description: ${widget.trip.route.description}'),
                      Text('Status: ${widget.trip.route.status}'),
                    ],
                  ),
                ),
                isExpanded: _expansionPanelItems[1].isExpanded,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ExpansionPanelItem {
  final String headerText;
  String bodyText;
  bool isExpanded;

  ExpansionPanelItem({
    required this.headerText,
    required this.bodyText,
    required this.isExpanded,
  });
}
