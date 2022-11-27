import 'package:ecomerce/App/constants.dart';
import 'package:ecomerce/Domain/Model/model.dart';
import 'package:ecomerce/Presentations/Boarding/on_boarding_screen.dart';
import 'package:ecomerce/Presentations/Home/home_screen.dart';
import 'package:ecomerce/Presentations/Home/nav_screen.dart';
import 'package:ecomerce/Presentations/Login/login_screen.dart';
import 'package:ecomerce/Presentations/Login/user_details_screen.dart';
import 'package:ecomerce/Presentations/Login/verify_password_screen.dart';
import 'package:ecomerce/Presentations/resources/string_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:ecomerce/App/extention.dart';
import 'package:flutter/material.dart';

class routes {
  static const String boardingRoute = '/';
  static const String loginRoute = '/login';
  static const String verifyPassword = '/verifyPassword';
  static const String nav_screen = '/home';
  static const String userDetails = '/UserDetails';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case routes.boardingRoute:
        return MaterialPageRoute(builder: (ctx) => onBoardingScreen());
      case routes.loginRoute:
        return MaterialPageRoute(
          builder: (ctx) => StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (snapshot.hasData) {
                return nav_screen();
              }
              return loginScreen();
            },
          ),
        );
      case routes.verifyPassword:
        final phoneNumber = routeSettings.arguments as String?;
        return MaterialPageRoute(
            builder: (ctx) => verifyPassword(phoneNumber: phoneNumber));
      case routes.nav_screen:
        return MaterialPageRoute(builder: (ctx) => nav_screen());
      case routes.userDetails:
        return MaterialPageRoute(builder: (ctx) => userDetailsScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: ((context) => Scaffold(
              appBar: AppBar(
                title: Text(AppStrings.noRecordFound),
              ),
              body: Center(
                child: Container(
                  child: Text(AppStrings.noRecordFound),
                ),
              ),
            )));
  }
}
