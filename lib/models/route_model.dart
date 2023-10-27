class Route {
  final String id;
  final String name;
  final String description;
  final String status;
  final String providerId;

  Route({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.providerId,
  });

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      status: json['status'],
      providerId: json['providerId'],
    );
  }
}
