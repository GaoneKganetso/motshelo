import 'package:matimela/src/models/animal.dart';

class AnimalCase extends Animal {
  String description;
  String location;
  String created;
  String reporter;
  AnimalCase(String description, String location, String reporter, String brand, String color,
      String picture, String created)
      : super(brand, color, picture) {
    this.description = description;
    this.location = location;
    this.created = created;
    this.reporter = reporter;
  }

  String toString() {
    return brand;
  }
}
