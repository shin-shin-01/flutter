import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:my_app/shared/loading.dart';
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
      builder: (context, model, child) => Stack(
        children: <Widget>[
          new Container(
            height: screenSize.height,
            width: screenSize.width,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("images/main.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: model.isBusy
                ? Loading()
                : Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        SizedBox(height: screenSize.height * 0.5),
                        _loginButton(model, screenSize.width * 0.45)
                      ])),
          ),
        ],
      ),
      viewModelBuilder: () => SignInViewModel(),
    );
  }

  Widget _loginButton(SignInViewModel model, double width) {
    return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: width,
        ),
        child: GestureDetector(
          child: Image.asset(
            "images/login/btn_login_base.png",
          ),
          onTap: model.login,
        ));
  }
}
