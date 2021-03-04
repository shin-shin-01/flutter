import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:my_app/model/category.dart';
import 'package:my_app/model/friend_wish.dart';
import 'package:my_app/services_locator.dart';
import 'package:my_app/services/api.dart';
import 'package:my_app/services/navigation.dart';
import 'package:my_app/services/data.dart';

class FriendCategoryViewModel extends BaseViewModel {
  final _api = servicesLocator<APIService>();
  final _navigator = servicesLocator<NavigationService>();
  final _data = servicesLocator<DataService>();

  /// categories
  List<Category> categories;
  Map<String, List<FriendWish>> wishes = {};
  List<Tab> category_tabs = [];

  Future<void> initialize() async {
    setBusy(true);

    categories = _data.getCategories;
    await setTabs();

    final getFriendWishesFromApi = await _api.getFriendWishes();
    wishes = getFriendWishesFromApi;

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
}
