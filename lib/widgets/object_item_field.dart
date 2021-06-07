import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ObjectItemField extends StatefulWidget {
  // const ObjectItemField({ Key? key }) : super(key: key);
  ObjectItemField(
    this.id,
    this.address,
    this.isMonthlyService,
    this.isQuarterlyService,
    this.isJournal,
    this.isAct,
    this.malfunctions,
  );
  final String id;
  final String address;
  bool isMonthlyService;
  bool isQuarterlyService;
  bool isJournal;
  bool isAct;
  String malfunctions;
  bool isOpen = false;

  @override
  _ObjectItemFieldState createState() => _ObjectItemFieldState();
}

class _ObjectItemFieldState extends State<ObjectItemField> {
  var _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _addressController.text = widget.address;

    if (widget.isOpen) {
      return
          // Expanded(
          // child:
          SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Адрес',
                border: OutlineInputBorder(),
              ),
              controller: _addressController,
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('objects')
                    .doc(widget.id)
                    .update({
                  'address': _addressController.text,
                });
                setState(() {
                  widget.isOpen = false;
                });
              },
              child: Text('Сохранить'),
            ),
          ]),
        ),
        // ),
      );
    }
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
        GestureDetector(
          onTap: () {
            setState(() {
              widget.isOpen = true;
            });
          },
          child: Container(
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
                          padding: EdgeInsets.all(20),
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
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Checkbox(
                                      value: widget.isJournal,
                                      onChanged: (bool value) {
                                        setState(() {
                                          widget.isJournal = value;
                                        });
                                      }),
                                  Text(
                                    'Журнал подписан',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                  Checkbox(
                                      value: widget.isAct,
                                      onChanged: (value) {
                                        setState(() {
                                          widget.isAct = value;
                                        });
                                      }),
                                  Text(
                                    'Акт подписан',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
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
                                        'isJournal': widget.isJournal,
                                        'isAct': widget.isAct,
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
          icon: widget.malfunctions.isNotEmpty
              ? Icon(Icons.warning_rounded)
              : SizedBox(
                  width: 1,
                  height: 1,
                ),
          onPressed: () {},
          color: Colors.orange[900],
        ),
      ]),
    );
  }
}
