class Ticket {
  final String id;
  final String tripId;
  final String name;
  final String orderId;
  final double price;

  Ticket({
    required this.id,
    required this.tripId,
    required this.name,
    required this.orderId,
    required this.price,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      tripId: json['tripId'],
      name: json['name'],
      orderId: json['orderId'],
      price: json['price'].toDouble(),
    );
  }
}
