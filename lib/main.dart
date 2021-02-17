import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/todo/todo_bloc.dart';
import 'package:todo_app/database/todo_provider.dart';
import 'package:todo_app/pages/todo_page.dart';

import 'blocs/todo/todo_event.dart';

void main() => runApp(App());


class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoBloc(todoProvider: TodoProvider())..add(LoadTodo()),
      child: MaterialApp(
        title: 'Todo App',
        home: TodoPage(),
      )
    );
  }
}