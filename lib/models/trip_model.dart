import 'route_model.dart';
import 'vehicle_model.dart';

class Trip {
  final String id;
  final String name;
  final int distance;
  final int seatRemain;
  final int rating;
  final int price;
  final Route route;
  final Vehicle vehicle;
  final DateTime startedDate;
  final String status;

  Trip({
    required this.id,
    required this.name,
    required this.distance,
    required this.seatRemain,
    required this.rating,
    required this.price,
    required this.route,
    required this.vehicle,
    required this.startedDate,
    required this.status,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'],
      name: json['name'],
      distance: json['distance'],
      seatRemain: json['seatRemain'],
      rating: json['rating'],
      price: json['price'],
      route: Route.fromJson(json['route']),
      vehicle: Vehicle.fromJson(json['vehicle']),
      startedDate: DateTime.parse(json['startedDate']),
      status: json['status'],
    );
  }
}
