import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:my_app/shared/progress.dart';
import 'package:my_app/ui/create_wish/create_wish_form_func.dart';

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
  @override
  Widget build(BuildContext context) {
    final formBloc = BlocProvider.of<CreateWishFormBloc>(context);
    return TextFieldBlocBuilder(
      textFieldBloc: formBloc.name,
      decoration: InputDecoration(
          labelText: 'Name',
          prefixIcon: PrefixIcon(iconUrl: "images/form/alphabet.png")),
    );
  }
}

class CategoryField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formBloc = BlocProvider.of<CreateWishFormBloc>(context);
    return DropdownFieldBlocBuilder<String>(
      selectFieldBloc: formBloc.category,
      decoration: InputDecoration(
          labelText: 'Category',
          prefixIcon: PrefixIcon(iconUrl: "images/form/search.png")),
      itemBuilder: (context, value) => value,
    );
  }
}

class StarField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formBloc = BlocProvider.of<CreateWishFormBloc>(context);
    return DropdownFieldBlocBuilder<String>(
      selectFieldBloc: formBloc.star,
      decoration: InputDecoration(
          labelText: 'Star',
          prefixIcon: PrefixIcon(iconUrl: "images/form/love.png")),
      itemBuilder: (context, value) => value,
    );
  }
}

class SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formBloc = BlocProvider.of<CreateWishFormBloc>(context);
    return OutlineButton.icon(
      icon: Image.asset(
        "images/form/upload.png",
        width: 30,
        height: 30,
      ),
      label: Text(
        'SUBMIT',
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      color: Colors.blue.withOpacity(0.2),
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
