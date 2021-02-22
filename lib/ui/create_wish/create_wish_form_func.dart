import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:my_app/services/api.dart';
import 'package:my_app/services_locator.dart';

/// Form 各項目の作成
class CreateWishFormBloc extends FormBloc<String, String> {
  final _api = servicesLocator<APIService>();
  final name = TextFieldBloc(name: 'name');
  final star = SelectFieldBloc(
    name: 'star',
    items: ['Like: 1', 'Like: 2', 'Like: 3', 'Like: 4', 'Like: 5'],
  );
  // List category_list = categories.
  final category = SelectFieldBloc(
    name: 'category',

    /// get Category
    items: ['1: place', '2: fashion', '3: food', '4: machine', '5: music'],
  );

  CreateWishFormBloc() {
    addFieldBlocs(fieldBlocs: [name, star, category]);
  }

  @override
  void onSubmitting() async {
    /// フォーム送信時の処理
    try {
      final stateJson = state.toJson();
      final name = stateJson['name'];
      final star = int.parse(stateJson['star'][stateJson['star'].length - 1]);
      final categoryId = int.parse(stateJson['category'][0]);

      emitSubmitting(progress: 0.5);
      await _api.createWish(name, star, categoryId);
      emitSubmitting(progress: 1.0);
      emitSuccess();
    } catch (e) {
      emitFailure();
    }
  }
}
