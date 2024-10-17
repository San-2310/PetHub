import 'dart:convert';

class Pet {
  final String id;
  final String name;
  final String species;
  final String breed;
  final int age;
  final String ownerId;
  final String qrCodeLink;
  final String pic;
  final DateTime createdAt;
  final DateTime updatedAt;

  Pet({
    required this.id,
    required this.name,
    required this.species,
    required this.breed,
    required this.age,
    required this.ownerId,
    required this.qrCodeLink,
    required this.pic,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'species': species,
      'breed': breed,
      'age': age,
      'ownerId': ownerId,
      'qrCodeLink': qrCodeLink,
      'pic': pic,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory Pet.fromMap(Map<String, dynamic> map) {
    return Pet(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      species: map['species'] ?? '',
      breed: map['breed'] ?? '',
      age: map['age']?.toInt() ?? 0,
      ownerId: map['owner'] ?? '',
      qrCodeLink: map['qrCodeLink'] ?? '',
      pic: map['pic'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Pet.fromJson(String source) => Pet.fromMap(json.decode(source));

  Pet copyWith({
    String? id,
    String? name,
    String? species,
    String? breed,
    int? age,
    String? ownerId,
    String? qrCodeLink,
    String? pic,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Pet(
      id: id ?? this.id,
      name: name ?? this.name,
      species: species ?? this.species,
      breed: breed ?? this.breed,
      age: age ?? this.age,
      ownerId: ownerId ?? this.ownerId,
      qrCodeLink: qrCodeLink ?? this.qrCodeLink,
      pic: pic ?? this.pic,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}