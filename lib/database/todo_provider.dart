import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/todo.dart';


class TodoProvider{

  Future<Todo> insert(Todo todo) async{
    final db = await database();
    int result = await db.insert('todo', todo.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    print(result);
    return todo.copyWith(id: result);
  }

  Future<void> update(Todo todo) async{
    final db = await database();
    db.update('todo', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<void> delete(Todo todo) async{
    final db = await database();
    db.delete('todo', where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<List<Todo>> getAll() async{
    final db = await database();
    List<Map<String, dynamic>> todos = await db.query('todo');
    return todos.map((e) => Todo.fromMap(e)).toList();
  }

  Future<void> markAllCompleted() async{
    final db = await database();
    db.update('todo', {'isCompleted': 1});
  }

  Future<void> deleteAllCompleted() async{
    final db = await database();
    db.delete('todo', where: 'isCompleted = 1');
  }

  Future<Database> database() async => openDatabase(
    join(await getDatabasesPath(), 'todo_database.db'),
    onCreate: (db, version) => db.execute(
        "CREATE TABLE todo(id INTEGER PRIMARY KEY AUTOINCREMENT, todo TEXT, note TEXT, isCompleted INTEGER)",
    ),
    version: 2,
  );
}