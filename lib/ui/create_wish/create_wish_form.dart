import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:my_app/shared/progress.dart';
import 'package:my_app/ui/create_wish/create_wish_form_func.dart';
import 'package:my_app/services_locator.dart';
import 'package:my_app/services/configuration.dart';

/// Form画面を作成
class FormView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                ProgressField(),
                NameField(),
                CategoryField(),
                StarField(),
                SizedBox(height: 5),
                SubmitButton(),
              ],
            )));
  }
}

/// Filed 各項目画面作成 ===============================
class ProgressField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateWishFormBloc, FormBlocState>(
        builder: (context, state) {
      return AnimatedContainer(
        duration: Duration(microseconds: 500),
        height: state is FormBlocSubmitting ? 46 : 0,
        padding: EdgeInsets.only(bottom: 16),
        child: LiquidLinearProgressIndicatorWithText(
          percent: state is FormBlocSubmitting
              ? state.progress
              : state is FormBlocSuccess
                  ? 1.0
                  : 0.0,
        ),
      );
    });
  }
}

class NameField extends StatelessWidget {
  final _config = servicesLocator<ConfigurationService>();
  @override
  Widget build(BuildContext context) {
    final formBloc = BlocProvider.of<CreateWishFormBloc>(context);
    return TextFieldBlocBuilder(
      textFieldBloc: formBloc.name,
      decoration: InputDecoration(
          labelText: 'Name',
          filled: true,
          fillColor: _config.appColor["createWishFormBackground"],
          labelStyle: TextStyle(color: _config.appColor["createWishFont"]),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: _config.appColor["createFormBorderColor"],
            ),
          ),
          prefixIcon: PrefixIcon(iconUrl: "images/form/alphabet.png")),
    );
  }
}

class CategoryField extends StatelessWidget {
  final _config = servicesLocator<ConfigurationService>();
  @override
  Widget build(BuildContext context) {
    final formBloc = BlocProvider.of<CreateWishFormBloc>(context);
    return DropdownFieldBlocBuilder<String>(
      selectFieldBloc: formBloc.category,
      decoration: InputDecoration(
          labelText: 'Category',
          filled: true,
          fillColor: _config.appColor["createWishFormBackground"],
          labelStyle: TextStyle(color: _config.appColor["createWishFont"]),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: _config.appColor["createFormBorderColor"],
            ),
          ),
          prefixIcon: PrefixIcon(iconUrl: "images/form/search.png")),
      itemBuilder: (context, value) => value,
    );
  }
}

class StarField extends StatelessWidget {
  final _config = servicesLocator<ConfigurationService>();
  @override
  Widget build(BuildContext context) {
    final formBloc = BlocProvider.of<CreateWishFormBloc>(context);
    return DropdownFieldBlocBuilder<String>(
      selectFieldBloc: formBloc.star,
      decoration: InputDecoration(
          labelText: 'Star',
          filled: true,
          fillColor: _config.appColor["createWishFormBackground"],
          labelStyle: TextStyle(color: _config.appColor["createWishFont"]),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: _config.appColor["createFormBorderColor"],
            ),
          ),
          prefixIcon: PrefixIcon(iconUrl: "images/form/love.png")),
      itemBuilder: (context, value) => value,
    );
  }
}

class SubmitButton extends StatelessWidget {
  final _config = servicesLocator<ConfigurationService>();
  @override
  Widget build(BuildContext context) {
    final formBloc = BlocProvider.of<CreateWishFormBloc>(context);
    return FlatButton.icon(
      icon: Image.asset(
        "images/form/upload.png",
        width: 30,
        height: 30,
      ),
      label: Text(
        'SUBMIT',
        style: TextStyle(color: _config.appColor["text"]),
      ),
      color: _config.appColor["createWishSubmitBackground"],
      onPressed: formBloc.submit,
    );
  }
}

/// Filed ===============================

class PrefixIcon extends StatelessWidget {
  final String iconUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Image.asset(
        iconUrl,
        width: 10,
        height: 10,
      ),
    );
  }

  PrefixIcon({this.iconUrl});
}
