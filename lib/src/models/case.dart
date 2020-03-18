import 'package:flutter/cupertino.dart';

@immutable
class AnimalCase {
  final String description;
  final String location;
  final String brand;
  final String color;
  final String created;
  final String picture;
  final String author;
  final String owner;

  AnimalCase(
      {this.description,
      this.color,
      this.brand,
      this.location,
      this.picture,
      this.created,
      this.author,
      this.owner});

  String toString() {
    return brand;
  }
}
