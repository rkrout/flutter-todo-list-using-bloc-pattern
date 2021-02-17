import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/blocs/todo/todo.dart';

class AddEditPage extends StatefulWidget{

  final Todo todo;

  AddEditPage({this.todo});

  @override
  State<StatefulWidget> createState() => AddEditPageState();
}

class AddEditPageState extends State<AddEditPage>{

  final TextEditingController _todoController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() { 
    if(widget.todo != null){
      _todoController.text = widget.todo.todo;
      _noteController.text = widget.todo.note;
    }
    super.initState();
  }

  @override
  void dispose() {
    _todoController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( widget.todo == null ? 'Add Todo' : 'Edit Todo')
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _todoController,
              style: TextStyle(  
                fontSize: 18
              ),
              decoration: InputDecoration(
                hintText: 'What need to be done ?',
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
              )
            ),

            SizedBox(height: 15),

            TextField( 
              maxLines: 10,
              controller: _noteController,
              decoration: InputDecoration(
                hintText: 'Additional Notes...',
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
              )
            )
          ]
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          child: Icon(Icons.done),
          onPressed: (){
            if(_todoController.text.isEmpty){
              Scaffold.of(context).showSnackBar(SnackBar(content: Text('Please enter your todo')));
              return;
            }

            if(widget.todo == null){
              BlocProvider.of<TodoBloc>(context).add(TodoAdded(todo: Todo(
                todo: _todoController.text,
                note: _noteController.text
              )));
            }else{
              BlocProvider.of<TodoBloc>(context).add(TodoUpdated(todo: widget.todo.copyWith(
                todo: _todoController.text,
                note: _noteController.text
              )));
            }

            Navigator.pop(context);
          }
        )
      )
    );
  }
}