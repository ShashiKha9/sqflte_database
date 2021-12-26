import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sqflte_database/pages/notedetailpage.dart';
import 'package:sqflte_database/pages/noteeditpage.dart';
import 'package:sqflte_database/widget/notecard_widget.dart';

import '../main.dart';
import '../modals/notes.dart';

class NotePage extends StatefulWidget{
  NotePageState createState()=> NotePageState();
}
class NotePageState extends State<NotePage>{
   List<Note> ?notes;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    getNotes();
  }

   @override
   void dispose(){
     Notes.instance.close();

     super.dispose();
   }
  Future getNotes() async {
    setState(() => isLoading = true);

    this.notes = await Notes.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
return SafeArea(
    child: Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => NoteEditPage()),
          );
          getNotes();
        },
      ),
      body: Center(
        child: isLoading
        ? CircularProgressIndicator()
        :notes!.isEmpty
        ? Text("No Notes",style: TextStyle(fontSize: 24,color: Colors.white),):
      Container(
        child: StaggeredGridView.countBuilder(crossAxisCount: 4,
            itemCount:notes!.length,
           staggeredTileBuilder: (index)=> StaggeredTile.fit(2  ,
            ),
          mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          itemBuilder: (context,index){
            final note = notes![index];
            return GestureDetector(
              onTap: () async {
               await  Navigator.push(context, MaterialPageRoute(builder: (context)=>NoteDetailPage(noteId: note.id!,)));
               getNotes();
               },

              child: NoteCardWidget(note: note,index: index,),
            );


          },
        ),

      ),

      )
    ));
  }
}