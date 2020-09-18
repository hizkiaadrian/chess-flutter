import 'package:Chess/constants/config.dart';
import 'package:flutter/material.dart';

class HeroTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Text(
        appTitle,
        style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.w500),
      ),
    );
  }
}
