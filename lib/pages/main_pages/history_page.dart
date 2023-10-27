import 'package:ecar_booking_mobile/services/authentication_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../models/order_model.dart';
import '../../services/api_services.dart';
import 'order_pages/order_details_page.dart'; // Import your API service

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int _selectedTabIndex = 0;
  List<Order> orders = []; // Store orders here

  @override
  void initState() {
    super.initState();
    // Fetch orders when the page is initialized
    _fetchOrders();
  }

  // Function to fetch orders
  void _fetchOrders() {
    final customerId = AuthenticationApi.currentUserId; // Your customer ID

    ApiService.getOrdersForCustomer(customerId).then((data) {
      print("Received ${data.length} orders from the API."); // Debug print
      setState(() {
        orders = data;
      });
    }).catchError((error) {
      print("API call error: $error"); // Debug print
      // Handle error here
    });
  }

  List<Order> getHistoryOrders() {
    final now = DateTime.now();
    return orders.where((order) => order.creationDate.isBefore(now)).toList();
  }

  List<Order> getFutureOrders() {
    final now = DateTime.now();
    return orders.where((order) => order.creationDate.isAfter(now)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          // Title
          Container(
            width: double.infinity,
            color: Colors.black,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'Tickets List',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Tabs
          Container(
            color: Colors.white,
            child: TabBar(
              indicatorColor: Colors.orangeAccent,
              tabs: [
                Tab(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.history,
                        color: _selectedTabIndex == 0
                            ? Colors.orangeAccent
                            : Colors.black,
                      ),
                      Text(
                        'History',
                        style: TextStyle(
                          color: _selectedTabIndex == 0
                              ? Colors.orangeAccent
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.trending_up_rounded,
                        color: _selectedTabIndex == 1
                            ? Colors.orangeAccent
                            : Colors.black,
                      ),
                      Text(
                        'Future Trips',
                        style: TextStyle(
                          color: _selectedTabIndex == 1
                              ? Colors.orangeAccent
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              onTap: (index) {
                setState(() {
                  _selectedTabIndex = index;
                });
              },
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: TabBarView(
                children: [
                  // FIRST TAB
                  ListView.builder(
                    itemCount: getHistoryOrders().length,
                    // separatorBuilder: (context, index) =>
                    //     const Divider(), // Add a divider between items
                    itemBuilder: (context, index) {
                      final order = getHistoryOrders()[index];

                      final formattedDate =
                          DateFormat('dd-MM-yyyy').format(order.creationDate);
                      final formattedStartHour =
                          DateFormat('HH:mm').format(order.creationDate);

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OrderDetailsPage(order: order),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(
                              10.0), // Add some gap between items
                          decoration: BoxDecoration(
                            color: Colors.white, // White background
                            borderRadius: BorderRadius.circular(
                                10.0), // Add border radius
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
                            contentPadding: const EdgeInsets.all(
                                16.0), // Add padding to the ListTile
                            leading: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset('lib/assets/images/ticket.png'),
                              ],
                            ),
                            title: Text(
                              order.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.date_range),
                                    Text('Started Date: $formattedDate'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.access_time),
                                    Text('Start Hour: $formattedStartHour'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.attach_money_rounded),
                                    Text('Total: ${order.total}'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.payment_sharp),
                                    Text('Payment: ${order.status}'),
                                  ],
                                ),
                              ],
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            // Add more details as needed
                          ),
                        ),
                      );
                    },
                  ),

                  // Second tab: List of current items
                  ListView.builder(
                    itemCount: getFutureOrders().length,
                    itemBuilder: (context, index) {
                      final order = getFutureOrders()[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OrderDetailsPage(order: order),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(
                              10.0), // Add some gap between items
                          decoration: BoxDecoration(
                            color: Colors.white, // White background
                            borderRadius: BorderRadius.circular(
                                10.0), // Add border radius
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
                            contentPadding: const EdgeInsets.all(
                                16.0), // Add padding to the ListTile
                            leading: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset('lib/assets/images/ticket.png'),
                              ],
                            ),
                            title: Text(
                              order.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.date_range),
                                    Text(
                                        'Started Date: ${DateFormat('dd-MM-yyyy').format(order.creationDate)}'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.access_time),
                                    Text(
                                        'Start Hour: ${DateFormat('HH:mm').format(order.creationDate)}'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.attach_money_rounded),
                                    Text('Total: ${order.total}'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.payment_sharp),
                                    Text('Payment: ${order.status}'),
                                  ],
                                ),
                              ],
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            // Add more details as needed
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
