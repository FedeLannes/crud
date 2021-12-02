// @dart=2.9
import 'package:crud/db/operation.dart';
import 'package:crud/models/note.dart';
import 'package:flutter/material.dart';

class SavePage extends StatelessWidget {
  static const String ROUTE = "/save";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guardar"),
      ),
      body: Container(
        child: _FormSave(),
      ),
    );
  }
}

class _FormSave extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: titleController,
              validator: (value) {
                if (value.isEmpty) {
                  return "tiene que colocar data";
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: "titulo", border: OutlineInputBorder()),
            ),
            SizedBox(height: 30.0),
            TextFormField(
              controller: contentController,
              maxLines: 8,
              maxLength: 1000,
              validator: (value) {
                if (value.isEmpty) {
                  return "tiene que colocar data";
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: "contenedor", border: OutlineInputBorder()),
            ),
            ElevatedButton(
                child: Text("Guardar"),
                onPressed: () {
                  if (_formkey.currentState.validate()) {
                    print("valido " + titleController.text);

                    Operation.insert(Note(
                        title: titleController.text,
                        content: contentController.text));
                  }
                })
          ],
        ),
      ),
    );
  }
}
