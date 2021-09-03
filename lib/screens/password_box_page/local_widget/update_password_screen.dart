import 'package:flutter/material.dart';
import 'package:protected_password/models/password_box.dart';
import 'package:protected_password/services/password_box_provider.dart';
import 'package:protected_password/utils/utility.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdatePasswordScreen extends StatelessWidget {
  final Password password;

  UpdatePasswordScreen({Key? key, required this.password}) : super(key: key);

  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            child: TextFormField(
              initialValue: password.associatedEntity,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              textAlign: TextAlign.center,
              // controller: websiteTextController,
              // obscureText: true,
              decoration: InputDecoration(
                focusColor: Colors.white,
                hoverColor: Colors.white,
                labelText: 'Website Name',
                prefixIcon: Icon(Icons.bookmark_border),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.w),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.w),
                ),
              ),
              onChanged: (value) {
                password.associatedEntity = value;
              },
            ),
          ),
          Spacer(),
          Container(
            width: 700.w,
            child: TextFormField(
              initialValue: password.userName,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              textAlign: TextAlign.center,
              // controller: usernameTextController,
              // obscureText: true,
              decoration: InputDecoration(
                focusColor: Colors.white,
                hoverColor: Colors.white,
                labelText: 'Username',
                prefixIcon: Icon(Icons.person),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.w),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.w),
                ),
              ),
              onChanged: (value) {
                password.userName = value;
              },
            ),
          ),
          Spacer(),
          Container(
            width: 700.w,
            child: TextFormField(
              // initialValue: password.password,
              controller: passwordTextController,
              textInputAction: TextInputAction.done,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              // obscureText: true,
              decoration: InputDecoration(
                focusColor: Colors.white,
                hoverColor: Colors.white,
                labelText: 'Password',
                prefixIcon: Icon(Icons.vpn_key),
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
                password.password = value;
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
              password.password = passwordTextController.text;
              boxProvider.editPassword(password);
            },
          ),
          Spacer(),
        ],
      ),
    );
  }
}
