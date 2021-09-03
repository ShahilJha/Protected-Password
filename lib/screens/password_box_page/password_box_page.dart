import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:protected_password/models/password_box.dart';
import 'package:protected_password/models/password_box_basic_data.dart';
import 'package:protected_password/screens/password_box_page/local_widget/add_password_screen.dart';
import 'package:protected_password/screens/password_box_page/local_widget/update_password_screen.dart';
import 'package:protected_password/services/firestore_service.dart';
import 'package:protected_password/services/password_box_provider.dart';
import 'package:protected_password/utils/utility.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';

const kTextSite = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
const kTextSub = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
const kText = TextStyle(fontSize: 15, fontWeight: FontWeight.normal);

class PasswordBoxPage extends StatelessWidget {
  final PasswordBoxBasicData basicData;
  const PasswordBoxPage({required this.basicData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PasswordBoxProvider>(
      create: (context) => PasswordBoxProvider(),
      child: BoxWidget(),
      // builder: (context) {
      //   return BoxWidget();
      // },
    );
  }
}

class BoxWidget extends StatelessWidget {
  const BoxWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final boxProvider = context.watch<PasswordBoxProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Protected Text',
          style: TextStyle(fontSize: 50.sp, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => ChangeNotifierProvider.value(
                  value: boxProvider,
                  child: AddPasswordScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              boxProvider.saveBox();
            },
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              boxProvider.deleteBox();
              Navigator.pop(context);
              Navigator.of(context).pushNamed('/');
            },
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Flexible(
          //   child: Container(
          //     height: 60.h,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       children: [
          //         IconButton(
          //           icon: Icon(Icons.add_circle_outline),
          //           onPressed: () {
          //             // Provider.of<PasswordBoxProvider>(context).addPassword(
          //             //   Password(
          //             //     id: Uuid().v1(),
          //             //     associatedEntity: 'website',
          //             //     userName: 'username',
          //             //     password: 'password',
          //             //   ),
          //             // );
          //             showModalBottomSheet(
          //               context: context,
          //               builder: (context) => AddPasswordScreen(),
          //             );
          //           },
          //         ),
          //         IconButton(
          //           icon: Icon(Icons.save),
          //           onPressed: () {
          //             // Provider.of<PasswordBoxProvider>(context, listen: false)
          //             //     .saveBox();
          //             boxProvider.saveBox();
          //           },
          //         ),
          //         IconButton(
          //           icon: Icon(Icons.close),
          //           onPressed: () {
          //             // Provider.of<PasswordBoxProvider>(context, listen: false)
          //             //     .deleteBox();
          //             boxProvider.deleteBox();
          //             Navigator.pop(context);
          //             Navigator.of(context).pushNamed('/');
          //           },
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          Flexible(
            child: Container(
              width: double.maxFinite,
              // color: Colors.white,
              padding: EdgeInsets.symmetric(
                vertical: 50.h,
                horizontal: 100.w,
              ),
              child: MediaQuery.of(context).size.width < 1200
                  ? ListView.builder(
                      itemCount: boxProvider.passwordBox.passwords.length,
                      itemBuilder: (context, index) {
                        var password = boxProvider.passwordBox.passwords[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          width: 1800.w,
                          height: 250.h,
                          margin: EdgeInsets.symmetric(vertical: 30.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Spacer(flex: 2),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Spacer(),
                                  Text(
                                    password.associatedEntity,
                                    style: kTextSub,
                                  ),
                                  Spacer(flex: 3),
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) =>
                                            ChangeNotifierProvider.value(
                                          value: boxProvider,
                                          child: UpdatePasswordScreen(
                                              password: password),
                                        ),
                                      );
                                    },
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      boxProvider.deletePassword(password);
                                    },
                                  ),
                                  Spacer(flex: 2),
                                ],
                              ),
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Spacer(),
                                  Text(
                                    'Username:',
                                    style: kTextSub,
                                  ),
                                  Spacer(),
                                  Text(
                                    password.userName,
                                    style: kText,
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(Icons.copy),
                                    onPressed: () {
                                      Utility.copyToClipboard(
                                          context, password.userName);
                                      Utility.showSnackBar(context,
                                          message: 'Copied to ClipBoard');
                                    },
                                  ),
                                  Spacer(),
                                ],
                              ),
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Spacer(),
                                  Text(
                                    'Password:',
                                    style: kTextSub,
                                  ),
                                  Spacer(),
                                  Text(
                                    password.password,
                                    style: kText,
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(Icons.copy),
                                    onPressed: () {
                                      Utility.copyToClipboard(
                                          context, password.password);
                                      Utility.showSnackBar(context,
                                          message: 'Copied to ClipBoard');
                                    },
                                  ),
                                  Spacer(),
                                ],
                              ),
                              Spacer(),
                            ],
                          ),
                        );
                      },
                    )
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 500.w,
                          childAspectRatio: 4 / 2,
                          crossAxisSpacing: 20.w,
                          mainAxisSpacing: 20.w),
                      itemCount: boxProvider.passwordBox.passwords.length,
                      itemBuilder: (context, index) {
                        var password = boxProvider.passwordBox.passwords[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          width: 900.w,
                          height: 250.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Spacer(),
                              Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                children: [
                                  Spacer(),
                                  Text(
                                    password.associatedEntity,
                                    style: kTextSub,
                                  ),
                                  Spacer(flex: 3),
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) =>
                                            ChangeNotifierProvider.value(
                                          value: boxProvider,
                                          child: UpdatePasswordScreen(
                                              password: password),
                                        ),
                                      );
                                    },
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      boxProvider.deletePassword(password);
                                    },
                                  ),
                                  Spacer(),
                                ],
                              ),
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Spacer(),
                                  Text(
                                    'Username:',
                                    style: kTextSub,
                                  ),
                                  Spacer(),
                                  Text(
                                    password.userName,
                                    style: kText,
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(Icons.copy),
                                    onPressed: () {
                                      Utility.copyToClipboard(
                                          context, password.userName);
                                      Utility.showSnackBar(context,
                                          message: 'Copied to ClipBoard');
                                    },
                                  ),
                                  Spacer(),
                                ],
                              ),
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Spacer(),
                                  Text(
                                    'Password:',
                                    style: kTextSub,
                                  ),
                                  Spacer(),
                                  Text(
                                    password.password,
                                    style: kText,
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(Icons.copy),
                                    onPressed: () {
                                      Utility.copyToClipboard(
                                          context, password.password);
                                      Utility.showSnackBar(context,
                                          message: 'Copied to ClipBoard');
                                    },
                                  ),
                                  Spacer(),
                                ],
                              ),
                              Spacer(),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
