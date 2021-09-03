import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:protected_password/models/password_box_basic_data.dart';
import 'package:protected_password/models/temp_box.dart';
import 'package:protected_password/services/box_key.dart';
import 'package:protected_password/services/firestore_service.dart';
import 'package:protected_password/utils/utility.dart';

class BoxCreatePage extends StatefulWidget {
  final String address;
  const BoxCreatePage({required this.address, Key? key}) : super(key: key);

  @override
  _BoxCreatePageState createState() => _BoxCreatePageState();
}

class _BoxCreatePageState extends State<BoxCreatePage> {
  bool isPasswordVisible = true;
  bool isRePasswordVisible = true;
  String createdKey = '';
  String recreatedKey = '';

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
                  widget.address,
                  style: TextStyle(
                    fontSize: 50.sp,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100.w),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    textAlign: TextAlign.center,
                    obscureText: isPasswordVisible,
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      hoverColor: Colors.white,
                      labelText: 'Enter Key',
                      prefixIcon: Icon(Icons.vpn_key),
                      suffixIcon: IconButton(
                        icon: isPasswordVisible
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        onPressed: () => setState(
                            () => isPasswordVisible = !isPasswordVisible),
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
                        createdKey = value;
                      });
                    },
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100.w),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    textAlign: TextAlign.center,
                    obscureText: isRePasswordVisible,
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      hoverColor: Colors.white,
                      labelText: 'Re-Enter Key',
                      prefixIcon: Icon(Icons.vpn_key),
                      suffixIcon: IconButton(
                        icon: isRePasswordVisible
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        onPressed: () => setState(
                            () => isRePasswordVisible = !isRePasswordVisible),
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
                        recreatedKey = value;
                      });
                    },
                  ),
                ),
                Spacer(),
                IconButton(
                  splashColor: Theme.of(context).accentColor,
                  color: Theme.of(context).primaryColor,
                  hoverColor: Theme.of(context).primaryColor,
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () async {
                    if (createdKey.trim() == '' || recreatedKey.trim() == '') {
                      Utility.showSnackBar(context, message: 'Empty TextField');
                    } else if (createdKey == recreatedKey) {
                      BoxKey.key = createdKey;

                      TempBox.instance.id = createdKey;
                      TempBox.instance.address = widget.address;
                      TempBox.instance.hash =
                          Utility.getKeyDigestString(createdKey);

                      //create passwordbox
                      await DatabaseService.instance.createPasswordBox(
                        address: widget.address,
                        boxKey: createdKey,
                      );

                      PasswordBoxBasicData passwordBoxBasicData =
                          await DatabaseService.instance
                              .checkAddress(widget.address);
                      //redirect to password page
                      Navigator.pop(context);
                      Navigator.of(context).pushNamed(
                        '/enter_password_page',
                        arguments: passwordBoxBasicData,
                      );

                      // Navigator.pop(context);
                      // Navigator.of(context).pushNamed(
                      //   '/password_box_page',
                      //   arguments: PasswordBoxBasicData(
                      //     id: createdKey,
                      //     address: widget.address,
                      //     hash: Utility.getKeyDigestString(createdKey),
                      //   ),
                      // );
                    } else {
                      Utility.showSnackBar(context,
                          message: 'Password Box Keys Mismatch');
                    }
                  },
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
