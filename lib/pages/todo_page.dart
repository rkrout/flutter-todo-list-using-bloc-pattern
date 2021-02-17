import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/pages/add_edit_page.dart';
import 'package:todo_app/blocs/todo/todo.dart';

class TodoPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(  
          title: Text('Todo List'),
          actions: <PopupMenuButton>[
            PopupMenuButton(
              onSelected: (value){
                if(value == 'mark_all_completed'){
                  BlocProvider.of<TodoBloc>(context).add(MarkAllCompleted());
                }else if(value == 'delete_all_completed'){
                  BlocProvider.of<TodoBloc>(context).add(DeleteAllCompleted());
                }
              },
              itemBuilder: (_) => <PopupMenuItem>[
                PopupMenuItem(  
                  child: Text('Mark All Completed'),
                  value: 'mark_all_completed',
                ),
                PopupMenuItem(  
                  child: Text('Delete All Completed'),
                  value: 'delete_all_completed',
                )
              ]
            )
          ]
        ),
        body: _buildBody(state.todos),
        floatingActionButton: FloatingActionButton(  
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(fullscreenDialog: true, builder: (_) => AddEditPage()));
          }
        ),
      ),
    );
  }

  Widget _buildBody(List<Todo> todos){
    if(todos == null){
      return Container();
    }

    if(todos.length == 0){
      return Center(child: Text('No Todo Found'));
    }

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, position) => ListTile(
        onTap: () => Navigator.push(context, MaterialPageRoute(fullscreenDialog: true, builder: (_) => AddEditPage(todo: todos[position]))),
        title: Text(todos[position].todo),
        subtitle: Text(todos[position].note),
        leading: Checkbox(
          value: todos[position].isCompleted,
          onChanged: (_){
            BlocProvider.of<TodoBloc>(context).add(TodoUpdated(
              todo: todos[position].copyWith(isCompleted: !todos[position].isCompleted)
            ));
          },
        ),
        trailing: IconButton(icon: Icon(Icons.delete), onPressed: (){
          BlocProvider.of<TodoBloc>(context).add(TodoDeleted(
            todo: todos[position]
          ));
        })
      )
    );
  }
}