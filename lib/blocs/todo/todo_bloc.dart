import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/todo/todo_event.dart';
import 'package:todo_app/blocs/todo/todo_state.dart';
import 'package:todo_app/database/todo_provider.dart';
import 'package:todo_app/models/todo.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState>{

  TodoProvider todoProvider;

  TodoBloc({this.todoProvider}) : super(TodoState.initial());

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async*{
    if(event is LoadTodo){
      yield await _mapLoadTodoToState(event);
    }else if(event is TodoAdded){
      yield await _mapTodoAddedToState(event);
    }else if(event is TodoUpdated){
      yield _mapTodoUpdatedToState(event);
    }else if(event is TodoDeleted){
      yield _mapTodoDeletedToState(event);
    }else if(event is MarkAllCompleted){
      yield _mapMarkAllCompletedToState(event);
    }else if(event is DeleteAllCompleted){
      yield _mapDeleteAllCompletedToState(event);
    }
  }

  _mapLoadTodoToState(LoadTodo event) async {
    return TodoState(todos: await todoProvider.getAll());
  }

  _mapTodoAddedToState(TodoAdded event) async {
    List<Todo> todos = List.from(state.todos);
    todos.add(await todoProvider.insert(event.todo));
    return TodoState(todos: todos);
  }

  _mapTodoUpdatedToState(TodoUpdated event){
    todoProvider.update(event.todo);
    return TodoState(todos: state.todos.map((e){
      return e.id == event.todo.id ? event.todo : e;
    }).toList());
  }

  _mapTodoDeletedToState(TodoDeleted event){
    todoProvider.delete(event.todo);
    return TodoState(todos: state.todos.where((element) => element.id != event.todo.id).toList());
  }

  _mapMarkAllCompletedToState(MarkAllCompleted event){
    todoProvider.markAllCompleted();
    return TodoState(todos: state.todos.map((e){
      return e.copyWith(isCompleted: true);
    }).toList());
  }

  _mapDeleteAllCompletedToState(DeleteAllCompleted event){
    todoProvider.deleteAllCompleted();
    return TodoState(todos: state.todos.where((element) => !element.isCompleted).toList());
  }

}