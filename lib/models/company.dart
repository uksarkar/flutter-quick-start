class Company {
  final String name, catchPhrase, bs;

  Company.fromMap(Map<String, dynamic> company)
      : bs = company["bs"],
        catchPhrase = company["catchPhrase"],
        name = company["name"];

  Map<String, String> toMap() {
    return {
      "bs": bs,
      "catchPhrase": catchPhrase,
      "name": name,
    };
  }
}
