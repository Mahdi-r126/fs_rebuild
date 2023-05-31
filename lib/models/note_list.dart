import 'package:flutter_contacts/flutter_contacts.dart';

class NoteList {
  List<Note> noteList;

  NoteList({required this.noteList});

  factory NoteList.fromJson(Map<String, dynamic> json) {
    var list = json['notes'] as List;
    List<Note> noteList = list.map((i) => Note.fromJson(i)).toList();
    return NoteList(noteList: noteList);
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from({
      'notes': noteList.map((x) => x.toJson()).toList(),
    });
  }
}