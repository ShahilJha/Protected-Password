import 'package:flutter/material.dart';
import 'package:protected_password/models/password_box.dart';
import 'package:protected_password/models/password_box_basic_data.dart';
import 'package:protected_password/services/box_key.dart';
import 'package:protected_password/services/firestore_service.dart';
import 'package:protected_password/services/password_box_provider.dart';
import 'package:protected_password/utils/utility.dart';
import 'package:provider/provider.dart';

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
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PasswordBoxProvider>(
      create: (context) => PasswordBoxProvider(box),
      child: Container(
        color: Colors.red,
      ),
    );
  }
}
