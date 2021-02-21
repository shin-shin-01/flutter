import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:my_app/model/category.dart';
import 'package:my_app/model/wish.dart';
import 'package:my_app/services_locator.dart';
import 'package:my_app/services/api.dart';

class CategoryViewModel extends BaseViewModel {
  final _api = servicesLocator<APIService>();

  /// categories
  List<Category> categories = [];
  Map<String, List<Wish>> wishes = {};
  List<Tab> category_tabs = [];

  Future<void> initialize() async {
    setBusy(true);

    final getCategoriesFromApi = await _api.getCategories();
    categories = getCategoriesFromApi;
    await setTabs();

    /// TODO: リファクタリング 思い処理してる
    for (Category category in categories) {
      final category_id = category.id;
      print("wish #GET request ${category_id}");
      final getWishesFromApi = await _api.getWishes(category_id);
      wishes[category.name] = getWishesFromApi;
    }
    print(wishes);

    setBusy(false);
  }

  Future<void> setTabs() async {
    category_tabs = categories
        .map<Tab>((c) => Tab(
            text: c.name,
            icon: Image.asset(
              "images/${c.name}.png",
              // TODO: don't use integer
              width: 40,
              height: 40,
            ),
            iconMargin: EdgeInsets.only(top: 5.0)))
        .toList() as List<Tab>;
  }
}
