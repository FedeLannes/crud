// @dart=2.9
import 'package:crud/db/operation.dart';
import 'package:crud/models/note.dart';
import 'package:flutter/material.dart';

class SavePage extends StatefulWidget {
  static const String ROUTE = "/save";

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  final _formkey = GlobalKey<FormState>();

  final titleController = TextEditingController();

  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Note note = ModalRoute.of(context).settings.arguments;
    _init(note);

    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Guardar"),
        ),
        body: Container(
          child: _buildForm(note),
        ),
      ),
    );
  }

  _init(Note note) {
    titleController.text = note.title;
    contentController.text = note.content;
  }

  Widget _buildForm(Note note) {
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
                    if (note.id != null) {
                      note.title = titleController.text;
                      note.content = contentController.text;
                      Operation.update(note);
                    } else {
                      Operation.insert(Note(
                          title: titleController.text,
                          content: contentController.text));
                    }
                  }
                  /*Operation.insert(Note(
                      title: titleController.text,
                      content: contentController.text));*/
                })
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPopScope() {
    return showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
              title:
                  Text("¿Seguro que quieres regresar a la pagina anterionr?"),
              content: Text('Tiene data sin guardar'),
              actions: [
                new TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text("No"),
                ),
                new TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text("Si"))
              ],
            ));
  }
}
