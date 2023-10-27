import 'package:flutter/material.dart';
import 'package:ecar_booking_mobile/services/api_services.dart';
import 'package:ecar_booking_mobile/models/customer_model.dart';
import 'package:intl/intl.dart';

class ProfileDetailsPage extends StatefulWidget {
  @override
  _ProfileDetailsPageState createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
  Customer? customer;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchCustomerDetails();
  }

  Future<void> _fetchCustomerDetails() async {
    try {
      final fetchedCustomer = await ApiService.getCustomerDetails();
      setState(() {
        customer = fetchedCustomer;
        _nameController.text = customer!.name ?? 'N/A';
        _sexController.text = customer!.sex != null ? 'Male' : 'Female';

        // Format the date of birth
        final dateOfBirth = customer!.dateOfBirth;
        _dateOfBirthController.text = dateOfBirth != null
            ? DateFormat('dd-MM-yyyy').format(DateTime.parse(dateOfBirth))
            : 'N/A';

        _phoneNumberController.text = customer!.phoneNumber ?? 'N/A';
      });
    } catch (e) {
      print('Error fetching customer details: $e');
    }
  }

  Future<void> _updateCustomerInfo() async {
    if (customer != null) {
      // Map the user's input for "Sex" to a boolean
      bool isMale = _sexController.text.toLowerCase() == 'male';

      final updatedCustomerData = {
        "name": _nameController.text != customer!.name
            ? _nameController.text
            : customer!.name,
        "sex": isMale, // Set "sex" based on the boolean value
        "dateOfBirth": _dateOfBirthController.text != customer!.dateOfBirth
            ? _dateOfBirthController.text
            : customer!.dateOfBirth,
        "phoneNumber": _phoneNumberController.text != customer!.phoneNumber
            ? _phoneNumberController.text
            : customer!.phoneNumber,
      };

      try {
        final customerId = customer!.id;
        await ApiService.updateCustomer(customerId, updatedCustomerData);
      } catch (e) {
        print('Error updating customer details: $e');
      }
    } else {
      print("Customer object is null. Unable to update.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Profile Information',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: customer != null
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildTextField('Name', _nameController.text),
                    _buildTextField('Sex', _sexController.text),
                    _buildTextField(
                        'Date of Birth', _dateOfBirthController.text),
                    _buildTextField('Email', customer!.email ?? 'N/A'),
                    _buildTextField(
                        'Phone Number', _phoneNumberController.text),
                    _buildTextField('Status', customer!.status ?? 'N/A'),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          _updateCustomerInfo();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4285F4),
                        ),
                        child: const Text('SAVE',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildTextField(String label, String value) {
    final isReadOnly = label == 'Email' || label == 'Status';
    String displayValue = value;

    if (label == 'Sex') {
      displayValue = customer!.sex != null ? 'Male' : 'Female';
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          TextFormField(
            controller: TextEditingController(text: displayValue),
            readOnly: isReadOnly,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              filled: isReadOnly,
              fillColor:
                  isReadOnly ? const Color.fromARGB(255, 227, 227, 227) : null,
            ),
          ),
        ],
      ),
    );
  }
}
