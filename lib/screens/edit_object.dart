import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditObject extends StatelessWidget {
  const EditObject({
    Key key,
    this.id,
    this.address,
    this.servicedParts,
    this.contacts,
    this.specification,
    this.passwords,
    this.malfunctions,
    this.notes,
    // this.isMonthlyService,
    // this.isQuarterlyService,
    // this.isJournal,
    // this.isAct,
  }) : super(key: key);

  final String id;
  final String address;
  final String servicedParts;
  final String contacts;
  final String specification;
  final String passwords;
  final String malfunctions;
  final String notes;

  @override
  Widget build(BuildContext context) {
    var _addressController = TextEditingController();
    var _servicedPartsController = TextEditingController();
    var _contactsController = TextEditingController();
    var _specificationController = TextEditingController();
    var _passwordsController = TextEditingController();
    var _malfunctionsController = TextEditingController();
    var _notesController = TextEditingController();

    _addressController.text = address;
    _servicedPartsController.text = servicedParts;
    _contactsController.text = contacts;
    _specificationController.text = specification;
    _passwordsController.text = passwords;
    _malfunctionsController.text = malfunctions;
    _notesController.text = notes;

    return Scaffold(
      appBar: AppBar(
        title: Text(address),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    TextField(
                      // maxLength: 14,
                      decoration: InputDecoration(
                        labelText: 'Адрес',
                        labelStyle: TextStyle(
                          fontSize: 18,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      controller: _addressController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      minLines: 1,
                      maxLines: 2,
                      decoration: InputDecoration(
                        labelText: 'Обслуживаемые участки',
                        labelStyle: TextStyle(
                          fontSize: 18,
                        ),
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
                        labelStyle: TextStyle(
                          fontSize: 18,
                        ),
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
                        labelStyle: TextStyle(
                          fontSize: 18,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      minLines: 1,
                      maxLines: 3,
                      controller: _specificationController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Пароли',
                        labelStyle: TextStyle(
                          fontSize: 18,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      minLines: 1,
                      maxLines: 3,
                      controller: _passwordsController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Неисправности',
                        labelStyle: TextStyle(
                          fontSize: 18,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      minLines: 1,
                      maxLines: 4,
                      controller: _malfunctionsController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Примечание',
                        labelStyle: TextStyle(
                          fontSize: 18,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      controller: _notesController,
                      minLines: 1,
                      maxLines: 3,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    // onPrimary: Colors.red[200],
                    primary: Colors.red[700],
                    // onSurface: Colors.red[900],
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.cancel_outlined),
                  label: Text('Отмена'),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('objects')
                        .doc(id)
                        .update({
                      'address': _addressController.text,
                      'servicedParts': _servicedPartsController.text,
                      'contacts': _contactsController.text,
                      'specification': _specificationController.text,
                      'passwords': _passwordsController.text,
                      'malfunctions': _malfunctionsController.text,
                      'notes': _notesController.text,

                      // 'serviceDate': '',
                      // 'isMonthlyService': false,
                      // 'isQuarterlyService': false,
                      // 'isAct': false,
                      // 'isJournal': false,
                    });
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.check),
                  label: Text('Сохранить'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
