import 'package:ecar_booking_mobile/services/authentication_api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/customer_model.dart';
import '../models/order_model.dart';
import '../models/order_createdto_model.dart';
import '../models/route_location_model.dart';
import '../models/route_model.dart';
import '../models/trip_model.dart';
import '../models/vehicle_model.dart';
import '../models/provider_model.dart';

class ApiService {
  static const String baseUrl = 'http://14.187.99.91:4201/api';
  static String jwtToken = AuthenticationApi.jwtToken;

  // get all trips
  static Future<List<Trip>> getTrips() async {
    final Uri tripsUrl = Uri.parse('$baseUrl/trips');

    final response = await http.get(
      tripsUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> tripList = json.decode(response.body);
      return tripList.map((json) => Trip.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch trips: ${response.statusCode}');
    }
  }

  // get detail trip by ID
  static Future<Trip> getTripById(String id) async {
    final Uri tripUrl = Uri.parse(
        '$baseUrl/trips/$id'); // Construct the URL with the provided ID
    final response = await http.get(
      tripUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
    );

    if (response.statusCode == 200) {
      final dynamic tripData = json.decode(response.body);
      return Trip.fromJson(tripData);
    } else {
      throw Exception('Failed to fetch trip details: ${response.statusCode}');
    }
  }

  // Get customer details
  static Future<Customer> getCustomerDetails() async {
    final Uri customerDetailsUrl = Uri.parse('$baseUrl/customers/details');

    final response = await http.get(
      customerDetailsUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
    );

    if (response.statusCode == 200) {
      final dynamic customerData = json.decode(response.body);
      return Customer.fromJson(customerData);
    } else {
      throw Exception(
          'Failed to fetch customer details: ${response.statusCode}');
    }
  }

  // Update a customer
  static Future<void> updateCustomer(
      String customerId, Map<String, dynamic> customerData) async {
    final Uri updateCustomerUrl = Uri.parse('$baseUrl/customers/$customerId');

    final response = await http.put(
      updateCustomerUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode(customerData),
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      print('Customer updated successfully');
    } else {
      throw Exception('Failed to update customer: ${response.statusCode}');
    }
  }

  // Get vehicle details by ID
  static Future<Vehicle> getVehicleById(String id) async {
    final Uri vehicleUrl = Uri.parse('$baseUrl/vehicles/$id');

    final response = await http.get(
      vehicleUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
    );

    if (response.statusCode == 200) {
      final dynamic vehicleData = json.decode(response.body);
      return Vehicle.fromJson(vehicleData);
    } else {
      throw Exception(
          'Failed to fetch vehicle details: ${response.statusCode}');
    }
  }

  // Get provider details by ID
  static Future<Provider> getProviderById(String id) async {
    final Uri providerUrl = Uri.parse('$baseUrl/providers/$id');
    final response = await http.get(
      providerUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
    );

    if (response.statusCode == 200) {
      final dynamic providerData = json.decode(response.body);
      return Provider.fromJson(providerData);
    } else {
      throw Exception(
          'Failed to fetch provider details: ${response.statusCode}');
    }
  }

  // Get route details by ID
  static Future<Route> getRouteById(String id) async {
    final Uri providerUrl = Uri.parse('$baseUrl/routes/$id');
    final response = await http.get(
      providerUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
    );

    if (response.statusCode == 200) {
      final dynamic routeData = json.decode(response.body);
      return Route.fromJson(routeData);
    } else {
      throw Exception(
          'Failed to fetch provider details: ${response.statusCode}');
    }
  }

  // Get Route locations by ID
  static Future<List<RouteLocation>> getRouteLocationsById(String id) async {
    final Uri routeLocationsUrl =
        Uri.parse('$baseUrl/routes/$id/route-locations');

    final response = await http.get(
      routeLocationsUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> routeLocationsList = json.decode(response.body);
      return routeLocationsList
          .map((json) => RouteLocation.fromJson(json))
          .toList();
    } else {
      throw Exception(
          'Failed to fetch route locations: ${response.statusCode}');
    }
  }

  // Get orders for a customer by customerId
  static Future<List<Order>> getOrdersForCustomer(String customerId) async {
    final Uri ordersUrl = Uri.parse('$baseUrl/users/$customerId/orders');

    final response = await http.get(
      ordersUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> orderList = json.decode(response.body);
      return orderList.map((json) => Order.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch orders: ${response.statusCode}');
    }
  }

  // Get Order details by ID
  static Future<Order> getOrderById(String id) async {
    final Uri orderUrl = Uri.parse('$baseUrl/orders/$id');

    final response = await http.get(
      orderUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
    );

    if (response.statusCode == 200) {
      final dynamic orderData = json.decode(response.body);
      return Order.fromJson(orderData);
    } else {
      throw Exception('Failed to fetch order details: ${response.statusCode}');
    }
  }

  // Function to create an order
  // static Future<void> createOrder(OrderCreatedDto orderDto) async {
  //   final Uri orderUrl = Uri.parse('$baseUrl/orders');

  //   final response = await http.post(
  //     orderUrl,
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $jwtToken',
  //     },
  //     body: jsonEncode(orderDto.toJson()),
  //   );

  //   if (response.statusCode == 201) {
  //     // Order created successfully
  //     print('Order created successfully.');
  //   } else {
  //     throw Exception('Failed to create an order: ${response.statusCode}');
  //   }
  // }
  static Future<http.Response> createOrder(OrderCreatedDto orderDto) async {
    final Uri orderUrl = Uri.parse('$baseUrl/orders');

    final response = await http.post(
      orderUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode(orderDto.toJson()),
    );

    if (response.statusCode == 201) {
      // Order created successfully
      print('Order created successfully.');
    } else {
      throw Exception('Failed to create an order: ${response.statusCode}');
    }

    return response; // Return the response object
  }

  // Function to create a payment
  static Future<void> createPayment(String orderId) async {
    final Uri orderUrl = Uri.parse('$baseUrl/orders/$orderId/payments');

    final response = await http.post(
      orderUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
    );

    if (response.statusCode == 201) {
      // Order created successfully
      print('Payment created successfully.');
    } else {
      throw Exception('Failed to create a payment: ${response.statusCode}');
    }
  }
}
