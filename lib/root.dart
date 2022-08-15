import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sushi_memo_sns/routes/rank_route.dart';
import 'package:sushi_memo_sns/routes/home_route.dart';
import 'package:sushi_memo_sns/routes/notice_route.dart';
import 'package:sushi_memo_sns/routes/roulette_route.dart';
import 'package:sushi_memo_sns/post_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RootWidget extends StatefulWidget {
  // 引数からユーザー情報を受け取る
  RootWidget(this.user);
  // ユーザー情報
  final User user;

  @override
  _RootWidget createState() => _RootWidget(user);
}

class _RootWidget extends State<RootWidget> {
  int _selectedIndex = 0;
  final _bottomNavigationBarItems = <BottomNavigationBarItem>[];

  // 引数からユーザー情報を受け取る
  _RootWidget(this.user);
  // ユーザー情報
   final  User user;

  //アイコン情報
  static const _RootWidgetIcons = [
    FontAwesomeIcons.dove,
    FontAwesomeIcons.user,
    FontAwesomeIcons.database,
    FontAwesomeIcons.rankingStar,
  ];
    //アイコン文字列
  static const _RootWidgetItemNames = [
    'つぶやき',
    'プロフィール',
    'すしめも！',
    'ランキング',
  ];

  var _routes = [
    Home(),
    Profile(),
    Roulette(),
    Ranking(),
  ];
  @override
  void initState() {
    super.initState();
    _bottomNavigationBarItems.add(_UpdateActiveState(0));
    for (var i = 1; i < _RootWidgetItemNames.length; i++) {
      _bottomNavigationBarItems.add(_UpdateDeactiveState(i));
    }
  }
  /// インデックスのアイテムをアクティベートする
  BottomNavigationBarItem _UpdateActiveState(int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          _RootWidgetIcons[index],
          color: Colors.black87,
        ),
        label:
          _RootWidgetItemNames[index],
    );
  }

  /// インデックスのアイテムをディアクティベートする
  BottomNavigationBarItem _UpdateDeactiveState(int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          _RootWidgetIcons[index],
          color: Colors.black26,
        ),
        label:
          _RootWidgetItemNames[index],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _bottomNavigationBarItems[_selectedIndex] = _UpdateDeactiveState(_selectedIndex);
      _bottomNavigationBarItems[index] = _UpdateActiveState(index);
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _routes.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // これを書かないと3つまでしか表示されない
        items: _bottomNavigationBarItems,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          // 投稿画面に遷移
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return AddPostPage(user);
            }),
          );
        },
      ),
    );
  }
}