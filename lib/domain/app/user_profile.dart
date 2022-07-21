import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:moneybag/domain/app/source.dart';

class UserProfile extends Equatable {
  final String name;
  final String id;
  final String email;
  final List<Source> sources;
  const UserProfile({
    required this.name,
    required this.id,
    required this.email,
    required this.sources,
  });

  UserProfile copyWith({
    String? name,
    String? id,
    String? email,
    List<Source>? sources,
  }) {
    return UserProfile(
      name: name ?? this.name,
      id: id ?? this.id,
      email: email ?? this.email,
      sources: sources ?? this.sources,
    );
  }

  factory UserProfile.empty() =>
      const UserProfile(name: '', id: '', email: '', sources: []);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'email': email,
      'sources': sources.map((x) => x.toMap()).toList(),
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      name: map['name'] ?? '',
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      sources: List<Source>.from(map['sources']?.map((x) => Source.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfile.fromJson(String source) =>
      UserProfile.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserProfile(name: $name, id: $id, email: $email, sources: $sources)';
  }

  @override
  List<Object> get props => [name, id, email, sources];
}
