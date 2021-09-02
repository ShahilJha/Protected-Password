PasswordBoxBasicData passwordBoxBasicDataFromMap(Map<String, dynamic> map) =>
    PasswordBoxBasicData.fromMap(map);

Map<String, dynamic> passwordBoxBasicDataToMap(PasswordBoxBasicData data) =>
    data.toMap();

class PasswordBoxBasicData {
  PasswordBoxBasicData({
    required this.id,
    required this.address,
    required this.hash,
  });

  String id;
  String address;
  String hash;

  factory PasswordBoxBasicData.fromMap(Map<String, dynamic> json) =>
      PasswordBoxBasicData(
        id: json["id"],
        address: json["address"],
        hash: json["hash"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "address": address,
        "hash": hash,
      };
}
