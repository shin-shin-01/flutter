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
    return Container(
      height: screenSize.height,
      width: screenSize.width,
      child: Column(
        children: [Expanded(child: _categoryList(model))],
      ),
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
