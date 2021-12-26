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
  Widget deleteButton()=>
    IconButton(onPressed: () async {
      await Notes.instance.delete(widget.noteId);
      Navigator.pop(context);
    }, icon: Icon(Icons.delete));

  // edit button
  Widget editButton()=>
    IconButton(onPressed: () async {
      if(isLoading)return;
      await Navigator.push(context, MaterialPageRoute(builder: (context)=> NoteEditPage(noteId: note)));
      getNotes();
    }, icon: Icon(Icons.edit_outlined));

  Future getNotes()async {
    setState(()  =>
      isLoading =true);
      this.note = await Notes.instance.read(widget.noteId);
      setState(()=>
        isLoading =false);


  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
    child: Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [editButton(),deleteButton()],
      ),
      body: isLoading ?
      CircularProgressIndicator()
      : Padding(padding: EdgeInsets.all(12),
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 8),
        children: [
          Text(
            DateFormat.yMMMd().format(note.createdTime),style: TextStyle(color: Colors.white54),
          ),
          SizedBox(height: 12,),
          Text(
            note.tittle,
            style: TextStyle(
              color: Colors.white54,
              fontSize: 20
            ),
          ),
          SizedBox(height: 8,),

          SizedBox(height: 8,),
          Text(note.description,style: TextStyle(color: Colors.white54,fontSize: 16),)
        ],
      ),),



    ))  ;
  }

}