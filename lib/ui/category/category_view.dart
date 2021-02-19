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
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(20),
                  child: TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(child: Text('sample')),
                      Tab(child: Text('sample2')),
                    ],
                  ))),
          body: TabBarView(
              children: [_categoryList(model), _categoryList(model)])),
    );
  }

  Widget _categoryList(CategoryViewModel model) {
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
