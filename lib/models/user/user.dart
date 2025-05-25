import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  User({
    required this.id,
    required this.date,
    required this.name,
    required this.email,
    required this.password,
  });
  final int id;
  final DateTime date;
  final String name;
  final String email;
  final String password;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    date: (json['date'] as Timestamp).toDate(),
    name: json['name'],
    email: json['email'],
    password: json['password'],
  );
  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'date': date,
    'name': name,
    'email': email,
    'password': password,
  };

  //TODO: add fromSnapshot
  
}
