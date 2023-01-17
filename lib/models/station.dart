import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Station {
  final String name;
  final String city;
  final String district;
  final String description;
  final int regId;
  final String id;
  final String userId;
  final bool isPetrolAvailable;
  final int petrolVolume;
  final int petrolDate;
  final bool isDieselAvailable;
  final int dieslVoulme;
  final int dieslDate;

  Station({
    required this.name,
    required this.city,
    required this.district,
    required this.description,
    required this.regId,
    required this.id,
    required this.userId,
    required this.isPetrolAvailable,
    required this.petrolVolume,
    required this.petrolDate,
    required this.isDieselAvailable,
    required this.dieslVoulme,
    required this.dieslDate,
  });
  Station copyWith({
    String? id,
    String? name,
    String? city,
    String? district,
    String? description,
    int? regId,
    String? userId,
    int? petrolVolume,
    bool? isPetrolAvailable,
    int? petrolDate,
    bool? isDieselAvailable,
    int? dieslVoulme,
    int? dieslDate,
  }) {
    return Station(
      id: id ?? this.id,
      name: name ?? this.name,
      city: city ?? this.city,
      district: district ?? this.district,
      description: description ?? this.description,
      regId: regId ?? this.regId,
      userId: userId ?? this.userId,
      petrolVolume: petrolVolume ?? this.petrolVolume,
      isPetrolAvailable: isPetrolAvailable ?? this.isPetrolAvailable,
      isDieselAvailable: isDieselAvailable ?? this.isDieselAvailable,
      petrolDate: petrolDate ?? this.petrolDate,
      dieslDate: dieslDate ?? this.dieslDate,
      dieslVoulme: dieslVoulme ?? this.dieslVoulme,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'city': city,
      'district': district,
      'description': description,
      'regId': regId,
      'id': id,
      'userId': userId,
      'isPetrolAvailable': isPetrolAvailable,
      'petrolVolume': petrolVolume,
      'petrolDate': petrolDate,
      'isDieselAvailable': isDieselAvailable,
      'dieslVoulme': dieslVoulme,
      'dieslDate': dieslDate
    };
  }

  factory Station.fromMap(Map<String, dynamic> map) {
    return Station(
      name: map['name'] as String,
      city: map['city'] as String,
      district: map['district'] as String,
      description: map['description'] as String,
      regId: map['regId'] as int,
      id: map['_id'] as String,
      userId: map['userId'] as String,
      isPetrolAvailable: map['isPetrolAvailable'] as bool,
      petrolVolume: map['petrolVolume'] as int,
      petrolDate: map['petrolDate'] as int,
          
      isDieselAvailable: map['isDieselAvailable'] as bool,
      dieslVoulme: map['dieslVoulme'] as int,
      dieslDate: map['dieslDate'] as int
          
    );
  }

  String toJson() => json.encode(toMap());

  factory Station.fromJson(String source) =>
      Station.fromMap(json.decode(source) as Map<String, dynamic>);
}
