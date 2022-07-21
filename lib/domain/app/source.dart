import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Source extends Equatable {
  final String name;
  final DateTime createdAt;
  const Source({
    required this.name,
    required this.createdAt,
  });

  Source copyWith({
    String? name,
    DateTime? createdAt,
  }) {
    return Source(
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory Source.fromMap(Map<String, dynamic> map) {
    return Source(
      name: map['name'] ?? '',
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Source.fromJson(String source) => Source.fromMap(json.decode(source));

  @override
  String toString() => 'Source(name: $name, createdAt: $createdAt)';

  @override
  List<Object> get props => [name, createdAt];
}
