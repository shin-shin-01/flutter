import 'package:flutter/material.dart';
import 'package:my_app/services_locator.dart';
import 'package:my_app/services/configuration.dart';
import 'package:my_app/services/navigation.dart';
import 'package:my_app/services/api.dart';
import 'package:my_app/services/data.dart';
import 'package:my_app/model/friend.dart';

/// SideMenu
class SideMenu extends StatelessWidget {
  final _config = servicesLocator<ConfigurationService>();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Drawer(
        child: ListView(
      children: <Widget>[
        Container(
          child: DrawerHeader(
            decoration:
                BoxDecoration(color: _config.appColor["sideMenuHeader"]),
          ),
          height: screenSize.height * 0.05,
        ),

        // sideMenuの要素
        ..._menuItems(context)
      ],
    ));
  }
}

/// sideMenu の要素　(Header 以外)
List<Widget> _menuItems(BuildContext context) {
  return [
    _accountIdTile(),
    _friendTile(context),
    _logoutTile(context),
    _settingTile(context)
  ];
}

/// アカウントID
Widget _accountIdTile() {
  final _data = servicesLocator<DataService>();
  final user = _data.Me;

  return ListTile(
      title: Text(user.account_id),
      leading: Padding(
        child: CircleAvatar(
          backgroundImage: NetworkImage(user.picture_url),
          radius: 16,
        ),
        padding: EdgeInsets.all(8.0),
      ));
}

/// ログアウト
Widget _logoutTile(context) {
  return ListTile(
    title: Text('ログアウト'),
    leading: Padding(
      child: Image.asset("images/sidemenu/logout.png"),
      padding: EdgeInsets.all(8.0),
    ),
    onTap: () => logoutDialog(context),
  );
}

Future logoutDialog(context) {
  final _navigation = servicesLocator<NavigationService>();
  return showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        content: Text('ログアウトしますか？'),
        actions: <Widget>[
          FlatButton(
            child: Text("CANCEL"),
            onPressed: () {
              _navigation.pop();
            },
          ),
          FlatButton(
            child: Text("OK"),
            onPressed: () =>
                _navigation.pushNamedAndRemoveUntil(routeName: '/sign_in'),
          ),
        ],
      );
    },
  );
}

/// 設定
Widget _settingTile(context) {
  return ListTile(
    title: Text('設定'),
    leading: Padding(
      child: Image.asset("images/sidemenu/setting.png"),
      padding: EdgeInsets.all(8.0),
    ),
    // onTap: () => logoutDialog(context),
  );
}

/// 友達
Widget _friendTile(context) {
  return ListTile(
    title: Text('フレンド'),
    leading: Padding(
      child: Image.asset("images/tabmenu/friend.png"),
      padding: EdgeInsets.all(8.0),
    ),
    onTap: () => friendSearchDialog(context),
  );
}

Future friendSearchDialog(context) {
  final _api = servicesLocator<APIService>();
  final _navigation = servicesLocator<NavigationService>();
  final _form = GlobalKey<FormState>();
  String _account_id = '';
  Friend friend;

  Future _submission() async {
    friend = await _api.showUser(_account_id);
    print(friend.name);
  }

  return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
            scrollable: true,
            title: Text('友達追加'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _form,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Account ID',
                          icon: Icon(Icons.account_box),
                        ),
                        onSaved: (value) {
                          _account_id = value;
                        }),
                  ],
                ),
              ),
            ),
            actions: [
              RaisedButton(
                child: Text("検索"),
                onPressed: () async {
                  _form.currentState.save();
                  // _navigation.pop();
                  await _submission();
                  addFriendDialog(context, friend);
                },
              )
            ]);
      });
}

Future addFriendDialog(context, Friend friend) {
  final _api = servicesLocator<APIService>();
  final _navigation = servicesLocator<NavigationService>();

  return showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Text('友達になりますか？'),
        content: ListTile(
          title: Text(friend.name),
          leading: Padding(
            child: CircleAvatar(
              backgroundImage: NetworkImage(friend.picture_url),
              radius: 16,
            ),
            padding: EdgeInsets.all(8.0),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("NO"),
            onPressed: () {
              _navigation.pop();
            },
          ),
          FlatButton(
              child: Text("YES"),
              onPressed: () => {
                    _api.createFriend(friend),
                    _navigation.pushNamedAndRemoveUntil(routeName: '/root'),
                  }),
        ],
      );
    },
  );
}
