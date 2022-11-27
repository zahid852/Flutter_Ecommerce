import 'package:ecomerce/Presentations/Cart/cart_screen.dart';
import 'package:ecomerce/Presentations/Home/home_screen.dart';
import 'package:ecomerce/Presentations/User/user_profile_screen.dart';
import 'package:ecomerce/Presentations/resources/color_manager.dart';
import 'package:flutter/material.dart';

class nav_screen extends StatefulWidget {
  @override
  State<nav_screen> createState() => _nav_screenState();
}

class _nav_screenState extends State<nav_screen> {
  final List<Widget> screens = [
    home_screen(),
    CartScreen(),
    userProfileScreen()
  ];
  final Map<String, IconData> screenItems = {
    'Home': Icons.home,
    'Cart': Icons.menu,
    'Profile': Icons.person
  };
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: screenItems
            .map((title, icon) => MapEntry(
                title,
                BottomNavigationBarItem(
                  icon: Icon(
                    icon,
                    size: 30,
                  ),
                  label: title,
                )))
            .values
            .toList(),
        currentIndex: currentIndex,
        selectedItemColor: ColorManager.primery,
        // type: BottomNavigationBarType.shifting,
        selectedFontSize: 17,
        unselectedItemColor: Colors.black54,
        unselectedFontSize: 15,
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
      ),
    );
  }
}
