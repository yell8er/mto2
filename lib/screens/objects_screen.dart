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
          // elevation: 0,
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
              // padding: EdgeInsets.only(
              //   // left: 15,
              //   top: 1,
              //   bottom: 1,
              // ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8),
                // border: Border.all(width: 1),
              ),
              margin: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 5,
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Container(
                  decoration: BoxDecoration(
                      // border: Border.all(width: 1),
                      ),
                  width: MediaQuery.of(context).size.width * 0.6,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'АДРЕС',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      // fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Container(
                  // decoration: BoxDecoration(border: Border.all(width: 1)),
                  width: MediaQuery.of(context).size.width * 0.11,
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'ТО',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                Container(
                  // decoration: BoxDecoration(border: Border.all(width: 1)),
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  width: MediaQuery.of(context).size.width * 0.11,
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'КВ',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ),
                Container(
                  // decoration: BoxDecoration(border: Border.all(width: 1)),
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: IconButton(
                    icon: Icon(Icons.warning_amber_rounded),
                    onPressed: () {},
                    color: Colors.white,
                  ),
                ),
              ]),
            ),
            // Container(
            //   width: MediaQuery.of(context).size.width * 0.8,
            //   decoration: BoxDecoration(
            //     border: Border.all(
            //       width: 0.5,
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   width: MediaQuery.of(context).size.width,
            //   height: 10,
            // ),
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