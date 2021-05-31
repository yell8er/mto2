import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/main_drawer.dart';
import '../providers/objects_provider.dart';
import '../screens/add_object_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ObjectsScreen extends StatefulWidget {
  const ObjectsScreen({Key key}) : super(key: key);

  @override
  _ObjectsScreenState createState() => _ObjectsScreenState();
}

class _ObjectsScreenState extends State<ObjectsScreen> {
  @override
  Widget build(BuildContext context) {
    // CollectionReference objects =
    //     FirebaseFirestore.instance.collection('objects');
    //     Stream collectionStream = FirebaseFirestore.instance.collection('objects').snapshots();
    // var pathAddr = '/objects/kadQZ4uhkO2FoNuRuSfE/address';

    return ChangeNotifierProvider.value(
      value: ObjectProvider(),
      child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(13),
              bottomRight: Radius.circular(13),
            ),
          ),
          elevation: 25,
          shadowColor: Theme.of(context).accentColor,
          title: Text('Объекты'),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).pushNamed(AddObject.routeName);
                }),
          ],
        ),
        drawer: MainDrawer(),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('objects').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: streamSnapshot.data.docs.length,
                itemBuilder: (ctx, index) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: Text(streamSnapshot.data.docs[index]['address']),
                  );
                });
          },
        ),
      ),
    );
  }
}
