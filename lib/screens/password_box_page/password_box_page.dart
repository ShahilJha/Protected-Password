import 'package:flutter/material.dart';
import 'package:protected_password/models/password_box.dart';
import 'package:protected_password/models/password_box_basic_data.dart';
import 'package:protected_password/services/box_key.dart';
import 'package:protected_password/services/firestore_service.dart';
import 'package:protected_password/services/password_box_provider.dart';
import 'package:protected_password/utils/utility.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordBoxPage extends StatefulWidget {
  final PasswordBoxBasicData basicData;
  const PasswordBoxPage({required this.basicData, Key? key}) : super(key: key);

  @override
  _PasswordBoxPageState createState() => _PasswordBoxPageState();
}

class _PasswordBoxPageState extends State<PasswordBoxPage> {
  PasswordBox box = PasswordBox(id: "", address: "", passwords: []);

  Future<PasswordBox> getBox() async {
    print('EXPECTED ENCRYPTED ID: ' +
        Utility.encryptString(widget.basicData.id, BoxKey.key));

    box = await DatabaseService.instance.getPasswordBox(widget.basicData);
    return box;
  }

  // _PasswordBoxPageState() {
  //   getBox().then((value) => setState(() {
  //         box = value;
  //       }));
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      // print('BEFORE : ' + box.id + ' ' + box.address);
      box = await DatabaseService.instance.getPasswordBox(widget.basicData);
      // print('AFTER : ' +
      //     box.id +
      //     ' ' +
      //     box.address +
      //     ' ' +
      //     box.passwords.first.associatedEntity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PasswordBoxProvider>(
      create: (context) => PasswordBoxProvider(box),
      child: BoxWidget(),
    );
  }
}

class BoxWidget extends StatelessWidget {
  const BoxWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(Provider.of<PasswordBoxProvider>(context).passwordBox.address);
    return Scaffold(
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
