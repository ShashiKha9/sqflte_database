import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflte_database/modals/notes.dart';


void main() {
  runApp( Notes());
}

class Notes{
  static final  Notes instance = Notes.init();
  Notes.init();
  Future<Database> get database async {
    if(database != null) return database;
    database= await  _initDB('notes.db');
    return database;

  }

  Future<Database>  _initDB(String filePath ){
  final dpPath =  getDatabasesPath();
  final path= join(dpPath,filePath);

  return  openDatabase(path,version: 1,
      onCreate: _createDB);
  }
  Future<void> _createDB(Database db , int version)async {
    final idType = "INTEGER PRIMARY KEY";
    final booltype = "BOOLEAN";
    final integerType="INTEGER";
    final textType= "TEXT";
    
    db.execute('''CREATETABLE $tableNotes(
        ${NoteFields.id} $idType,
        ${NoteFields.isImportant} $booltype,
        ${NoteFields.num} $integerType,
        ${NoteFields.tittle} $textType,
        ${NoteFields.description} $textType,
         ${NoteFields.time} $textType,

    )'''
    );


  }
  Future<Note> insert(Note note ) async {
    final db = await instance.database;
    final id = db.insert(tableNotes, note.toJson());
    return note;
  }
  Future<Note> read(int id) async{
    final db = await instance.database;
    final maps= db.query(
      tableNotes,
      columns: NoteFields.values,
      where: '${NoteFields.id}=?',
      whereArgs: [id],
    );
    if(maps.isNotEmpty){
      return Note.fromJson(maps.first);

    }
    else {
      throw Exception("ID $id IS NOT FOUND");
    }

  }
  Future<int> update(Note note) async {
    final db = await instance.database;
    return db.update(tableNotes, note.toJson(),
      where: '${NoteFields.id}=?',
      whereArgs: [note.id],);


}
Future<int>delete(int id) async {
    final db = await instance.database;
    return await db.delete(tableNotes,
      where: '${NoteFields.id}=?',
      whereArgs: [id],);

}
Future close() async {
    final db = await instance.database;
    db.close();
}
}
