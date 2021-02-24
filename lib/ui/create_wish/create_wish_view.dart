import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:my_app/services_locator.dart';
import 'package:my_app/services/navigation.dart';
import 'package:my_app/services/configuration.dart';
import 'package:my_app/ui/create_wish/create_wish_form.dart';
import 'package:my_app/ui/create_wish/create_wish_form_func.dart';

/// TODO: リファクタリング
/// CreateWishView Main画面
class CreateWishView extends StatelessWidget {
  final _navigation = servicesLocator<NavigationService>();
  final _config = servicesLocator<ConfigurationService>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CreateWishFormBloc(),
        child: Builder(builder: (context) {
          return Theme(
              data: Theme.of(context).copyWith(
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              child: Scaffold(
                appBar: AppBar(
                  title: Text("Create Wish!",
                      style: TextStyle(color: _config.appColor["text"])),
                  backgroundColor: _config.appColor["createWishBackgound"],
                ),
                body: FormBlocListener<CreateWishFormBloc, String, String>(
                  /// 成功時の処理
                  onSuccess: (context, state) {
                    _navigation.pushAndReplace(routeName: '/success');
                  },
                  onFailure: (context, state) {},
                  child: FormView(),
                ),
              ));
        }));
  }
}
