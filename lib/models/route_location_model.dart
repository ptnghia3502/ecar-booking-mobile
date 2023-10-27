class RouteLocation {
  final String id;
  final String name;
  final int index;
  final Location location;

  RouteLocation({
    required this.id,
    required this.name,
    required this.index,
    required this.location,
  });

  factory RouteLocation.fromJson(Map<String, dynamic> json) {
    return RouteLocation(
      id: json['id'] as String,
      name: json['name'] as String,
      index: json['index'] as int,
      location: Location.fromJson(json['location']),
    );
  }
}

class Location {
  final String id;
  final String name;
  final LocationType locationType;

  Location({
    required this.id,
    required this.name,
    required this.locationType,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'] as String,
      name: json['name'] as String,
      locationType: LocationType.fromJson(json['locationType']),
    );
  }
}

class LocationType {
  final String id;
  final String name;

  LocationType({
    required this.id,
    required this.name,
  });

  factory LocationType.fromJson(Map<String, dynamic> json) {
    return LocationType(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }
}
