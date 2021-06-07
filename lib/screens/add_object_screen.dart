import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddObject extends StatefulWidget {
  static const routeName = '/add-object';

  @override
  _AddObjectState createState() => _AddObjectState();
}

class _AddObjectState extends State<AddObject> {
  var _addressController = TextEditingController();
  var _servicedPartsController = TextEditingController();
  var _contactsController = TextEditingController();
  var _specificationController = TextEditingController();
  var _passwordsController = TextEditingController();
  var _malfunctionsController = TextEditingController();
  var _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить объект'),
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
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              FirebaseFirestore.instance.collection('objects').add({
                'address': _addressController.text,
                'servicedParts': _servicedPartsController.text,
                'contacts': _contactsController.text,
                'specification': _specificationController.text,
                'passwords': _passwordsController.text,
                'malfunctions': _malfunctionsController.text,
                'notes': _notesController.text,

                // 'serviceDate': '',
                'isMonthlyService': false,
                'isQuarterlyService': false,
                'isAct': false,
                'isJournal': false,
              });
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.check),
            label: Text('Сохранить'),
          ),
        ],
      ),
    );
  }
}
