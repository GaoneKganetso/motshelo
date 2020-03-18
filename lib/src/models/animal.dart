class Animal {
  String _brand;

  String get brand => _brand;

  set brand(String value) {
    _brand = value;
  }

  String _color;
  String _created;
  String _picture;
  String _owner;

  Animal(String brand, String color, String picture) {
    this._color = color;
    this._brand = brand;
    this._picture = picture;
  }

  String toString() {
    return _brand;
  }

  // ignore: unnecessary_getters_setters
  String get created => _created;
  String get picture => _picture;
  String get owner => _owner;
  String get color => _color;

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
}
