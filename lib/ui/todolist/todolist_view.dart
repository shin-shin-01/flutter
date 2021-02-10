import 'package:flutter/material.dart';
import 'package:my_app/model/todo.dart';
import 'package:stacked/stacked.dart';

import 'package:my_app/ui/todolist/todolist_viewmodel.dart';
import 'package:my_app/shared/loading.dart';

/// TodolistView
class TodolistView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TodolistViewModel>.reactive(
        viewModelBuilder: () => TodolistViewModel(),
        onModelReady: (model) => model.loadingInfoFake(),
        builder: (context, model, child) =>
            Scaffold(body: model.isBusy ? Loading() : _todoList(model)));
  }

  /// _todoList
  /// - TODOLISTの一覧を表示
  Widget _todoList(TodolistViewModel model) {
    final todos = model.todos;
    return ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: todos.length,
        itemBuilder: (context, i) => _todoTile(todos[i]));
  }

  Widget _todoTile(Todo todo) {
    return Card(
      child: ListTile(
        title: Text(todo.title),
      ),
    );
  }
}
