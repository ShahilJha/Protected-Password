// To parse this JSON data, do
//
//     final passwordBox = passwordBoxFromMap(jsonString);

import 'dart:convert';

PasswordBox passwordBoxFromMap(Map<String, dynamic> map) =>
    PasswordBox.fromMap(map);

Map<String, dynamic> passwordBoxToMap(PasswordBox data) => data.toMap();

class PasswordBox {
  PasswordBox({
    this.id,
    this.address,
    this.password,
  });

  int? id;
  String? address;
  List<Password>? password;

  factory PasswordBox.fromMap(Map<String, dynamic> map) => PasswordBox(
        id: map["id"],
        address: map["address"],
        password: List<Password>.from(
            map["password"].map((x) => Password.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "address": address,
        "password": List<dynamic>.from(password!.map((x) => x.toMap())),
      };
}

class Password {
  Password({
    this.id,
    this.associatedEntity,
    this.userName,
    this.password,
  });

  int? id;
  String? associatedEntity;
  String? userName;
  String? password;

  factory Password.fromMap(Map<String, dynamic> map) => Password(
        id: map["id"],
        associatedEntity: map["associatedEntity"],
        userName: map["userName"],
        password: map["password"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "associatedEntity": associatedEntity,
        "userName": userName,
        "password": password,
      };
}
