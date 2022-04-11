import 'geo.dart';

class Address {
  final String street, suite, city, zipcode;
  final Geo geo;

  Address.fromMap(Map<String, dynamic> payload)
      : street = payload["street"],
        suite = payload["suite"],
        city = payload["city"],
        zipcode = payload["zipcode"],
        geo = Geo.fromMap(payload["geo"]);

  Map<String, dynamic> toMap() {
    return {
      "street": street,
      "suite": suite,
      "city": city,
      "zipcode": zipcode,
      "geo": geo.toMap(),
    };
  }
}
