import 'package:ecomerce/Presentations/Boarding/on_boarding_screen.dart';
import 'package:ecomerce/Presentations/Home/Provider/home_provider.dart';
import 'package:ecomerce/Presentations/Home/home_screen.dart';
import 'package:ecomerce/Presentations/Login/verify_password_screen.dart';
import 'package:ecomerce/Presentations/resources/routes_manager.dart';
import 'package:ecomerce/Presentations/resources/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => homeProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: getApplicationTheme(),
          initialRoute: routes.boardingRoute,
          onGenerateRoute: RouteGenerator.getRoute,
        ));
  }
}
