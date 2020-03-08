import 'package:flutter/material.dart';

@immutable
class User {
  final String id, displayName, email, phone;

  User({this.id, this.displayName, this.email, this.phone});
}
