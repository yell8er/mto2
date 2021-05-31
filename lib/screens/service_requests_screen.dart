import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class ServiceRequestsScreen extends StatelessWidget {
  const ServiceRequestsScreen({Key key}) : super(key: key);

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
        title: Text('Заявки'),
      ),
      drawer: MainDrawer(),
    );
  }
}
