import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:protected_password/utils/utility.dart';

const kTestStyle = TextStyle(fontSize: 60, color: Colors.white);

class AddressSearchPage extends StatelessWidget {
  const AddressSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30.r, horizontal: 100.r),
      child: Container(
        color: Colors.red,
        child: Column(
          children: [
            Text(
              Utility.getKeyDigestString('shahil'),
              style: kTestStyle,
            )
          ],
        ),
      ),
    );
  }
}
