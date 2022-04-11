class Geo {
  final double lat, lng;

  Geo.fromMap(Map<String, dynamic> payload)
      : lat = payload["lat"],
        lng = payload["lng"];

  Map<String, double> toMap() {
    return {
      "lat": lat,
      "lng": lng,
    };
  }
}
