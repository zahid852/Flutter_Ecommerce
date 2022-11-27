import 'package:flutter/material.dart';

class userProfileScreen extends StatefulWidget {
  @override
  State<userProfileScreen> createState() => _userProfileScreenState();
}

class _userProfileScreenState extends State<userProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('User'),
      ),
    );
  }
}
