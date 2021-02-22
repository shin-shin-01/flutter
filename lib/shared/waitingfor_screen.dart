import 'package:flutter/material.dart';

class WaitingforScreen extends StatelessWidget {
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
            style:
                TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ));
  }
}
