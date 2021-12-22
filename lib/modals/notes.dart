final String tableNotes = "notes";

class NoteFields{
  static final List<String> values =[
    id,isImportant,num,tittle,description,time
  ];
  static final String id ="_id";
  static final String isImportant ="isImportant";
  static final String num ="num";
  static final String tittle ="tittle";
  static final String description ="description";
  static final String time ="time";


}
class Note{
  final int id;
  final bool isImportant;
  final int num;
  final String tittle;
  final String description;
  final DateTime createdTime;

  Note({
    required this.id,
    required this.isImportant,
    required this.num,
    required this.tittle,
    required this.description,
    required this.createdTime,

});
  Map<String,dynamic> toJson()=>{
    NoteFields.id:id,
    NoteFields.tittle:tittle,
    NoteFields.num:num,
    NoteFields.isImportant:isImportant ?1:0,
    NoteFields.description:description,
    NoteFields.time:createdTime.toIso8601String(),




  }
}
