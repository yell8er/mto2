import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 25,
        ),
        Container(
          width: 300,
          height: 20,
          alignment: Alignment.center,
          child: Text('123'),
          decoration: BoxDecoration(
            color: Colors.green,
          ),
        )
      ],
    );
  }
}
