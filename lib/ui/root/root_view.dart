import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:my_app/shared/sidemenu.dart';
import 'package:my_app/ui/root/root_viewmodel.dart';
import 'package:my_app/ui/todolist/todolist_view.dart';

/// RootView
/// - アプリの骨組み
class RootView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RootViewModel>.reactive(
      viewModelBuilder: () => RootViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(),
        drawer: SideMenu(),
        backgroundColor: Theme.of(context).backgroundColor,
        body: TodolistView(),
      ),
    );
  }
}
