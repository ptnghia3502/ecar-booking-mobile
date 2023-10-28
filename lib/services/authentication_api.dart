import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/customer_model.dart';
import '../models/registration_model.dart';
import 'local_variables.dart';

class AuthenticationApi {
  static const String baseUrl = 'http://14.187.99.91:4202/api';
  static const String baseUrl2 = 'http://14.187.99.91:4201/api';

  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    final Uri loginUrl = Uri.parse('$baseUrl/auth');

    final Map<String, String> body = {
      'email': email,
      'password': password,
    };

    final response = await http.post(
      loginUrl,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);

      // Parse and store the token and user information
      LocalVariables.jwtToken = responseBody['token'];

      return responseBody;
    } else {
      throw Exception('Failed to login: ${response.statusCode}');
    }
  }

  static Future<void> register(RegistrationRequest request) async {
    final Uri registerUrl = Uri.parse('$baseUrl/Users');

    final response = await http.post(
      registerUrl,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Create customer successfully
      print('Payment created successfully.');
    } else {
      throw Exception('Failed to register: ${response.statusCode}');
    }
  }

  // Get customer details
  static Future<Customer> getCustomerDetails() async {
    final Uri customerDetailsUrl = Uri.parse('$baseUrl2/customers/details');

    final response = await http.get(
      customerDetailsUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${LocalVariables.jwtToken}',
      },
    );

    if (response.statusCode == 200) {
      final dynamic customerData = json.decode(response.body);

      LocalVariables.currentEmail = customerData['email'];
      LocalVariables.currentUserId = customerData['id'];
      LocalVariables.currentUserName = customerData['name'];

      return Customer.fromJson(customerData);
    } else {
      throw Exception(
          'Failed to fetch customer details: ${response.statusCode}');
    }
  }
}
