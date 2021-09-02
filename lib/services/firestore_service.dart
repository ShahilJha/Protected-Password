import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:protected_password/models/password_box.dart';
import 'package:protected_password/models/password_box_basic_data.dart';
import 'package:protected_password/utils/utility.dart';

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
          .where('id', isEqualTo: data.id)
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

  Future<void> createPasswordBox(PasswordBox box, String hash) async {
    try {
      DocumentReference reference = _firestore.collection('PasswordBox').doc();
      box.id = reference.id;
      reference.set(passwordBoxToMap(box));

      _firestore.collection('BasicData').add(
            passwordBoxBasicDataToMap(
              PasswordBoxBasicData(
                id: box.id,
                address: box.address,
                hash: hash,
              ),
            ),
          );
    } catch (e) {
      print('EXCEPTION: -createPasswordBox--> $e');
    }
  }

  Future<void> updatePasswordBox(PasswordBox box) async {
    try {
      _firestore
          .collection('PasswordBox')
          .where('id', isEqualTo: box.id)
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
          .where('id', isEqualTo: box.id)
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

      //todo:encrypt data using newKey

      //todo:updatePasswordBox(box)
    } catch (e) {
      print('EXCEPTION: -changePassword--> $e');
    }
  }
}
