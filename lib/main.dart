import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:protected_password/route_generator.dart';
import 'package:protected_password/services/password_box_provider.dart';
import 'package:provider/provider.dart';
import 'theme_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(1920, 1080),
      builder: () => MaterialApp(
        title: 'Protected Password',
        debugShowCheckedModeBanner: false,
        theme: ThemeGenerator.generateThemeData(),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
