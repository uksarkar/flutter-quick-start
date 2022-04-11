class Str {
  final String _urlSlashKey = "@slash@";
  String? _value;
  Map<String, String>? _params;
  Map<String, dynamic>? _queries;

  Str(String? value) : _value = value;

  bool get isNullOrEmpty {
    return _value == null || _value!.isEmpty;
  }

  bool get isNotNullOrEmpty {
    return !isNullOrEmpty;
  }

  String get value {
    return isNotNullOrEmpty ? _value! : "";
  }

  String get urlEncoded {
    return Uri.encodeFull(_addUrlParams()._addQueries().value);
  }

  Uri get asUri => Uri.parse(_addUrlParams()._addQueries().value);

  Str setUrlParams(Map<String, String>? params) {
    _params = params;
    return this;
  }

  Str _addUrlParams() {
    if (_params == null) return this;

    for (var k in _params!.keys) {
      _value = value.replaceAll(":$k", _params![k]!);
    }

    return this;
  }

  Str setUrlQueries(Map<String, dynamic>? queries) {
    _queries = queries;
    return this;
  }

  Str _addQueries() {
    _value = _queries != null
        ? value +
            "?" +
            _queries!.keys.map((k) {
              return "$k=${_queries![k]}".replaceAll("/", _urlSlashKey);
            }).join("&")
        : value;
    return this;
  }

  String get urlDecoded {
    return Uri.decodeFull(value).replaceAll(_urlSlashKey, "/");
  }

  bool isLength(int comp) {
    return isNotNullOrEmpty && _value!.length == comp;
  }

  bool isLengthGT(int comp) {
    return isNotNullOrEmpty && _value!.length > comp;
  }

  bool isLengthGTorEq(int comp) {
    return isNotNullOrEmpty && _value!.length >= comp;
  }

  bool isLengthLT(int comp) {
    return isNotNullOrEmpty && _value!.length < comp;
  }

  bool isLengthLTorEq(int comp) {
    return isNotNullOrEmpty && _value!.length <= comp;
  }

  static bool isAnyNullOrEmpty(List<String?> payload) {
    return payload
        .map((e) => Str(e))
        .where((element) => element.isNullOrEmpty)
        .isNotEmpty;
  }

  static bool isNotAnyNullOrEmpty(List<String?> payload) {
    return !isAnyNullOrEmpty(payload);
  }

  static bool isAllNullOrEmpty(List<String?> payload) {
    return payload
        .map((e) => Str(e).isNullOrEmpty)
        .where((element) => element == false)
        .isEmpty;
  }
}
