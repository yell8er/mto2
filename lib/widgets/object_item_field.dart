import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

    if (widget.isOpen) {
      return
          // Expanded(
          //   child:
          Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
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
                  TextField(
                    minLines: 1,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Обслуживаемые части и системы',
                      border: OutlineInputBorder(),
                    ),
                    controller: _servicedPartsController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    minLines: 1,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Контакты',
                      border: OutlineInputBorder(),
                    ),
                    controller: _contactsController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Оборудование и спецификация',
                      border: OutlineInputBorder(),
                    ),
                    controller: _specificationController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Пароли',
                      border: OutlineInputBorder(),
                    ),
                    controller: _passwordsController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Неисправности',
                      border: OutlineInputBorder(),
                    ),
                    controller: _malfunctionsController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Примечание',
                      border: OutlineInputBorder(),
                    ),
                    controller: _notesController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // mainAxisSize: MainAxisSize.,
                    children: [
                      ElevatedButton.icon(
                        label: Text('Сохранить'),
                        icon: Icon(Icons.save_rounded),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('objects')
                              .doc(widget.id)
                              .update({
                            'address': _addressController.text,
                            'servicedParts': _servicedPartsController.text,
                            'contacts': _contactsController.text,
                            'specification': _specificationController.text,
                            'passwords': _passwordsController.text,
                            'malfunctions': _malfunctionsController.text,
                            'notes': _notesController.text,
                          });
                          setState(() {
                            widget.isOpen = false;
                          });
                        },
                      ),
                      ElevatedButton.icon(
                        icon: Icon(Icons.backspace_outlined),
                        label: Text('Отмена'),
                        onPressed: () {
                          setState(() {
                            widget.isOpen = false;
                          });
                        },
                      ),
                      ElevatedButton.icon(
                        icon: Icon(Icons.delete_forever_outlined),
                        label: Text('Удалить'),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('objects')
                              .doc(widget.id)
                              .delete();
                          setState(() {
                            widget.isOpen = false;
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          // ),
        ],
      );
    }

    if (!widget.isOpen) {
      return GestureDetector(
        onTap: () {
          setState(() {
            widget.isOpen = true;
          });
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
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Container(
              // decoration: BoxDecoration(border: Border.all(width: 2)),
              width: MediaQuery.of(context).size.width * 0.4,
              alignment: Alignment.centerLeft,
              child: Text(
                widget.address,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
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
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
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
                                        style: TextStyle(fontSize: 16),
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
                          fontSize: 16,
                        ),
                      )
                    : null,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.1,
              child: IconButton(
                icon: widget.malfunctions.isNotEmpty
                    ? Icon(Icons.warning_rounded)
                    : SizedBox(
                        width: 1,
                        height: 1,
                      ),
                onPressed: () {},
                color: Colors.orange[900],
              ),
            ),
          ]),
        ),
      );
    }
  }
}
