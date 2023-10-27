class Provider {
  final String? id;
  final String? name;
  final String? address;
  final String? phoneNumber;
  final String? status;
  final String? externalId;
  final List<String> vehicles;

  Provider({
    required this.id,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.status,
    required this.externalId,
    required this.vehicles,
  });

  factory Provider.fromJson(Map<String, dynamic> json) {
    List<String> vehicleList = [];

    if (json['vehicles'] != null && json['vehicles'] is List) {
      for (var vehicle in json['vehicles']) {
        if (vehicle is String) {
          vehicleList.add(vehicle);
        }
      }
    }

    return Provider(
      id: json['id'] as String?,
      name: json['name'] as String?,
      address: json['address'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      status: json['status'] as String?,
      externalId: json['externalId'] as String?,
      vehicles: vehicleList,
    );
  }
}
