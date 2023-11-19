import '../entities/todo.dart';
import '../interactors/todo_interactor.dart';

class TodoPresenter {
  final TodoInteractor _interactor;
  late Function(List<Todo>) onViewUpdate;

  TodoPresenter(this._interactor);

  void loadTodos() {
    var todos = _interactor.getTodos();
    onViewUpdate(todos);
  }

  void addTodo(String title) {
    var newTodo = Todo(title: title);
    _interactor.addTodo(newTodo);
    loadTodos();
  }

  void deleteTodo(int index) {
    _interactor.deleteTodo(index);
    loadTodos();
  }

  void editTodo(int index, String newTitle) {
    _interactor.editTodo(index, newTitle);
    loadTodos();
  }
}
