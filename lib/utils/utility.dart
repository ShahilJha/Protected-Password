import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Utility {
  static Future<dynamic> showSnackBar(BuildContext context,
      {required String message}) async {
    Timer timer = Timer(Duration(milliseconds: 2000), () {
      Navigator.of(context, rootNavigator: true).pop();
    });
    return showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 50.h),
            height: 0.07.sh,
            width: 0.8.sw,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: Theme.of(context).primaryColor),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    ).then((value) {
      // dispose the timer in case something else has triggered the dismiss.
      timer.cancel();
    });
  }

  static Future<dynamic> showProcessingPopUp(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            width: 300.w,
            height: 300.w,
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  static String getKeyDigestString(String key) {
    var bytes = utf8.encode(key); // data being hashed
    var digest = sha1.convert(bytes); //Hashing Process using SHA1
    return digest.toString();
  }

  static String prepareKey(String key) {
    String processedKey = '';
    int maxLength = 32;
    List<int> characterList = key.codeUnits;
    List<String> stringList = [];
    //String key to stringList
    for (var i in characterList) {
      stringList.add(String.fromCharCode(i));
    }
    //stringList to processedKey
    for (int x = 0; x < maxLength; x++) {
      processedKey = processedKey + stringList[x % stringList.length];
    }

    //return processed key
    return processedKey;
  }

  static String encryptString(String str, String boxKey) {
    final key = encrypt.Key.fromUtf8(prepareKey(boxKey));
    final iv = encrypt.IV.fromLength(16);
    dynamic encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = encrypter.encrypt(str, iv: iv);
    return encrypted.base64;
  }

  static String decryptString(String str, String boxKey) {
    final key = encrypt.Key.fromUtf8(prepareKey(boxKey));
    final iv = encrypt.IV.fromLength(16);
    dynamic encrypter = encrypt.Encrypter(encrypt.AES(key));

    final String decrypted =
        encrypter.decrypt(encrypt.Encrypted.fromBase64(str), iv: iv);
    return decrypted;
  }

  static String generatePassword({
    bool letter = true,
    bool isNumber = true,
    bool isSpecial = true,
  }) {
    final length = 20;
    final letterLowerCase = "abcdefghijklmnopqrstuvwxyz";
    final letterUpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    final number = '0123456789';
    final special = '@#%^*>\$@?/[]=+';

    String chars = "";
    if (letter) chars += '$letterLowerCase$letterUpperCase';
    if (isNumber) chars += '$number';
    if (isSpecial) chars += '$special';

    return List.generate(length, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);
      return chars[indexRandom];
    }).join('');
  }
}
