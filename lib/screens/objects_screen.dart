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
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 20,
                top: 1,
                bottom: 1,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 5,
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Адрес',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'ТО',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
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
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: IconButton(
                        icon: Icon(Icons.warning_amber_rounded),
                        onPressed: () {},
                        color: Colors.black,
                      ),
                    ),
                  ]),
            ),
            Flexible(
              child: SingleChildScrollView(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('objects')
                      .orderBy('address')
                      .snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Container(
                      // height: MediaQuery.of(context).size.width * 1.5,
                      // decoration: BoxDecoration(border: Border.all(width: 1)),
                      padding: EdgeInsets.only(top: 7),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: streamSnapshot.data.docs.length,
                          itemBuilder: (ctx, index) {
                            return ObjectItemField(
                              streamSnapshot.data.docs[index].id,
                              streamSnapshot.data.docs[index]['address'],
                              streamSnapshot.data.docs[index]['servicedParts'],
                              streamSnapshot.data.docs[index]['contacts'],
                              streamSnapshot.data.docs[index]['specification'],
                              streamSnapshot.data.docs[index]['passwords'],
                              streamSnapshot.data.docs[index]['malfunctions'],
                              streamSnapshot.data.docs[index]['notes'],
                              streamSnapshot.data.docs[index]
                                  ['isMonthlyService'],
                              streamSnapshot.data.docs[index]
                                  ['isQuarterlyService'],
                              streamSnapshot.data.docs[index]['isJournal'],
                              streamSnapshot.data.docs[index]['isAct'],
                              streamSnapshot.data.docs[index]['serviceDate']
                                  .toDate(),
                            );
                          }),
                    );
                  },
                  // ),
                  // ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Text(streamSnapshot.data.docs[index]['address'])