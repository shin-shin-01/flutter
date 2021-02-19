import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:my_app/model/category.dart';
import 'package:my_app/services_locator.dart';
import 'package:my_app/services/api.dart';

class CategoryViewModel extends BaseViewModel {
  final _api = servicesLocator<APIService>();

  /// categories
  List<Category> categories = [];
  List<Tab> category_tabs = [];

  Future<void> initialize() async {
    setBusy(true);

    final getCategoriesFromApi = await _api.getCategories();
    categories = getCategoriesFromApi;
    await setTabs();
    setBusy(false);
  }

  Future<void> setTabs() async {
    category_tabs = categories
        .map<Tab>((c) => Tab(
              child: Text(c.name),
            ))
        .toList() as List<Tab>;
  }
}
