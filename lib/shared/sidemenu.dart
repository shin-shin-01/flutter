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
    _addFriendTile(context),
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
Widget _addFriendTile(context) {
  return ListTile(
    title: Text('フレンド'),
    leading: Padding(
      child: Image.asset("images/tabmenu/friend.png"),
      padding: EdgeInsets.all(8.0),
    ),
    onTap: () => friendDialog(context),
  );
}

/// 友人メインダイアログ
Future friendDialog(context) {
  final _api = servicesLocator<APIService>();
  final _data = servicesLocator<DataService>();
  final _form = GlobalKey<FormState>();

  String _account_id = '';
  Friend friend;
  final friends = _data.getMyFriends;

  Future _submission() async {
    friend = await _api.showUser(_account_id);
    print(friend.name);
  }

  return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
            scrollable: true,
            title: Text('友達一覧'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _form,
                child: Column(
                  children: <Widget>[
                    friendListContainer(context, friends),
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
                  await _submission();
                  addFriendDialog(context, friend);
                },
              )
            ]);
      });
}

/// 友人一覧コンテナ
Widget friendListContainer(context, friends) {
  return Container(
      height: 300,
      width: 200,
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          // padding: EdgeInsets.all(8),
          itemCount: friends.length,
          itemBuilder: (context, i) => _friendTile(context, friends[i])));
}

/// 友人表示タイル
Widget _friendTile(context, Friend friend) {
  final _config = servicesLocator<ConfigurationService>();

  return Card(
    child: ListTile(
      /// TODO : fix-this
      tileColor: _config.appColor["wishTileBackground"],
      leading: Padding(
        child: CircleAvatar(
          backgroundImage: NetworkImage(friend.picture_url),
          radius: 16,
        ),
        padding: EdgeInsets.all(1.0),
      ),
      title: Text(friend.name,
          style: TextStyle(color: _config.appColor["wishTileFont"])),
    ),
  );
}

/// 友人追加確認 api実行
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
