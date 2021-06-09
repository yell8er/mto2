import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mto/screens/edit_object.dart';

class ObjectItemField extends StatefulWidget {
  // const ObjectItemField({ Key? key }) : super(key: key);
  ObjectItemField(
    this.id,
    this.address,
    this.servicedParts,
    this.contacts,
    this.specification,
    this.passwords,
    this.malfunctions,
    this.notes,
    this.isMonthlyService,
    this.isQuarterlyService,
    this.isJournal,
    this.isAct,
  );
  final String id;
  final String address;
  final String servicedParts;
  final String contacts;
  final String specification;
  final String passwords;
  final String malfunctions;
  final String notes;

  bool isMonthlyService;
  bool isQuarterlyService;
  bool isJournal;
  bool isAct;
  bool isOpen = false;

  @override
  _ObjectItemFieldState createState() => _ObjectItemFieldState();
}

class _ObjectItemFieldState extends State<ObjectItemField> {
  var _addressController = TextEditingController();
  var _servicedPartsController = TextEditingController();
  var _contactsController = TextEditingController();
  var _specificationController = TextEditingController();
  var _passwordsController = TextEditingController();
  var _malfunctionsController = TextEditingController();
  var _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _addressController.text = widget.address;
    _servicedPartsController.text = widget.servicedParts;
    _contactsController.text = widget.contacts;
    _specificationController.text = widget.specification;
    _passwordsController.text = widget.passwords;
    _malfunctionsController.text = widget.malfunctions;
    _notesController.text = widget.notes;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EditObject(
                  id: widget.id,
                  address: widget.address,
                  servicedParts: widget.servicedParts,
                  contacts: widget.contacts,
                  specification: widget.specification,
                  passwords: widget.passwords,
                  malfunctions: widget.malfunctions,
                  notes: widget.notes,
                )));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.indigo[100],
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
          top: 1,
          bottom: 1,
        ),
        margin: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 5,
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Container(
            // decoration: BoxDecoration(border: Border.all(width: 2)),
            width: MediaQuery.of(context).size.width * 0.4,
            alignment: Alignment.centerLeft,
            child: Text(
              widget.address,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.15,
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                SizedBox(height: 50),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
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
                                      style: TextStyle(fontSize: 16),
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
                                      style: TextStyle(fontSize: 14),
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
                                      'КВ',
                                      style: TextStyle(fontSize: 16),
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
                                      style: TextStyle(fontSize: 16),
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
                          fontSize: 16,
                          color: Colors.brown[700],
                          fontWeight: FontWeight.bold),
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
                        fontSize: 16,
                        color: Colors.brown[700],
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.1,
            child: IconButton(
              icon: widget.malfunctions.isNotEmpty
                  ? Icon(Icons.warning_amber_rounded)
                  : SizedBox(
                      width: 1,
                      height: 1,
                    ),
              onPressed: () {
                print(_malfunctionsController.text);
                //start
                return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(_addressController.text),
                      content: Text(_malfunctionsController.text),
                    );
                  },
                );
                //end
              },
              color: Colors.red[600],
            ),
          ),
        ]),
      ),
    );
  }
}
