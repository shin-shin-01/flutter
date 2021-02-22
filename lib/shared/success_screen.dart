import 'package:flutter/material.dart';
import 'package:my_app/services_locator.dart';
import 'package:my_app/services/navigation.dart';

/// TODO: リファクタリング
class SuccessScreen extends StatelessWidget {
  final _navigation = servicesLocator<NavigationService>();
  SuccessScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// TODO: 値を直接指定しすぎ
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "images/success.png",
            width: 100,
            height: 100,
          ),
          SizedBox(height: 10),
          Text(
            '追加しました!',
            style:
                TextStyle(fontSize: 40, color: Theme.of(context).primaryColor),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          FloatingActionButton.extended(
            icon: Image.asset(
              "images/cart.png",
              width: 30,
              height: 30,
            ),
            label: Text(
              'Check!',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            backgroundColor: Colors.white,
            onPressed: () => _navigation.pushAndReplace(routeName: '/root'),
          ),
        ],
      ),
    ));
  }
}