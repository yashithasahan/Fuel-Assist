// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String address;
  final String type;
  final String token;
  final bool isInQueue;
  final bool isFulled;
  final int duration;
  final String stationId;
  final int date;
  final String vehicleType;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.type,
    required this.token,
    required this.isInQueue,
    required this.isFulled,
    required this.duration,
    required this.stationId,
    required this.date,
    required this.vehicleType,
  });

  User copyWith({
    String? id,
    String? name,
    String? password,
    String? email,
    String? address,
    String? type,
    String? token,
    bool? isInQueue,
    bool? isFulled,
    int? duration,
    String? stationId,
    int? date,
    String? vehicleType,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      password: password ?? this.password,
      email: email ?? this.email,
      address: address ?? this.address,
      type: type ?? this.type,
      token: token ?? this.token, 
      date: date ?? this.date,
      duration: duration ?? this.duration,
      isFulled: isFulled ?? this.isFulled,
      isInQueue: isInQueue ?? this.isInQueue,
      stationId: stationId ?? this.stationId, 
      vehicleType: vehicleType ?? this.vehicleType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'type': type,
      'token': token,
      'isInQueue': isInQueue,
      'isFulled': isFulled,
      'duration': duration,
      'stationId': stationId,
      'date': date,
      'vehicleType': vehicleType,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      address: map['address'] as String,
      type: map['type'] as String,
      token: map['token'] as String,
      isInQueue: map['isInQueue'] as bool,
      isFulled: map['isFulled'] as bool,
      duration: map['duration'] as int,
      stationId: map['stationId'] as String,
      date: map['date'] as int,
      vehicleType: map['vehicleType'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, name: $name, password: $password,email: $email, address: $address, type: $type, token: $token,isInQueue : $isInQueue, isFulled : $isFulled, duration : $duration, stationId : $stationId ,date : $date, vehicleType:$vehicleType,)';
  }
        
  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.password == password &&
        other.email == email &&
        other.address == address &&
        other.type == type &&
        other.token == token &&
        other.isInQueue == isInQueue &&
        other.isFulled == isFulled &&
        other.duration == duration &&
        other.stationId == stationId &&
        other.date == date &&
        other.vehicleType == vehicleType;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        password.hashCode ^
        email.hashCode ^
        address.hashCode ^
        type.hashCode ^
        token.hashCode ^
        isInQueue.hashCode ^
        isFulled.hashCode ^
        duration.hashCode ^
        stationId.hashCode ^
        hashCode.hashCode ^
        vehicleType.hashCode;
  }
}
