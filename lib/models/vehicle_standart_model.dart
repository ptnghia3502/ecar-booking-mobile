class VehicleStandard {
  final String id;
  final String name;
  final int totalSeat;
  final String licensePlate;
  final String status;
  final String driverId;

  VehicleStandard({
    required this.id,
    required this.name,
    required this.totalSeat,
    required this.licensePlate,
    required this.status,
    required this.driverId,
  });

  factory VehicleStandard.fromJson(Map<String, dynamic> json) {
    final result = json['result'];
    return VehicleStandard(
      id: result['id'],
      name: result['name'],
      totalSeat: result['totalSeat'],
      licensePlate: result['licensePlate'],
      status: result['status'],
      driverId: result['driverId'],
    );
  }
}
