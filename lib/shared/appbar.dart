import 'package:flutter/material.dart';
import 'package:my_app/services_locator.dart';
import 'package:my_app/services/authentication.dart';
import 'package:my_app/services/configuration.dart';

Widget RootAppBar() {
  final _auth = servicesLocator<AuthService>();
  final _config = servicesLocator<ConfigurationService>();

  return AppBar(
      // flexibleSpace: Image.asset('images/header.png', fit: BoxFit.cover),
      actions: <Widget>[ProfileIconButton(picturUrl: _auth.picturUrl)],
      backgroundColor: _config.appColor["appBarBackground"],
      elevation: 0.0);
}

class ProfileIconButton extends StatelessWidget {
  final String picturUrl;
  final _config = servicesLocator<ConfigurationService>();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: CircleAvatar(
        backgroundImage: NetworkImage(picturUrl),
        backgroundColor: _config.appColor["appBarIconBackground"],
        radius: 16,
      ),
      onPressed: () {},
    );
  }

  ProfileIconButton({this.picturUrl});
}
