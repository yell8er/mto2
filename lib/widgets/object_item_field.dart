import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mto/screens/edit_object.dart';
import 'package:intl/intl.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dart:core';

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
      this.serviceDate,
      this.quarterlyServiceDate);
  final String id;
  final String address;
  final String servicedParts;
  final String contacts;
  final String specification;
  final String passwords;
  final String malfunctions;
  final String notes;
  DateTime serviceDate;
  DateTime quarterlyServiceDate;

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
  DateTime pickedDate;
  DateTime today;

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    today = DateTime.now();
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

    setState(() {
      if ((today.year == widget.serviceDate.year &&
              today.month != widget.serviceDate.month) ||
          (today.month == widget.serviceDate.month &&
              today.year != widget.serviceDate.year))
        FirebaseFirestore.instance.collection('objects').doc(widget.id).update({
          'isMonthlyService': false,
          'isJournal': false,
        });

      if (today.month - widget.quarterlyServiceDate.month >= 3 ||
          today.year != widget.quarterlyServiceDate.year)
        FirebaseFirestore.instance.collection('objects').doc(widget.id).update({
          'isQuarterlyService': false,
          'isAct': false,
        });
    });

//show service info dialog
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
//main field
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.2,
        // closeOnScroll: true,
        // actions:
        // IconSlideAction()
        secondaryActions: [
          SlideAction(
            onTap: () {
              FirebaseFirestore.instance
                  .collection('objects')
                  .doc(widget.id)
                  .delete();
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                margin: EdgeInsets.only(
                  top: 5,
                  bottom: 5,
                  left: 5,
                  right: 10,
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 0,
                      spreadRadius: 0,
                      offset: Offset(-1, 1),
                    ),
                  ],
                  color: Colors.red[700],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.delete_rounded,
                      color: Colors.white,
                    ),
                    Text(
                      'Удалить',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                )),
          ),
        ],
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(7),
            // border: Border.all(width: 5, color: Colors.black12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 0,
                spreadRadius: 0,
                offset: Offset(-1, 1),
              ),
            ],
          ),
          // width: 140,
          padding: EdgeInsets.only(
            // left: 15,
            top: 5,
            bottom: 5,
          ),
          margin: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 6,
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//address
            Container(
              // decoration: BoxDecoration(border: Border.all(width: 1)),
              width: MediaQuery.of(context).size.width * 0.6,
              alignment: Alignment.centerLeft,
              child: Text(
                widget.address,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  // letterSpacing: 1,
                  // color: Colors.black
                  // shadows: <Shadow>[
                  //   Shadow(
                  //     offset: Offset(-0.3, 0.3),
                  //     blurRadius: 1.0,
                  //     color: Color.fromARGB(255, 0, 0, 0),
                  //   ),
                  //   // Shadow(
                  //   //   offset: Offset(10.0, 10.0),
                  //   //   blurRadius: 8.0,
                  //   //   color: Color.fromARGB(125, 0, 0, 255),
                  //   // ),
                  // ],
                ),
              ),
            ),
            Container(
              // decoration: BoxDecoration(border: Border.all(width: 1)),
              width: MediaQuery.of(context).size.width * 0.11,
              child: IconButton(
//TO button
                onPressed: () {
                  // _showServiceInfo();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, setState) {
                        _pickDate() async {
                          DateTime date = await showDatePicker(
                            context: context,
                            initialDate: today,
                            firstDate: DateTime(today.year - 5),
                            lastDate: DateTime(today.year + 5),
                          );
                          if (date != null) {
                            setState(() {
                              pickedDate = date;
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
                              children: [
                                Text(
                                  'Ежемесячное',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
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
                                        0.02),
                                Container(
                                  margin: EdgeInsets.only(right: 1),
                                  child: Row(
                                    // mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      // alignment: Alignment.centerLeft,

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
                                  margin: EdgeInsets.only(right: 1),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: 75,
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          'Журнал',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
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
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      widget.serviceDate.year == 1900
                                          ? '  Прошлое ТО:'
                                          : '  Прошлое ТО:\n  ${DateFormat.yMMMd('ru_RU').format(widget.serviceDate)}',
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    )),
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
                                              'Дата: ${DateFormat.yMMMd('ru_RU').format(widget.quarterlyServiceDate)}'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        //print(pickedDate);
                                        FirebaseFirestore.instance
                                            .collection('objects')
                                            .doc(widget.id)
                                            .update({
                                          'isMonthlyService':
                                              widget.isMonthlyService,
                                          // 'isQuarterlyService':
                                          //     widget.isQuarterlyService,
                                          'isJournal': widget.isJournal,
                                          // 'isAct': widget.isAct,
                                        });
                                        if (((widget.serviceDate.year ==
                                                        pickedDate.year &&
                                                    widget.serviceDate.month !=
                                                        pickedDate.month) ||
                                                widget.serviceDate.year !=
                                                    pickedDate.year) ||
                                            !widget.isMonthlyService)
                                          FirebaseFirestore.instance
                                              .collection('objects')
                                              .doc(widget.id)
                                              .update({
                                            'serviceDate': pickedDate,
                                          });

                                        Navigator.of(context).pop();
                                        setState(() {
                                          pickedDate = DateTime.now();
                                        });
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
                    },
                  );
                },
// Icon for TO
                icon: (!widget.isMonthlyService)
                    ? Icon(
                        // Icons.hourglass_empty_rounded,
                        MaterialCommunityIcons.settings_helper)
                    : !widget.isJournal
                        ? Icon(MaterialCommunityIcons.book_open_outline)
                        : Icon(
                            Icons.check_circle_rounded,
                            color: Theme.of(context).primaryColor,
                          ),
              ),
            ),
            Container(
              // decoration: BoxDecoration(border: Border.all(width: 1)),
              width: MediaQuery.of(context).size.width * 0.11,
              child: IconButton(
//Icon for KB
                icon: widget.isAct
                    ? Icon(
                        Icons.check_circle_rounded,
                        color: Theme.of(context).primaryColor,
                      )
                    : widget.isQuarterlyService
                        ? Icon(
                            MaterialCommunityIcons.file_document_box_outline,
                          )
                        : Icon(MaterialCommunityIcons.settings_helper),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, setState) {
                        _pickDate() async {
                          DateTime date = await showDatePicker(
                            context: context,
                            initialDate: today,
                            firstDate: DateTime(today.year - 5),
                            lastDate: DateTime(today.year + 5),
                          );
                          if (date != null) {
                            setState(() {
                              pickedDate = date;
                            });
                          }
                        }

                        return Dialog(
                          insetPadding: EdgeInsets.all(25),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(22),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Квартальное',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  'техническое',
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
                                        0.02),
                                Container(
                                  margin: EdgeInsets.only(right: 15),
                                  child: Row(
                                    // mainAxisSize: MainAxisSize.min,
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
                                              widget.isJournal = false;
                                              if (widget.isQuarterlyService)
                                                widget.isMonthlyService = true;
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
                                      Checkbox(
                                          value: widget.isJournal,
                                          onChanged: (bool value) {
                                            setState(() {
                                              widget.isJournal = value;
                                              if (widget.isJournal)
                                                widget.isQuarterlyService =
                                                    true;
                                              widget.isMonthlyService = true;
                                            });
                                          }),
                                    ],
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      widget.quarterlyServiceDate.year == 1900
                                          ? '    Прошлое КВ:'
                                          : '    Прошлое КВ:\n    ${DateFormat.yMMMd('ru_RU').format(widget.quarterlyServiceDate)}',
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    )),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        _pickDate();
                                      },
                                      child: Text(
                                          'Дата: ${DateFormat.yMMMd('ru_RU').format(pickedDate)}'),
                                    ),
                                    ElevatedButton(
                                      child: Text('Сохранить'),
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection('objects')
                                            .doc(widget.id)
                                            .update({
                                          'isQuarterlyService':
                                              widget.isQuarterlyService,
                                          'isJournal': widget.isJournal,
                                          'isAct': widget.isAct,
                                        });

                                        if ((widget.isQuarterlyService &&
                                            ((pickedDate.month -
                                                        widget
                                                            .quarterlyServiceDate
                                                            .month)
                                                    .abs() >
                                                3)) || (!widget.isQuarterlyService &&
                                            ((pickedDate.month -
                                                        widget
                                                            .quarterlyServiceDate
                                                            .month)
                                                    .abs() <=
                                                2))
                                                )
                                          FirebaseFirestore.instance
                                              .collection('objects')
                                              .doc(widget.id)
                                              .update({
                                            'quarterlyServiceDate': pickedDate,
                                          });

                                        Navigator.of(context).pop();
                                        setState(() {
                                          pickedDate = DateTime.now();
                                        });
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      });
                    },
                  );
                },
              ),
            ),
            Container(
              // decoration: BoxDecoration(border: Border.all(width: 1)),
              width: MediaQuery.of(context).size.width * 0.1,
              child: IconButton(
//Icon for warning
                // color: Colors.red[300],
                icon: widget.malfunctions.isNotEmpty
                    ? Icon(
                        Icons.warning_amber_rounded,
                        // Ionicons.warning
                      )
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
                // color: Colors.red[600],
                // color: Colors.yellow[900],
                // color: Color(0xFFEF7E2F),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
