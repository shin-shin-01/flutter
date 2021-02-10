import 'package:my_app/model/todo.dart';

/// API Service
class APIService {
  Future<List<Todo>> getTodos() async {
    final fakeTodo = Todo(id: 1, title: "firstTodo", detail: "firstTodoDetail");
    final fakeTodoSec =
        Todo(id: 2, title: "secondTodo", detail: "secondTodoDetail");

    final todos = [fakeTodo, fakeTodoSec];
    return todos;
  }
}
