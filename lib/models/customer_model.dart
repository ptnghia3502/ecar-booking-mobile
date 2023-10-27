class Customer {
  final String id;
  late final String? name;
  final bool? sex; // Change the data type to bool
  final String? dateOfBirth;
  final String? email;
  final String? phoneNumber;
  final String status;

  Customer({
    required this.id,
    this.name,
    this.sex,
    this.dateOfBirth,
    this.email,
    this.phoneNumber,
    required this.status,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      sex: json['sex'],
      dateOfBirth: json['dateOfBirth'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      status: json['status'],
    );
  }
}
