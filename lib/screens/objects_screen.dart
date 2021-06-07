import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/main_drawer.dart';
import '../providers/objects_provider.dart';
import '../screens/add_object_screen.dart';
import '../widgets/object_item_field.dart';

class ObjectsScreen extends StatefulWidget {
  const ObjectsScreen({Key key}) : super(key: key);

  @override
  _ObjectsScreenState createState() => _ObjectsScreenState();
}

class _ObjectsScreenState extends State<ObjectsScreen> {
  @override
  Widget build(BuildContext context) {


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
          stream: FirebaseFirestore.instance
              .collection('objects')
              .orderBy('address')
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              padding: EdgeInsets.only(top: 7),
              child: ListView.builder(
                  itemCount: streamSnapshot.data.docs.length,
                  itemBuilder: (ctx, index) {
                    return ObjectItemField(
                      streamSnapshot.data.docs[index].id,
                      streamSnapshot.data.docs[index]['address'],
                      streamSnapshot.data.docs[index]['isMonthlyService'],
                      streamSnapshot.data.docs[index]['isQuarterlyService'],
                      streamSnapshot.data.docs[index]['isJournal'],
                      streamSnapshot.data.docs[index]['isAct'],
                      streamSnapshot.data.docs[index]['malfunctions'],
                    );
                  }),
            );
          },
        ),
      ),
    );
  }
}

// Text(streamSnapshot.data.docs[index]['address'])