import 'package:stacked/stacked.dart';
import "dart:async";

import 'package:my_app/model/todo.dart';
import 'package:my_app/services_locator.dart';
import 'package:my_app/services/api.dart';

/// TodolistViewModel
class TodolistViewModel extends BaseViewModel {
  final _api = servicesLocator<APIService>();

  /// todos
  /// - Todoたち
  List<Todo> todos = [];

  /// todo
  /// - inputed by user
  String _todo = "";

  Future<void> loadingInfoFake() async {
    setBusy(true);

    final getTodoFromApi = await _api.getTodos();
    await new Future.delayed(new Duration(seconds: 5));

    todos = getTodoFromApi;
    setBusy(false);
  }

  /// Save user's Input
  void setTodo(String enteredTodo) {
    _todo = enteredTodo;
  }

  /// Save Todo to TodoList
  /// - Submitted Todo by user
  void submitTodo() {
    Todo newTodo =
        new Todo(id: todos.length + 1, title: _todo, detail: "detail");
    todos.add(newTodo);
    notifyListeners();
  }
}
