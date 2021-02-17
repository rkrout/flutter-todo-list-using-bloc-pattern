import 'package:equatable/equatable.dart';
import 'package:todo_app/models/todo.dart';

class TodoState extends Equatable{

  final List<Todo> todos;

  factory TodoState.initial(){
    return TodoState(
      todos: null,
    );
  }

  TodoState({this.todos});

  @override
  List<Object> get props => [todos];
}