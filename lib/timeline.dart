import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'post_page.dart';
import 'root.dart';

// チャット画面用Widget
class Timeline extends StatelessWidget {
  //引数からユーザ情報を受け取れるようにする
  Timeline(this.user);
  //ユーザ情報
  final User user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ホーム画面'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () async {
              //ログアウト処理
              //内部で保持しているログイン情報などが初期化される
              await FirebaseAuth.instance.signOut();
              // ログイン画面に遷移＋チャット画面を破棄
              await Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }),
              );
            },
          ),
        ],
      ),
      body: Center(
        //ユーザ情報を表示
          child: Text('ログイン情報:${user.email}')
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
      bottomNavigationBar: RootWidget(user),
    );
  }
}