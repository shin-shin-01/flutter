import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:my_app/model/category.dart';
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
    final categories = model.categories;
    final category_tabs = model.category_tabs;
    return DefaultTabController(
      length: category_tabs.length,
      child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(20),
                  child: TabBar(
                    labelStyle: TextStyle(
                      fontSize: 0,
                    ),
                    isScrollable: true,
                    tabs: category_tabs,
                  ))),
          body: TabBarView(
              children: category_tabs
                  .map((tab) => _categoryList(model, tab.text))
                  .toList())),
    );
  }

  Widget _categoryList(CategoryViewModel model, String name) {
    final categories = model.categories;
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(8),
        itemCount: categories.length,
        itemBuilder: (context, i) => _categoryTile(categories[i]));
  }

  Widget _categoryTile(Category category) {
    return Card(
      child: ListTile(
        title: Text(category.name),
      ),
    );
  }
}
