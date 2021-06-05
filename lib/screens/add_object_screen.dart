import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddObject extends StatefulWidget {
  static const routeName = '/add-object';

  @override
  _AddObjectState createState() => _AddObjectState();
}

class _AddObjectState extends State<AddObject> {
  final _titleController = TextEditingController();
  final _contactsController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Карточка объекта'),
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
                      decoration: InputDecoration(labelText: 'Адрес'),
                      controller: _titleController,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Контакты'),
                      controller: _contactsController,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Заметки'),
                      controller: _notesController,
                    ),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              FirebaseFirestore.instance.collection('objects').add({
                'address': _titleController.text.trim(),
                'contacts': _contactsController.text.trim(),
                'notes': _notesController.text.trim(),
                'createdTime': Timestamp.now(),
                'to': false,
              });
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.check),
            label: Text('Сохранить'),
          )
        ],
      ),
    );
  }
}
