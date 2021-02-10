import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:my_app/ui/sign_in/sign_in_viewmodel.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
      builder: (context, model, child) =>
          Scaffold(body: Center(child: _loginButton(model))),
      viewModelBuilder: () => SignInViewModel(),
    );
  }

  Widget _loginButton(SignInViewModel model) {
    return RaisedButton(
      child: const Text('Login'),
      color: Theme.of(context).primaryColor,
      onPressed: model.submitSignInFake,
    );
  }
}