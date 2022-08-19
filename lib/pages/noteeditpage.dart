import 'package:flutter/material.dart';

import '../main.dart';
import '../modals/notes.dart';
import '../widget/notefrom_widget.dart';

class NoteEditPage extends StatefulWidget {
  final Note? note;
   final int? noteId;


  const NoteEditPage({
    Key? key,
    this.note,
      this.noteId
  }) : super(key: key);
  @override
  _NoteEditPage createState() => _NoteEditPage();
}

class _NoteEditPage extends State<NoteEditPage> {
  final _formKey = GlobalKey<FormState>();
  late bool isImportant;
  late int number;
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();

    isImportant = widget.note?.isImportant ?? false;
    number = widget.note?.num ?? 0;
    title = widget.note?.title ?? '';
    description = widget.note?.description ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black,
    appBar: AppBar(
      backgroundColor: Colors.black,
      actions: [buildButton(),deleteButton()],
    ),
    body: Form(
      key: _formKey,
      child: NoteFormWidget(
        isImportant: isImportant,
        number: number,
        title: title,
        description: description,
        onChangedImportant: (isImportant) =>
            setState(() => this.isImportant = isImportant),
        onChangedNumber: (number) => setState(() => this.number = number),
        onChangedTitle: (title) => setState(() => this.title = title),
        onChangedDescription: (description) =>
            setState(() => this.description = description),
      ),
    ),
  );

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: IconButton(
        color:isFormValid ? null : Colors.grey.shade700,
        // style: ElevatedButton.styleFrom(
        //   onPrimary: Colors.white,
        //   primary: isFormValid ? null : Colors.grey.shade700,
        // ),
        onPressed: addOrUpdateNote,
        icon: Icon(Icons.check),
      ),
    );
  }
  // delete button
  Widget deleteButton()=>
      IconButton(onPressed: () async {
        await Notes.instance.delete(widget.noteId!);
        Navigator.pop(context);
      }, icon: Icon(Icons.delete));


  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
    final note = widget.note!.copy(
      isImportant: isImportant,
      num: number,
      title: title,
      description: description,
    );

    await Notes.instance.update(note);
  }

  Future addNote() async {
    final note = Note(
      title: title,
      isImportant: true,
      num: number,
      description: description,
      createdTime: DateTime.now(),
    );

    await Notes.instance.insert(note);
  }
}