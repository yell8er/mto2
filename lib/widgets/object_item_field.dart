import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mto/screens/edit_object.dart';
import 'package:intl/intl.dart';

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
      this.serviceDate);
  final String id;
  final String address;
  final String servicedParts;
  final String contacts;
  final String specification;
  final String passwords;
  final String malfunctions;
  final String notes;
  DateTime serviceDate;

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
  // DateTime pickedDate;
  @override
  void initState() {
    super.initState();
    // pickedDate = DateTime.now();
    // widget.serviceDate = DateTime.now();
  }

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
                        _pickDate() async {
                          DateTime date = await showDatePicker(
                            context: context,
                            // initialDate: pickedDate,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(DateTime.now().year - 5),
                            lastDate: DateTime(DateTime.now().year + 5),
                          );
                          if (date != null) {
                            setState(() {
                              // pickedDate = date;
                              widget.serviceDate = date;
                            });
                          }
                        }

                        return Dialog(
                          insetPadding: EdgeInsets.all(25),
                          // backgroundColor: Colors.white70,
                          // insetAnimationDuration: Duration(microseconds: 1),
                          // insetAnimationCurve: Curves.easeInCubic,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(22),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,

                              // crossAxisAlignment: CrossAxisAlignment.stretch,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.center,

                              children: [
                                Text(
                                  'Техническое',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  'обслуживание',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.07),
                                Container(
                                  margin: EdgeInsets.only(right: 15),
                                  child: Row(
                                    // mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'КВ',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Checkbox(
                                          value: widget.isQuarterlyService,
                                          onChanged: (bool value) {
                                            setState(() {
                                              widget.isQuarterlyService = value;
                                              if (!widget.isQuarterlyService)
                                                widget.isAct = false;
                                            });
                                          }),
                                      Container(
                                        width: 75,
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          'TO',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      Checkbox(
                                          value: widget.isMonthlyService,
                                          onChanged: (bool value) {
                                            setState(() {
                                              widget.isMonthlyService = value;
                                              if (!widget.isMonthlyService)
                                                widget.isJournal = false;
                                            });
                                          }),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Акт',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Checkbox(
                                          value: widget.isAct,
                                          onChanged: (value) {
                                            setState(() {
                                              widget.isAct = value;
                                              if (widget.isAct)
                                                widget.isQuarterlyService =
                                                    true;
                                            });
                                          }),

                                      Container(
                                        width: 75,
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          'Журнал',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      // CheckboxListTile(
                                      //   title: Text(),
                                      //     value: widget.isJournal,
                                      //     onChanged: (bool value) {
                                      //       setState(() {
                                      //         widget.isJournal = value;
                                      //       });
                                      //     }),
                                      Checkbox(
                                          value: widget.isJournal,
                                          onChanged: (bool value) {
                                            setState(() {
                                              widget.isJournal = value;
                                              if (widget.isJournal)
                                                widget.isMonthlyService = true;
                                            });
                                          }),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        _pickDate();
                                      },
                                      child: widget.serviceDate.year == 1900
                                          ? Text('Дата:')
                                          : Text(
                                              'Дата: ${DateFormat.yMMMd('ru_RU').format(widget.serviceDate)}'),
                                    ),
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
                                          'serviceDate': widget.serviceDate,
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
                  : !widget.isJournal
                      ? Text(
                          'Ж',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.brown[700],
                              fontWeight: FontWeight.bold),
                        )
                      : Text(
                          '+',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.brown[700],
                              fontWeight: FontWeight.bold),
                        ),
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
