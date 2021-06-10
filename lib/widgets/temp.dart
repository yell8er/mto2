import 'package:flutter/material.dart';

class Temp extends StatelessWidget {
  const Temp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        top: 1,
        bottom: 1,
      ),
      margin: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 5,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          alignment: Alignment.centerLeft,
          child: Text('Адрес'),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.15,
          child: TextButton(
              onPressed: () {},
              child: Text(
                'ТО',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.brown[700],
                    fontWeight: FontWeight.bold),
              )),
        ),
        Container(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          width: MediaQuery.of(context).size.width * 0.15,
          child: TextButton(
              onPressed: () {},
              child: Text(
                'КВ',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.brown[700],
                  fontWeight: FontWeight.bold,
                ),
              )),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.1,
          child: IconButton(
            icon: Icon(Icons.warning_amber_rounded),
            onPressed: () {},
            color: Colors.red[600],
          ),
        ),
      ]),
    );
  }
}
