import 'package:flutter/material.dart';
import 'package:my_app/model/todo.dart';
import 'package:stacked/stacked.dart';

import 'package:my_app/ui/todolist/todolist_viewmodel.dart';
import 'package:my_app/shared/loading.dart';

/// TodolistView
class TodolistView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// うまい渡し方考える
    final screenSize = MediaQuery.of(context).size;
    return ViewModelBuilder<TodolistViewModel>.reactive(
        viewModelBuilder: () => TodolistViewModel(),
        onModelReady: (model) => model.loadingInfoFake(),
        builder: (context, model, child) => Scaffold(
            body: model.isBusy ? Loading() : _todoView(model, screenSize)));
  }

  /// todoList Main
  /// - _todoList & _todoForm
  Widget _todoView(TodolistViewModel model, Size screenSize) {
    return Container(
      alignment: Alignment.center,
      width: screenSize.width - 96,
      child: Column(
        children: [Expanded(child: _todoList(model)), _todoForm(model)],
      ),
    );
  }

  /// _todoList
  /// - TODOLISTの一覧を表示
  Widget _todoList(TodolistViewModel model) {
    final todos = model.todos;
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
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

  Widget _todoForm(TodolistViewModel model) {
    return Form(
        child: Column(children: [
      TextFormField(
        decoration: InputDecoration(
          labelText: 'メールアドレス',
          labelStyle: TextStyle(color: Color(0xffffff)),
          border: OutlineInputBorder(),
        ),
        onChanged: model.setTodo,
        // validator: () => Fake(),
      ),
      RaisedButton(child: Text('submit'), onPressed: model.submitTodo)
    ]));
  }
}
