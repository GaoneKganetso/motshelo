import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class User {
  final String id, displayName, email, phone;

  User({this.id, this.displayName, this.email, this.phone});

  factory User.fromJson(Map<String,dynamic>json){
    return User(
        id: json['id'],
        displayName: json['displayName'],
        email: json['email'],
        phone: json['phone']
    );
  }
}
class Profile{
  final String id,brandName,surname, name, location;

  Profile({this.id, this.name, this.surname, this.brandName, this.location});

  factory Profile.fromJson(DocumentSnapshot json){
    return Profile(
        id: json.documentID,
        name: json.data['name'],
        surname: json.data['surname'],
        brandName: json.data['brandName'],
        location: json.data['location'],
    );
  }
}


