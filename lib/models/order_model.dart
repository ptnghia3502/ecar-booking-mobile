import 'customer_model.dart';
import 'ticket_model.dart';

class Order {
  final String id;
  final String name;
  final DateTime creationDate;
  final double total;
  final String status;
  final Customer customer;
  final List<Ticket> tickets;

  Order({
    required this.id,
    required this.name,
    required this.creationDate,
    required this.total,
    required this.status,
    required this.customer,
    required this.tickets,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      name: json['name'],
      creationDate: DateTime.parse(json['creationDate']),
      total: json['total'].toDouble(),
      status: json['status'],
      customer: Customer.fromJson(json['customer']),
      tickets: (json['tickets'] as List<dynamic>)
          .map((ticketJson) => Ticket.fromJson(ticketJson))
          .toList(),
    );
  }
}
