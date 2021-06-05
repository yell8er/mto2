import 'package:flutter/material.dart';

class ObjectItemField extends StatelessWidget {
  // const ObjectItemField({ Key? key }) : super(key: key);
  ObjectItemField(this.address);
  final String address;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        // border: Border.all(width: 0.2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(1, 1),
          ),
        ],
      ),
      width: 140,
      padding: EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 13,
      ),
      margin: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
      child: Text(
        address,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 19,
        ),
      ),
    );
  }
}
