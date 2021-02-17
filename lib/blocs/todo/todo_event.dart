import 'package:todo_app/models/todo.dart';

abstract class TodoEvent{}

class LoadTodo extends TodoEvent{}

class MarkAllCompleted extends TodoEvent{}

class DeleteAllCompleted extends TodoEvent{}

class TodoUpdated extends TodoEvent{
  final Todo todo;

  TodoUpdated({this.todo});

}

class TodoAdded extends TodoEvent{
  final Todo todo;

  TodoAdded({this.todo});

}

class TodoDeleted extends TodoEvent{
  final Todo todo;

  TodoDeleted({this.todo});
}


