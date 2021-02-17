import 'package:equatable/equatable.dart';

class Todo extends Equatable{
  final int id;
  final String todo;
  final String note;
  final bool isCompleted;

  Todo({this.id, this.note, this.todo, this.isCompleted = false});

  @override
  List<Object> get props => [id, todo, note, isCompleted];

  Todo copyWith({int id, String todo, String note, bool isCompleted}){
    return Todo(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      note: note ?? this.note,
      isCompleted: isCompleted ?? this.isCompleted
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'todo': todo,
      'note': note,
      'isCompleted': isCompleted ? 1 : 0
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map){
    return Todo(
      id: map['id'],
      todo: map['todo'],
      note: map['note'],
      isCompleted: map['isCompleted'] == 1 ? true : false
    );
  }
}