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
  Map<String, List<FriendWish>> wishes;
  List<Tab> category_tabs = [];

  Future<void> initialize() async {
    // 初回のみ実行
    if (category_tabs.length == 0) {
      setBusy(true);

      categories = await _data.getCategories;

      await _api.getFriendWishes();
      wishes = _data.getFriendWishes;

      await setTabs();
      setBusy(false);
    }
  }

  Future<void> reload() async {
    setBusy(true);
    await _api.getFriendWishes();
    wishes = _data.getFriendWishes;
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
