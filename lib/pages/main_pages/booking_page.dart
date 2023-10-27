import 'package:flutter/material.dart';
import 'package:ecar_booking_mobile/models/trip_model.dart';
import 'package:ecar_booking_mobile/services/api_services.dart';
import 'package:intl/intl.dart';
import 'trip_pages/trip_details_page.dart';

class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  TextEditingController searchController = TextEditingController();
  List<Trip> trips = [];
  List<Trip> filteredTrips = [];

  @override
  void initState() {
    super.initState();
    // Fetch the list of trips when the page loads
    fetchTrips();
  }

  Future<void> fetchTrips() async {
    try {
      List<Trip> tripList = await ApiService.getTrips();
      setState(() {
        trips = tripList;
        filteredTrips = tripList; // Initially, display all trips
      });
    } catch (e) {
      // Handle errors or exceptions here
      print('Error fetching trips: $e');
    }
  }

  void filterTrips(String query) {
    query = query.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        // Display all trips when the query is empty
        filteredTrips = trips;
      } else {
        filteredTrips = trips.where((trip) {
          final name = trip.name.toLowerCase();
          return name.contains(query);
        }).toList();
      }
    });
  }

  void _showTripDetailsPage(Trip trip) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TripDetailsPage(trip),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              onChanged: (query) => filterTrips(query),
              decoration: InputDecoration(
                labelText: "Search trips",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    width: 2.0, // Set the width of the outline
                    color: Colors.black,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    width: 2.0, // Set the width of the outline
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredTrips.length,
              itemBuilder: (context, index) {
                final trip = filteredTrips[index];
                final formattedDate =
                    DateFormat('dd-MM-yyyy').format(trip.startedDate);

                return GestureDetector(
                  onTap: () {
                    _showTripDetailsPage(trip);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(
                        10.0), // Add some gap between items
                    decoration: BoxDecoration(
                      color: Colors.white, // White background
                      borderRadius:
                          BorderRadius.circular(10.0), // Add border radius
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 60.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.orangeAccent,
                            width: 2.0,
                          ),
                        ),
                        child: Image.asset('lib/assets/images/bus.png'),
                      ),
                      title: Text(
                        trip.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.monetization_on),
                              Text('Price: \$${trip.price.toStringAsFixed(2)}'),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.date_range),
                              Text('Started Date: $formattedDate'),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.event_seat),
                              Text('Seat Remain: ${trip.seatRemain}'),
                            ],
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
