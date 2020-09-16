import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text('Start game'),
        onPressed: () => {
          Navigator.pushNamed(context, '/game'),
        },
      ),
    );
  }
}
