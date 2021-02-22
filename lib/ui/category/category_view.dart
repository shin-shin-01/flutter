import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:my_app/model/wish.dart';
import 'package:my_app/ui/category/category_viewmodel.dart';
import 'package:my_app/shared/loading.dart';

class CategoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return ViewModelBuilder<CategoryViewModel>.reactive(
        viewModelBuilder: () => CategoryViewModel(),
        onModelReady: (model) => model.initialize(),
        builder: (context, model, child) => Scaffold(
            body: model.isBusy ? Loading() : _categoryView(model, screenSize)));
  }

  Widget _categoryView(CategoryViewModel model, Size screenSize) {
    final category_tabs = model.category_tabs;
    return DefaultTabController(
        length: category_tabs.length,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(20),
                  child: TabBar(
                    indicatorColor: Colors.green,
                    labelColor: Colors.green,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: TextStyle(fontSize: 12),
                    isScrollable: true,
                    tabs: category_tabs,
                  ))),
          body: TabBarView(
              children: category_tabs
                  .map((tab) => _wishList(model, tab.text))
                  .toList()),
        ));
  }

  Widget _wishList(CategoryViewModel model, String category_name) {
    final wishes = model.wishes[category_name];

    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(8),
        itemCount: wishes.length,
        itemBuilder: (context, i) => _wishTile(wishes[i]));
  }

  Widget _wishTile(Wish wish) {
    return Card(
      child: ListTile(
        title: Text(wish.name),
      ),
    );
  }
}
