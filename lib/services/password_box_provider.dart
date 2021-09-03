import 'package:flutter/material.dart';
import 'package:protected_password/models/password_box.dart';
import 'package:protected_password/services/firestore_service.dart';

class PasswordBoxProvider extends ChangeNotifier {
  PasswordBox passwordBox =
      PasswordBox(id: "Error", address: "Error", passwords: []);

  // void setPasswordBox(PasswordBox box) {
  //   this.passwordBox = box;
  //   notifyListeners();
  // }

  int getIndex(Password password) {
    int index = passwordBox.passwords
        .indexWhere((element) => element.id == password.id);
    return index;
  }

  void addPassword(Password password) {
    passwordBox.passwords.add(password);
    notifyListeners();
  }

  void editPassword(Password password) {
    passwordBox.passwords[getIndex(password)] = password;
    notifyListeners();
  }

  void deletePassword(Password password) {
    passwordBox.passwords.removeAt(getIndex(password));
    notifyListeners();
  }

  Password getPassword(String id) {
    int index = passwordBox.passwords.indexWhere((element) => element.id == id);
    return passwordBox.passwords[index];
  }

  List<Password> showAllPassword() => passwordBox.passwords;

  void deleteBox() => DatabaseService.instance.deletePasswordBox(passwordBox);

  void saveBox() => DatabaseService.instance.updatePasswordBox(passwordBox);

  void changeBoxKey(String newKey) =>
      DatabaseService.instance.changePassword(passwordBox, newKey);
}
