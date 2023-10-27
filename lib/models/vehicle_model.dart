class Vehicle {
  final String id;
  final String name;
  final int totalSeat;
  final String licensePlate;
  final String status;
  final String driverId;

  Vehicle({
    required this.id,
    required this.name,
    required this.totalSeat,
    required this.licensePlate,
    required this.status,
    required this.driverId,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      name: json['name'],
      totalSeat: json['totalSeat'],
      licensePlate: json['licensePlate'],
      status: json['status'],
      driverId: json['driverId'],
    );
  }
}
