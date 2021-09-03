import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:protected_password/models/password_box.dart';
import 'package:protected_password/services/password_box_provider.dart';
import 'package:protected_password/utils/utility.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddPasswordScreen extends StatelessWidget {
  final websiteTextController = TextEditingController();
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String website = '';
    String username = '';
    String password = '';
    final boxProvider = context.watch<PasswordBoxProvider>();
    return Container(
      width: 600.w,
      height: 500.h,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 20.h,
        horizontal: 30.w,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Container(
            width: 700.w,
            child: TextField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              textAlign: TextAlign.center,
              controller: websiteTextController,
              // obscureText: true,
              decoration: InputDecoration(
                focusColor: Colors.white,
                hoverColor: Colors.white,
                labelText: 'Website Name',
                prefixIcon: Icon(Icons.inbox),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.w),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.w),
                ),
              ),
              onChanged: (value) {
                website = value;
              },
            ),
          ),
          Spacer(),
          Container(
            width: 700.w,
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              textAlign: TextAlign.center,
              controller: usernameTextController,
              // obscureText: true,
              decoration: InputDecoration(
                focusColor: Colors.white,
                hoverColor: Colors.white,
                labelText: 'Username',
                prefixIcon: Icon(Icons.inbox),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.w),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.w),
                ),
              ),
              onChanged: (value) {
                username = value;
              },
            ),
          ),
          Spacer(),
          Container(
            width: 700.w,
            child: TextField(
              controller: passwordTextController,
              textInputAction: TextInputAction.done,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              // obscureText: true,
              decoration: InputDecoration(
                focusColor: Colors.white,
                hoverColor: Colors.white,
                labelText: 'Password',
                prefixIcon: Icon(Icons.inbox),
                suffixIcon: IconButton(
                  icon: Icon(Icons.gamepad),
                  onPressed: () {
                    passwordTextController.text = Utility.generatePassword();
                  },
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.w),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.w),
                ),
              ),
              onChanged: (value) {
                password = value;
              },
            ),
          ),
          Spacer(),
          IconButton(
            splashColor: Theme.of(context).accentColor,
            color: Theme.of(context).primaryColor,
            hoverColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.pop(context);
              boxProvider.addPassword(
                Password(
                  id: Uuid().v1(),
                  associatedEntity: website,
                  userName: username,
                  password: password,
                ),
              );
            },
          ),
          Spacer(),
        ],
      ),
    );
  }
}
