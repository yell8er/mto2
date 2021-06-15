import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('history')
                .orderBy('date', descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  itemCount: streamSnapshot.data.docs.length,
                  itemBuilder: (ctx, index) {
                    print('${streamSnapshot.data.docs[index]['type']}');
                    return Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withAlpha(10)),
                      margin: EdgeInsets.only(top: 10),
                      padding:
                          EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '${DateFormat.yMMMd('ru_RU').add_Hm().format(streamSnapshot.data.docs[index]['date'].toDate())}',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                '${streamSnapshot.data.docs[index]['address']}:  ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '${streamSnapshot.data.docs[index]['type']}',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
            }));
  }
}
