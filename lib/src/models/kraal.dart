import 'package:matimela/src/models/animal.dart';

class Kraal extends Animal {
  String _location;
  String _owner;
  int _size;

  Kraal(String brand, String color, String picture) : super(brand, color, picture);

  // ignore: unnecessary_getters_setters
  String get location => _location;
  // ignore: unnecessary_getters_setters
  String get owner => _owner;
  // ignore: unnecessary_getters_setters
  int get size => _size;

  // ignore: unnecessary_getters_setters
  set owner(String value) {
    _owner = value;
  }

  // ignore: unnecessary_getters_setters
  set size(int value) {
    _size = value;
  }

  // ignore: unnecessary_getters_setters
  set location(String value) {
    _location = value;
  }
}
