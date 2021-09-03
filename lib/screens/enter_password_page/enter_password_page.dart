import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:protected_password/models/password_box_basic_data.dart';
import 'package:protected_password/models/temp_box.dart';
import 'package:protected_password/services/box_key.dart';
import 'package:protected_password/utils/utility.dart';

class EnterPasswordPage extends StatefulWidget {
  final PasswordBoxBasicData basicData;
  const EnterPasswordPage({required this.basicData, Key? key})
      : super(key: key);

  @override
  _EnterPasswordPageState createState() => _EnterPasswordPageState();
}

class _EnterPasswordPageState extends State<EnterPasswordPage> {
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Container(
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
                Text(
                  widget.basicData.address,
                  style: TextStyle(
                    fontSize: 50.sp,
                  ),
                ),
                Spacer(),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.center,
                  obscureText: true,
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    hoverColor: Colors.white,
                    labelText: 'Password Box Key',
                    prefixIcon: Icon(Icons.vpn_key),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {
                        if (Utility.getKeyDigestString(password) ==
                            widget.basicData.hash) {
                          BoxKey.key = password;

                          TempBox.instance.id = widget.basicData.id;
                          TempBox.instance.address = widget.basicData.address;
                          TempBox.instance.hash = widget.basicData.hash;

                          //redirect to password box page
                          Navigator.of(context).pushNamed(
                            '/password_box_page',
                            arguments: widget.basicData,
                          );
                        } else {
                          Utility.showSnackBar(context,
                              message: 'Wrong Box Key');
                        }
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
                    setState(() {
                      password = value;
                    });
                  },
                ),
                Spacer(),
                // IconButton(
                //   splashColor: Theme.of(context).accentColor,
                //   color: Theme.of(context).primaryColor,
                //   hoverColor: Theme.of(context).primaryColor,
                //   icon: Icon(Icons.arrow_forward),
                //   onPressed: () {},
                // ),
                // Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
