import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_app/services_locator.dart';
import 'package:my_app/services/configuration.dart';

// Loading 画面
class Loading extends StatelessWidget {
  final _config = servicesLocator<ConfigurationService>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: _config.appColor["loadingBackground"],
      child: Center(
        child:
            SpinKitCubeGrid(color: _config.appColor["loadingIcon"], size: 50),
      ),
    );
  }
}
