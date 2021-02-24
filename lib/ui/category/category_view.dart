import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:my_app/model/wish.dart';
import 'package:my_app/ui/category/category_viewmodel.dart';
import 'package:my_app/shared/loading.dart';
import 'package:my_app/services_locator.dart';
import 'package:my_app/services/navigation.dart';
import 'package:my_app/services/configuration.dart';

class CategoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return ViewModelBuilder<CategoryViewModel>.reactive(
        viewModelBuilder: () => CategoryViewModel(),
        onModelReady: (model) => model.initialize(),
        builder: (context, model, child) => Scaffold(
            body: model.isBusy
                ? Loading()
                : _categoryView(context, model, screenSize)));
  }

  Widget _categoryView(context, CategoryViewModel model, Size screenSize) {
    final _config = servicesLocator<ConfigurationService>();
    final category_tabs = model.category_tabs;
    return DefaultTabController(
        length: category_tabs.length,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: _config.appColor["categoryAppBarBackground"],
              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(20),
                  child: TabBar(
                    indicatorColor:
                        _config.appColor["categoryAppBarTabIndicator"],
                    labelColor: _config.appColor["categoryAppBarTabLabel"],
                    unselectedLabelColor:
                        _config.appColor["categoryAppBarTabUnselectedLabel"],
                    labelStyle: TextStyle(fontSize: 12),
                    isScrollable: true,
                    tabs: category_tabs,
                  ))),
          body: TabBarView(
              children: category_tabs
                  .map((tab) => _wishList(context, model, tab.text))
                  .toList()),
          backgroundColor: _config.appColor["categoryBodyBackground"],
        ));
  }

  Widget _wishList(context, CategoryViewModel model, String category_name) {
    final wishes = model.wishes[category_name];

    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(8),
        itemCount: wishes.length,
        itemBuilder: (context, i) => _wishTile(context, model, wishes[i]));
  }

  Widget _wishTile(context, CategoryViewModel model, Wish wish) {
    /// TODO: 適当に決めたので修正
    final double topDownPaddingSize = 20.0 - wish.star * 2.0;
    final double leftPaddingSize = 1.1 * (5.0 - wish.star);
    final _config = servicesLocator<ConfigurationService>();

    return Card(
      child: ListTile(
        tileColor: _config.appColor["wishTileBackground"],
        leading: Padding(
          padding: EdgeInsets.only(
              left: leftPaddingSize,
              top: topDownPaddingSize,
              bottom: topDownPaddingSize),
          child: Image.asset("images/heart.png"),
        ),
        title: Text(wish.name,
            style: TextStyle(color: _config.appColor["wishTileFont"])),

        /// 削除ボタン
        trailing: IconButton(
            icon: Image.asset(
              "images/delete.png",
              width: 25,
              height: 25,
            ),
            onPressed: () {
              showDeleteDialog(context, model, wish);
            }),

        /// タップ時の動作
        onTap: () {
          {
            showWishDetailDialog(context, wish);
          }
          ;
        },
      ),
    );
  }
}

Future showDeleteDialog(context, CategoryViewModel model, Wish wish) {
  final _navigator = servicesLocator<NavigationService>();
  return showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Text(wish.name),
        content: Text('本当に削除しますか？'),
        actions: <Widget>[
          FlatButton(
            child: Text("CANCEL"),
            onPressed: () {
              _navigator.pop();
            },
          ),
          FlatButton(
            child: Text("OK"),
            onPressed: () => {model.deleteWishes(wish)},
          ),
        ],
      );
    },
  );
}

Future showWishDetailDialog(context, Wish wish) {
  final _navigator = servicesLocator<NavigationService>();
  final _config = servicesLocator<ConfigurationService>();

  return showDialog(
    context: context,
    builder: (context) {
      return Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AlertDialog(
            title: Text(wish.name),
            backgroundColor: _config.appColor["dialogBackground"],
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  _detailTile(wish.userName, Icon(Icons.person)),
                  _detailTile(wish.categoryName, Icon(Icons.search)),
                  _detailTile(wish.star.toString(), Icon(Icons.favorite)),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("戻る"),
                onPressed: () {
                  _navigator.pop();
                },
              )
            ],
          ),
        ],
      ));
    },
  );
}

Widget _detailTile(
  text,
  icon,
) {
  final _config = servicesLocator<ConfigurationService>();
  return Container(
      decoration: new BoxDecoration(
          border: new Border(
              bottom: BorderSide(
                  width: 1.0, color: _config.appColor["dialogBorder"]))),
      child: ListTile(
          leading: icon,
          title: Text(
            text,
            style: TextStyle(color: _config.appColor["text"], fontSize: 15.0),
          )));
}
