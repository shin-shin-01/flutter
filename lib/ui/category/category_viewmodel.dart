import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:my_app/model/category.dart';
import 'package:my_app/model/wish.dart';
import 'package:my_app/services_locator.dart';
import 'package:my_app/services/api.dart';
import 'package:my_app/services/navigation.dart';

class CategoryViewModel extends BaseViewModel {
  final _api = servicesLocator<APIService>();
  final _navigator = servicesLocator<NavigationService>();

  /// categories
  List<Category> categories = [];
  Map<String, List<Wish>> wishes = {};
  List<Tab> category_tabs = [];

  Future<void> initialize() async {
    setBusy(true);

    if (categories.length == 0) {
      final getCategoriesFromApi = await _api.getCategories();
      categories = getCategoriesFromApi;
    }
    await setTabs();

    final getWishesFromApi = await _api.getWishes();
    wishes = getWishesFromApi;

    setBusy(false);
  }

  Future<void> setTabs() async {
    category_tabs = categories
        .map<Tab>((c) => Tab(
            text: c.name,
            icon: Image.asset(
              "images/categories/${c.name}.png",
              // TODO: don't use integer
              width: 30,
              height: 30,
            ),
            iconMargin: EdgeInsets.only(top: 4.0)))
        .toList() as List<Tab>;
  }

  Future<void> deleteWishes(Wish wish) async {
    _navigator.pop();
    await _api.updateWish(wish.id, true);
    await initialize();
  }
}
