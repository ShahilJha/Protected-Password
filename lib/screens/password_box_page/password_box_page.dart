import 'package:flutter/material.dart';
import 'package:protected_password/models/password_box.dart';
import 'package:protected_password/models/password_box_basic_data.dart';
import 'package:protected_password/services/firestore_service.dart';
import 'package:protected_password/services/password_box_provider.dart';
import 'package:provider/provider.dart';

class PasswordBoxPage extends StatefulWidget {
  final PasswordBoxBasicData basicData;
  const PasswordBoxPage({required this.basicData, Key? key}) : super(key: key);

  @override
  _PasswordBoxPageState createState() => _PasswordBoxPageState();
}

class _PasswordBoxPageState extends State<PasswordBoxPage> {
  late PasswordBox box;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    box = await DatabaseService.instance.getPasswordBox(widget.basicData);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PasswordBoxProvider>(
      create: (context) => PasswordBoxProvider(box),
      child: PasswordBoxWidget(),
    );
  }
}

class PasswordBoxWidget extends StatelessWidget {
  const PasswordBoxWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
