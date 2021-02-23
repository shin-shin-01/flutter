import 'package:flutter/material.dart';
import 'package:my_app/services_locator.dart';
import 'package:my_app/services/authentication.dart';

Widget RootAppBar() {
  final _auth = servicesLocator<AuthService>();

  return AppBar(
      flexibleSpace: Image.asset('images/header.png', fit: BoxFit.cover),
      actions: <Widget>[ProfileIconButton(picturUrl: _auth.picturUrl)],
      backgroundColor: Colors.white.withOpacity(0.0),
      elevation: 0.0);
}

class ProfileIconButton extends StatelessWidget {
  final String picturUrl;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: CircleAvatar(
        backgroundImage: NetworkImage(picturUrl),
        backgroundColor: Colors.transparent,
        radius: 16,
      ),
      onPressed: () {},
    );
  }

  ProfileIconButton({this.picturUrl});
}
