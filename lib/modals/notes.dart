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
  final int? id;
  final bool isImportant;
  final int num;
  final String tittle;
  final String description;
  final DateTime createdTime;

 const Note({
     this.id,
    required this.isImportant,
    required this.num,
    required this.tittle,
    required this.description,
    required this.createdTime,


});
  Note copy({
    int? id,
    bool? isImportant,
    int? num,
    String? title,
    String? description,
    DateTime? createdTime,
  }) =>
      Note(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        num: num ?? this.num,
        tittle: title ?? this.tittle,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );
  static Note fromJson(Map<String,Object?>json)=>Note(
    id: json[NoteFields.id] as int,
    isImportant: json[NoteFields.isImportant] ==1,
    num: json[NoteFields.num] as int,
    tittle: json[NoteFields.tittle] as String,
    description: json[NoteFields.description] as String,
    createdTime: DateTime.parse(json[NoteFields.time] as String),




  );
  Map<String,dynamic> toJson()=> {
        NoteFields.id: id,
        NoteFields.tittle: tittle,
        NoteFields.num: num,
        NoteFields.isImportant: isImportant ? 1 : 0,
        NoteFields.description: description,
        NoteFields.time: createdTime.toIso8601String(),

      };
}
