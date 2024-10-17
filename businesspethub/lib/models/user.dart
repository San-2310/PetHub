import 'dart:convert';

class User {
  final String id;
  final String? name;
  final String email;
  final String password;
  final String address;
  final String type;
  final String token;
  final List<dynamic> cart;
  final String? photoUrl;
  final String username;
  final String fullname;
  final String contactnumber;
  final List<dynamic> pets;  // New field for pets

  User({
    required this.id,
    this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.type,
    required this.token,
    required this.cart,
    this.photoUrl,
    required this.username,
    required this.fullname,
    required this.contactnumber,
    required this.pets,  // Add this line
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'type': type,
      'token': token,
      'cart': cart,
      'photoUrl': photoUrl,
      'username': username,
      'fullname': fullname,
      'contactnumber': contactnumber,
      'pets': pets,  // Add this line
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
      cart: List<Map<String, dynamic>>.from(
        map['cart']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
      photoUrl: map['photoUrl'],
      username: map['username'] ?? '',
      fullname: map['fullname'] ?? '',
      contactnumber: map['contactnumber'] ?? '',
      pets: List<dynamic>.from(map['pets'] ?? []),  // Add this line
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? address,
    String? type,
    String? token,
    List<dynamic>? cart,
    String? photoUrl,
    String? username,
    String? fullname,
    String? contactnumber,
    List<dynamic>? pets,  // Add this line
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      type: type ?? this.type,
      token: token ?? this.token,
      cart: cart ?? this.cart,
      photoUrl: photoUrl ?? this.photoUrl,
      username: username ?? this.username,
      fullname: fullname ?? this.fullname,
      contactnumber: contactnumber ?? this.contactnumber,
      pets: pets ?? this.pets,  // Add this line
    );
  }
}