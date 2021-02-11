import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:my_app/shared/sidemenu.dart';
import 'package:my_app/ui/root/root_viewmodel.dart';

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
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.amber[800],
          items: model.bottomNavigationBarItems,
          currentIndex: model.selectedIndex,
          onTap: model.onItemTapped,
        ),
        body: model.selectedWidget,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
    );
  }
}
