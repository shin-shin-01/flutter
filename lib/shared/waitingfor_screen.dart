import 'package:flutter/material.dart';
import 'package:my_app/services_locator.dart';
import 'package:my_app/services/configuration.dart';

class WaitingforScreen extends StatelessWidget {
  final _config = servicesLocator<ConfigurationService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "images/present.png",
            width: 100,
            height: 100,
          ),
          SizedBox(height: 10),
          Text(
            'Waiting for implementation...',
            style: TextStyle(fontSize: 20, color: _config.appColor["text"]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ));
  }
}
