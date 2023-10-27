class RegistrationRequest {
  final String email;
  final String password;
  final String phoneNumber;
  final String name;
  //final String roleName;

  RegistrationRequest({
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.name,
    //this.roleName = 'Customer',
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'name': name
      //'roleName': roleName,
    };
  }
}
