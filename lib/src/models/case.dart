import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matimela/src/models/animal.dart';

class AnimalCase extends Animal {

  AnimalCase(String description, Timestamp date, String reporter, String brand, String color, String tag, String picture)
      : super(brand, color, picture, tag) {
    this.description = description;
    this.lastSeen = date != null ? date.toDate().toString() : '';
    this.reporter = reporter;
  }

  String created;
  String description;
  String lastSeen;
  String reporter;

  String toString() {
    return brand;
  }
}
