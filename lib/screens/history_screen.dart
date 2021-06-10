import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(13),
            bottomRight: Radius.circular(13),
          ),
        ),
        elevation: 25,
        shadowColor: Theme.of(context).accentColor,
        title: Text('История'),
      ),
      drawer: MainDrawer(),
      body: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: MediaQuery.of(context).size.width * 1.5,
            decoration: BoxDecoration(
              border: Border.all(width: 2),
            ),
          )
        ],
      ),
    );
  }
}
