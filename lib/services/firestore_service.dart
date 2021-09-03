import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:protected_password/models/password_box.dart';
import 'package:protected_password/models/password_box_basic_data.dart';
import 'package:protected_password/services/box_key.dart';
import 'package:protected_password/utils/utility.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  DatabaseService._privateConstructor();
  static final instance = DatabaseService._privateConstructor();

  static final _firestore = FirebaseFirestore.instance;
  FirebaseFirestore get firestore => _firestore;

  Future<PasswordBoxBasicData> checkAddress(String address) async {
    try {
      var documentQuery = await _firestore
          .collection('BasicData')
          .where('address', isEqualTo: address)
          .get();
      var document = documentQuery.docs.first.data();
      return passwordBoxBasicDataFromMap(document);
    } catch (e) {
      print('EXCEPTION: -checkAddress--> $e');
    }
    return passwordBoxBasicDataFromMap(
      {"id": "null", "address": "Error", "hash": "Error"},
    );
  }

  Future<PasswordBox> getPasswordBox(PasswordBoxBasicData data) async {
    try {
      var documentQuery = await _firestore
          .collection('PasswordBox')
          .where('id', isEqualTo: Utility.encryptString(data.id, BoxKey.key))
          .get();
      var document = documentQuery.docs.first.data();
      return passwordBoxFromMap(document);
    } catch (e) {
      print('EXCEPTION: -getPasswordBox--> $e');
    }
    return passwordBoxFromMap(
      {
        "id": "null",
        "address": "Error",
        "password": [
          {
            "id": "null",
            "associatedEntity": "Error",
            "userName": "Error",
            "password": "Error"
          }
        ]
      },
    );
  }

  Future<void> createPasswordBox(PasswordBox box) async {
    try {
      DocumentReference reference = _firestore.collection('BasicData').doc();
      reference.set(
        passwordBoxBasicDataToMap(
          PasswordBoxBasicData(
            id: reference.id,
            address: box.address,
            hash: BoxKey.hash,
          ),
        ),
      );

      box.id = reference.id;
      box.passwords.add(
        Password(
          id: Uuid().v1(),
          associatedEntity: "Website",
          userName: "User Name",
          password: "password",
        ),
      );
      _firestore.collection('PasswordBox').add(
            passwordBoxToMap(box),
          );
    } catch (e) {
      print('EXCEPTION: -createPasswordBox--> $e');
    }
  }

  Future<void> updatePasswordBox(PasswordBox box, {String newKey = ''}) async {
    String key = newKey == '' ? BoxKey.key : newKey;

    try {
      _firestore
          .collection('PasswordBox')
          .where('id', isEqualTo: Utility.encryptString(box.id, key))
          .get()
          .then((value) => _firestore
              .collection('PasswordBox')
              .doc(value.docs.first.id)
              .update(passwordBoxToMap(box)));
    } catch (e) {
      print('EXCEPTION: -updatePasswordBox--> $e');
    }
  }

  Future<void> deletePasswordBox(PasswordBox box) async {
    try {
      _firestore
          .collection('PasswordBox')
          .where('id', isEqualTo: Utility.encryptString(box.id, BoxKey.key))
          .get()
          .then((value) => _firestore
              .collection('PasswordBox')
              .doc(value.docs.first.id)
              .delete());

      _firestore
          .collection('BasicData')
          .where('id', isEqualTo: box.id)
          .get()
          .then((value) => _firestore
              .collection('BasicData')
              .doc(value.docs.first.id)
              .delete());
    } catch (e) {
      print('EXCEPTION: -deletePasswordBox--> $e');
    }
  }

  Future<void> changePassword(PasswordBox box, String newKey) async {
    try {
      //todo:change hash value in basicData
      _firestore
          .collection('BasicData')
          .where('id', isEqualTo: box.id)
          .get()
          .then(
            (value) => _firestore
                .collection('BasicData')
                .doc(value.docs.first.id)
                .update(
                  passwordBoxBasicDataToMap(
                    PasswordBoxBasicData(
                      id: box.id,
                      address: box.address,
                      hash: Utility.getKeyDigestString(newKey),
                    ),
                  ),
                ),
          );

      //update the PasswordBox
      updatePasswordBox(box, newKey: newKey);

      //update newKey to BoxKey
      BoxKey.key = newKey;
    } catch (e) {
      print('EXCEPTION: -changePassword--> $e');
    }
  }
}
