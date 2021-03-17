import 'dart:io';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/model/category.dart';
import 'package:my_app/model/wish.dart';
import 'package:my_app/services_locator.dart';
import 'package:my_app/services/api.dart';
import 'package:my_app/services/firebase_api.dart';
import 'package:my_app/services/navigation.dart';
import 'package:my_app/services/data.dart';

class CategoryViewModel extends BaseViewModel {
  final _api = servicesLocator<APIService>();
  final _navigator = servicesLocator<NavigationService>();
  final _data = servicesLocator<DataService>();
  final _firebase_api = servicesLocator<FirebaseAPIService>();
  final picker = ImagePicker();

  /// categories
  List<Category> categories;
  Map<String, List<Wish>> wishes;
  List<Tab> category_tabs = [];

  Future<void> initialize() async {
    // 初回のみ実行
    if (category_tabs.length == 0) {
      setBusy(true);

      categories = await _data.getCategories;

      await _api.getWishes();
      wishes = _data.getWishes;

      await setTabs();
      setBusy(false);
    }
  }

  Future<void> reload() async {
    setBusy(true);
    await _api.getWishes();
    wishes = _data.getWishes;
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

  //  画像処理
  Future uploadImageToFirebase(file, Wish wish) async {
    return await _firebase_api.uploadImage(wish.id, File(file.path));
  }

  Future getImageFromGalleryOrCamera(source) async {
    // 画像が重すぎるため圧縮
    return await picker.getImage(source: source, imageQuality: 30);
  }

  Future imageFunction(String type, Wish wish) async {
    setBusy(true);

    var file;
    if (type == "gallery") {
      file = await getImageFromGalleryOrCamera(ImageSource.gallery);
    } else {
      file = await getImageFromGalleryOrCamera(ImageSource.camera);
    }
    final imageUrl = await uploadImageToFirebase(file, wish);
    if (imageUrl != null) {
      await _api.createImage(wish.id, imageUrl);
      wish.imageUrl = imageUrl;
    } else {
      _navigator.pushNamedAndRemoveUntil(routeName: '/error');
    }
    _navigator.pushNamedAndRemoveUntil(routeName: '/root');
  }
}
