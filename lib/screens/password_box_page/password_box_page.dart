import 'package:flutter/material.dart';
import 'package:protected_password/models/password_box_basic_data.dart';
import 'package:protected_password/services/password_box_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordBoxPage extends StatelessWidget {
  final PasswordBoxBasicData basicData;
  const PasswordBoxPage({required this.basicData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PasswordBoxProvider>(
      create: (context) => PasswordBoxProvider(),
      child: BoxWidget(),
    );
  }
}

class BoxWidget extends StatelessWidget {
  const BoxWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Protected Text',
          style: TextStyle(fontSize: 50.sp, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Container(
            width: 500.w,
            height: 500.h,
            color: Colors.red,
            child: Text(
              Provider.of<PasswordBoxProvider>(context).passwordBox.address,
              style: TextStyle(fontSize: 60),
            ),
          ),
        ),
      ),
    );
  }
}
