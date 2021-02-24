import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:my_app/shared/sidemenu.dart';
import 'package:my_app/shared/appbar.dart';
import 'package:my_app/ui/root/root_viewmodel.dart';
import 'package:my_app/services_locator.dart';
import 'package:my_app/services/configuration.dart';

/// RootView
/// - アプリの骨組み
class RootView extends StatelessWidget {
  final _config = servicesLocator<ConfigurationService>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RootViewModel>.reactive(
      viewModelBuilder: () => RootViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: RootAppBar(),
        drawer: SideMenu(),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          // selectedItemColor: Colors.amber[800],
          backgroundColor: _config.appColor["bottomBackground"],
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: model.bottomNavigationBarItems,
          currentIndex: model.selectedIndex,
          onTap: model.onItemTapped,
        ),
        body: model.selectedWidget,
        // TODO: imple this
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () => model.onPlusButtomTapped(),
        //   backgroundColor: Colors.white,
        //   child: Image.asset(
        //     "images/tabmenu/pencil.png",
        //     // TODO: don't use integer
        //     width: 40,
        //     height: 40,
        //   ),
        // ),
      ),
    );
  }
}
