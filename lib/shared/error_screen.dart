import 'package:flutter/material.dart';
import 'package:my_app/services_locator.dart';
import 'package:my_app/services/configuration.dart';
import 'package:my_app/services/navigation.dart';

class ErrorScreen extends StatelessWidget {
  final _config = servicesLocator<ConfigurationService>();
  final _navigation = servicesLocator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _config.appColor["waitingBackground"],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "images/error.png",
                width: 100,
                height: 100,
              ),
              SizedBox(height: 10),
              Text(
                'エラーが発生しました。現在改善中です。',
                style: TextStyle(fontSize: 20, color: _config.appColor["text"]),
                textAlign: TextAlign.center,
              ),
              FlatButton.icon(
                icon: Icon(Icons.home),
                label: Text(
                  'HOMEに戻る',
                  style: TextStyle(color: _config.appColor["text"]),
                ),
                color: _config.appColor["createWishSubmitBackground"],
                onPressed: () =>
                    _navigation.pushNamedAndRemoveUntil(routeName: '/root'),
              )
            ],
          ),
        ));
  }
}
