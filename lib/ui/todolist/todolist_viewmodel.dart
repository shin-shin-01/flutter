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

  Future<void> loadingInfoFake() async {
    setBusy(true);

    final getTodoFromApi = await _api.getTodos();
    await new Future.delayed(new Duration(seconds: 5));

    todos = getTodoFromApi;
    setBusy(false);
  }
}
