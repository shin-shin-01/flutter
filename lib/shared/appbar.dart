import 'package:flutter/material.dart';
import 'package:my_app/services_locator.dart';
import 'package:my_app/services/authentication.dart';
import 'package:my_app/services/configuration.dart';
import 'package:my_app/services/data.dart';

Widget RootAppBar() {
  final _auth = servicesLocator<AuthService>();
  final _config = servicesLocator<ConfigurationService>();
  final _data = servicesLocator<DataService>();
  final user = _data.Me;

  return AppBar(
      iconTheme: IconThemeData(
        color: _config.appColor["appBarIcon"],
      ),
      flexibleSpace: Image.asset('images/header.png', fit: BoxFit.cover),
      actions: <Widget>[ProfileIconButton(pictureUrl: user.picture_url)],
      backgroundColor: _config.appColor["appBarBackground"],
      elevation: 0.0);
}

class ProfileIconButton extends StatelessWidget {
  final String pictureUrl;
  final _config = servicesLocator<ConfigurationService>();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: CircleAvatar(
        backgroundImage: NetworkImage(pictureUrl),
        backgroundColor: _config.appColor["appBarIconBackground"],
        radius: 16,
      ),
      onPressed: () {},
    );
  }

  ProfileIconButton({this.pictureUrl});
}
