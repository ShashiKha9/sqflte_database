import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'modals/notes.dart';

class NotePage extends StatefulWidget{
  NotePageState createState()=> NotePageState();
}
class NotePageState extends State<NotePage>{
  late List<Note>notes;
  bool isLoading = false;
  @override
  void dispose(){
    
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
return SafeArea(
    child: Scaffold());
  }
}