import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:protected_password/models/password_box_basic_data.dart';
import 'package:protected_password/services/firestore_service.dart';

class AddressSearchPage extends StatefulWidget {
  const AddressSearchPage({Key? key}) : super(key: key);

  @override
  _AddressSearchPageState createState() => _AddressSearchPageState();
}

class _AddressSearchPageState extends State<AddressSearchPage> {
  String address = '';

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
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.center,
                  // obscureText: true,
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    hoverColor: Colors.white,
                    labelText: 'Password Box Address',
                    prefixIcon: Icon(Icons.inbox),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () async {
                        if (await DatabaseService.instance
                            .doesAddressExit(address)) {
                          PasswordBoxBasicData passwordBoxBasicData =
                              await DatabaseService.instance
                                  .checkAddress(address);
                          //redirect to password page
                          // Navigator.of(context).pushNamed(
                          //   '/enter_password_page',
                          //   arguments : passwordBoxBasicData,
                          // );
                        } else {
                          //goto box creation page
                          Navigator.of(context).pushNamed(
                            '/box_create_page',
                            arguments: address,
                          );
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
                      address = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
