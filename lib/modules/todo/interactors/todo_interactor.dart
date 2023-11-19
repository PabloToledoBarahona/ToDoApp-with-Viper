import '../entities/todo.dart';

class TodoInteractor {
  List<Todo> _todos = [];

  List<Todo> getTodos() {
    return _todos;
  }

  void addTodo(Todo todo) {
    _todos.add(todo);
  }

  void deleteTodo(int index) {
    if (index >= 0 && index < _todos.length) {
      _todos.removeAt(index);
    }
  }

  void editTodo(int index, String newTitle) {
    if (index >= 0 && index < _todos.length) {
      _todos[index].title = newTitle;
    }
  }
}
