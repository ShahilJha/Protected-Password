import 'package:protected_password/services/box_key.dart';
import 'package:protected_password/utils/utility.dart';

PasswordBox passwordBoxFromMap(Map<String, dynamic> map) =>
    PasswordBox.fromMap(map);

Map<String, dynamic> passwordBoxToMap(PasswordBox data) => data.toMap();

class PasswordBox {
  PasswordBox({
    required this.id,
    required this.address,
    required this.passwords,
  });

  String id;
  String address;
  List<Password> passwords;

  factory PasswordBox.fromMap(Map<String, dynamic> map) {
    return PasswordBox(
      id: Utility.decryptString(map["id"], BoxKey.key),
      address: Utility.decryptString(map["address"], BoxKey.key),
      passwords:
          List<Password>.from(map["password"].map((x) => Password.fromMap(x))),
    );
  }

  Map<String, dynamic> toMap() => {
        "id": Utility.encryptString(id, BoxKey.key),
        "address": Utility.encryptString(address, BoxKey.key),
        "password": List<dynamic>.from(passwords.map((x) => x.toMap())),
      };
}

class Password {
  Password({
    required this.id,
    required this.associatedEntity,
    required this.userName,
    required this.password,
  });

  String id;
  String associatedEntity;
  String userName;
  String password;

  factory Password.fromMap(Map<String, dynamic> map) => Password(
        id: Utility.decryptString(map["id"], BoxKey.key),
        associatedEntity:
            Utility.decryptString(map["associatedEntity"], BoxKey.key),
        userName: Utility.decryptString(map["userName"], BoxKey.key),
        password: Utility.decryptString(map["password"], BoxKey.key),
      );

  Map<String, dynamic> toMap() => {
        "id": Utility.encryptString(id, BoxKey.key),
        "associatedEntity": Utility.encryptString(associatedEntity, BoxKey.key),
        "userName": Utility.encryptString(userName, BoxKey.key),
        "password": Utility.encryptString(password, BoxKey.key),
      };
}
