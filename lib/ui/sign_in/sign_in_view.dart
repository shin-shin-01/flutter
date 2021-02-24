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
    final screenSize = MediaQuery.of(context).size;
    return ViewModelBuilder<SignInViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
            _image(),
            SizedBox(height: screenSize.height * 0.2),
            _loginButton(model)
          ]))),
      viewModelBuilder: () => SignInViewModel(),
    );
  }

  Widget _image() {
    return Image.asset(
      /// TODO: change
      "images/success.png",
      width: 100,
      height: 100,
    );
  }

  Widget _loginButton(SignInViewModel model) {
    return GestureDetector(
      child: Image.asset(
        "images/login/btn_login_base.png",
      ),
      onTap: model.login,
    );
  }
}
