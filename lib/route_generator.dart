import 'package:flutter/material.dart';

/*
  To Navigate to another screen:
    Navigator.of(context).pushNamed(
      '/route_name',
      arguments : data_arguents,
     );
*/

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {

      //COMMON Routes
      case '/':
        return MaterialPageRoute(builder: (_) => Container());

      //   case '/receptionist_order_detail':
      //     if (args is bool) {
      //       return MaterialPageRoute(
      //         builder: (_) => Container(order: args),
      //       );
      //     }
      //     return _errorRoute();

      //ERROR Route
      default:
        //If there is no route that has been redirected to.
        return _errorRoute();
    }
  }

  //ERROR Screen Message for illegal route call
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Center(
            child: Text('ERROR ROUTE'),
          ),
        ),
      );
    });
  }
}
