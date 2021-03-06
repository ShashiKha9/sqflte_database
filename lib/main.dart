import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflte_database/modals/notes.dart';
import 'package:sqflte_database/pages/notepage.dart';


void main() {
  runApp( MaterialApp(home:NotePage()));
}

class Notes{
  static final  Notes instance = Notes.init();

  static Database? _database;
  Notes.init();
  Future<Database?> get database async {
    if(_database != null) return _database;
    _database= await  _initDB('notes.db');
    return _database;
  }


  Future<Database>  _initDB(String filePath ) async {
  final dpPath = await  getDatabasesPath();
  final  path= join(dpPath,filePath);


  return  await openDatabase(path,version: 1, onCreate: _createDB);
  }
  Future<void> _createDB(Database db , int version)async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final booltype = 'BOOLEAN';
    final integerType='INTEGER';
    final textType= 'TEXT';
    
    await db.execute('''
    CREATE TABLE $tableNotes (
       ${NoteFields.id } $idType,
       ${NoteFields.isImportant} $booltype,
     ${NoteFields.num} $integerType,
        ${NoteFields.tittle} $textType,
        ${NoteFields.description} $textType,
         ${NoteFields.time} $textType
    )'''
    );


  }
  //create database
  Future<Note> insert(Note note ) async {
    final db = await instance.database;
    final id = db!.insert(tableNotes, note.toJson());
    return note.copy(id: note.id);
  }
  //read from data
  Future<Note> read(int id) async{
    final db = await instance.database;
    final maps= await db!.query(
      tableNotes,
      columns: NoteFields.values,
      where: '${NoteFields.id}=?',
      whereArgs: [id],
    );
    if(maps.isNotEmpty){
      return Note.fromJson(maps.first);
    } else {
      throw Exception("ID $id IS NOT FOUND");
    }

  }
  //read all notes
  Future <List<Note>> readAllNotes() async {
    final db = await  instance.database;
    final orderBy = '${NoteFields.time} ASC';
    final result= await db!.query(tableNotes,orderBy: orderBy);
    return result.map((json) => Note.fromJson(json)).toList();

  }
  //update the  data
  Future<int> update(Note note) async {
    final db = await instance.database;
    return db!.update(tableNotes, note.toJson(),
      where: '${NoteFields.id}=?',
      whereArgs: [note.id],);


}
// delete the data
Future<int>delete(int id) async {
    final db = await instance.database;
    return await db!.delete(tableNotes,
      where: '${NoteFields.id}=?',
      whereArgs: [id],);

}
Future close() async {
    final db = await instance.database;
    db!.close();
}
}
