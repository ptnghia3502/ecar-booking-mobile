class OrderCreatedDto {
  final String name;
  final List<OrderTicketDto> tickets;

  OrderCreatedDto({
    required this.name,
    required this.tickets,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'tickets': tickets.map((ticket) => ticket.toJson()).toList(),
    };
  }
}

class OrderTicketDto {
  final String tripId;
  final int quantity;
  final String name;

  OrderTicketDto({
    required this.tripId,
    required this.quantity,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'tripId': tripId,
      'quantity': quantity,
      'name': name,
    };
  }
}
