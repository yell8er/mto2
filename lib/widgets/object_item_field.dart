import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ObjectItemField extends StatefulWidget {
  // const ObjectItemField({ Key? key }) : super(key: key);
  ObjectItemField(
    this.id,
    this.address,
    this.isMonthlyService,
    this.isQuarterlyService,
  );
  final String id;
  final String address;
  bool isMonthlyService;
  bool isQuarterlyService;

  @override
  _ObjectItemFieldState createState() => _ObjectItemFieldState();
}

class _ObjectItemFieldState extends State<ObjectItemField> {
  // FirebaseFirestore.instance.collection('objects').doc(id)['isQuarterlyService'];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 0,
            spreadRadius: 0,
            offset: Offset(0, 1),
          ),
        ],
      ),
      // width: 140,
      padding: EdgeInsets.only(
        left: 20,
        top: 8,
        bottom: 8,
      ),
      margin: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 5,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Container(
          // decoration: BoxDecoration(border: Border.all(width: 2)),
          width: MediaQuery.of(context).size.width * 0.5,
          alignment: Alignment.centerLeft,
          child: Text(
            widget.address,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20,
              // letterSpacing: 1,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.1,
          child: TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(builder: (context, setState) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(40),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Техническое обслуживание',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              SizedBox(height: 50),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Checkbox(
                                      value: widget.isMonthlyService,
                                      onChanged: (bool value) {
                                        setState(() {
                                          widget.isMonthlyService = value;
                                        });
                                      }),
                                  Text(
                                    'TO',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    'Журнал подписан',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Checkbox(
                                      value: widget.isQuarterlyService,
                                      onChanged: (bool value) {
                                        setState(() {
                                          widget.isQuarterlyService = value;
                                        });
                                      }),
                                  Text(
                                    'КВTO',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    'Акт подписан',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('objects')
                                          .doc(widget.id)
                                          .update({
                                        'isMonthlyService':
                                            widget.isMonthlyService,
                                        'isQuarterlyService':
                                            widget.isQuarterlyService,
                                      });

                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Сохранить'),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    });
                  });
            },
            child: !widget.isMonthlyService
                ? Text(
                    'ТО',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  )
                : null,
          ),
        ),
        Container(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          width: MediaQuery.of(context).size.width * 0.15,
          child: TextButton(
            onPressed: () {},
            child: !widget.isQuarterlyService
                ? Text(
                    'КВ',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  )
                : null,
          ),
        ),
        IconButton(
          icon: Icon(Icons.warning_rounded),
          onPressed: () {},
          color: Colors.orange[900],
        )
      ]),
    );
  }
}
