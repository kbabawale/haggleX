import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hagglex/screens/complete.dart';
import 'package:hagglex/screens/dashboard.dart';
import 'package:hagglex/screens/login.dart';
import 'package:hagglex/screens/signup.dart';
import 'package:hagglex/screens/splash.dart';
import 'package:hagglex/screens/verify.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case '/verify':
        return MaterialPageRoute(builder: (_) => VerifyPage());
      case '/complete':
        return MaterialPageRoute(builder: (_) => Complete());
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => Dashboard());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
