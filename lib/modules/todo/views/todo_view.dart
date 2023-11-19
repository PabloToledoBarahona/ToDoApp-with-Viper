// lib/modules/todo/views/todo_view.dart
import 'package:flutter/material.dart';
import '../entities/todo.dart';
import '../presenters/todo_presenter.dart';
import '../interactors/todo_interactor.dart';

class TodoView extends StatefulWidget {
  @override
  _TodoViewState createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  final TodoPresenter _presenter = TodoPresenter(TodoInteractor());
  late List<Todo> _todos;

  @override
  void initState() {
    super.initState();
    _presenter.onViewUpdate = (todos) {
      setState(() {
        _todos = todos;
      });
    };
    _presenter.loadTodos();
  }

  void _showAddTodoDialog({int? index}) {
    TextEditingController controller = TextEditingController();
    if (index != null) {
      controller.text = _todos[index].title;
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(index == null ? 'Nueva Tarea' : 'Editar Tarea'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: "Título de la tarea"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(index == null ? 'Agregar' : 'Actualizar'),
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  if (index == null) {
                    _presenter.addTodo(controller.text);
                  } else {
                    _presenter.editTodo(index, controller.text);
                  }
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VIPER Todos', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoDialog(),
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }

  Widget _buildTodoList() {
    return ListView.builder(
      itemCount: _todos.length,
      itemBuilder: (context, index) {
        var todo = _todos[index];
        return Card(
          child: ListTile(
            title: Text(todo.title, style: TextStyle(fontSize: 18)),
            leading: Icon(
              todo.isCompleted ? Icons.check_circle : Icons.check_circle_outline,
              color: Colors.green,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _showAddTodoDialog(index: index),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _presenter.deleteTodo(index),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
