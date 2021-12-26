import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflte_database/main.dart';
import 'package:sqflte_database/modals/notes.dart';
import 'package:sqflte_database/pages/noteeditpage.dart';
import 'package:intl/intl.dart';




class NoteDetailPage extends StatefulWidget{
   final int noteId;
   NoteDetailPage({Key? key,
     required this.noteId,
}) : super(key: key);
  NoteDetailPageState createState()=> NoteDetailPageState();
}
class NoteDetailPageState extends State<NoteDetailPage>{
  late Note note;
  bool isLoading =false;
  @override
  void initState(){
    super.initState();
    getNotes();

  }
  // delete button
   deleteButton(){
    IconButton(onPressed: () async {
      await Notes.instance.delete(widget.noteId);
    }, icon: Icon(Icons.delete));
    Navigator.pop(context);
  }
  // edit button
  editButton(){
    IconButton(onPressed: () async {
      if(isLoading)return;
      await Navigator.push(context, MaterialPageRoute(builder: (context)=> NoteEditPage(noteId: note)));
      getNotes();
    }, icon: Icon(Icons.edit_outlined));
  }
  Future getNotes()async {
    setState(()  async {
      isLoading =true;
      this.note = await Notes.instance.read(widget.noteId);
      isLoading =false;

    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
    child: Scaffold(
      appBar: AppBar(
        actions: [editButton(),deleteButton()],
      ),
      body: isLoading ?
      CircularProgressIndicator()
      : Padding(padding: EdgeInsets.all(12),
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 8),
        children: [
          Text(
            note.tittle,
            style: TextStyle(
              color: Colors.white
            ),
          ),
          SizedBox(height: 8,),
          Text(
            DateFormat.yMMMd().format(note.createdTime),
          ),
          SizedBox(height: 8,),
          Text(note.description,style: TextStyle(color: Colors.white,fontSize: 18),)
        ],
      ),),



    ))  ;
  }

}