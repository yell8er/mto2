import 'package:flutter/material.dart';

class AddObject extends StatefulWidget {
  static const routeName = '/add-object';

  @override
  _AddObjectState createState() => _AddObjectState();
}

class _AddObjectState extends State<AddObject> {
  final _titleController = TextEditingController();

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
                    TextField(),
                    TextField(),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.add),
            label: Text('Добавить объект'),
          )
        ],
      ),
    );
  }
}
