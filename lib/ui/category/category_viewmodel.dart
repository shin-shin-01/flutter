import 'package:stacked/stacked.dart';

import 'package:my_app/model/category.dart';
import 'package:my_app/services_locator.dart';
import 'package:my_app/services/api.dart';

class CategoryViewModel extends BaseViewModel {
  final _api = servicesLocator<APIService>();

  /// categories
  List<Category> categories = [];

  Future<void> initialize() async {
    setBusy(true);

    final getCategoriesFromApi = await _api.getCategories();
    categories = getCategoriesFromApi;
    setBusy(false);
  }
}
