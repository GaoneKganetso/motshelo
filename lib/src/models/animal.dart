class Animal {
  String _brand;
  String _color;
  String _created;
  String _picture;
  String _owner;
  String _tag;

  Animal(String brand, String color, String picture, String tag) {
    this._color = color;
    this._brand = brand;
    this._picture = picture;
    this._tag = tag;
  }

  String toString() {
    return _tag;
  }

  // ignore: unnecessary_getters_setters
  String get created => _created;
  String get picture => _picture;
  String get owner => _owner;
  String get color => _color;
  String get tag => _tag;
  String get brand => _brand;

  set brand(String value) {
    _brand = value;
  }

  // ignore: unnecessary_getters_setters
  set color(String value) {
    _color = value;
  }

  // ignore: unnecessary_getters_setters
  set created(String value) {
    _created = value;
  }

  // ignore: unnecessary_getters_setters
  set picture(String value) {
    _picture = value;
  }

  // ignore: unnecessary_getters_setters
  set owner(String value) {
    _owner = value;
  }

  set tag(String value) => _tag = value;
}
