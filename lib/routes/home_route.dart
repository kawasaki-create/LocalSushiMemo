import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sushi_memo_sns/root.dart';
import '../login_page.dart';
import 'package:sushi_memo_sns/post_page.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  get user => RootWidget(user);
  get messageText => AddPostPage(messageText);

  get counter => _Home()._counter;

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  List<DocumentSnapshot> docList = []; //dbのドキュメントを入れるリストを用意する

  final  Stream<QuerySnapshot<Map<String, dynamic>>> snapshotStream =
    FirebaseFirestore.instance
      .collection('posts')
      .orderBy('date', descending: true)
      .snapshots();

  //ホームシュってやって更新するロジック
 /* Future _loadData() async {

    await Future.delayed(Duration(seconds: 2));

    print("loaded new data");

    setState(() {
      docList = snapshot as List<DocumentSnapshot<Object>>;
    });
  }

  */

  //アイコンボタン変更用
  int _counter = 0;
  bool iconchange = false;

   void _incrementCounter() {
      if (_counter%2 == 0) {
        iconchange = true;
        setState(() {
          _counter++;
        });
      } else if (_counter%2 == 1) {
        iconchange = false;
        setState(() {
          _counter--;
        });
      }
    }



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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
          ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
          ),
          child: Text('更新'),
          onPressed: () async {
            // 指定コレクションのドキュメント一覧を取得
            final snapshot = await FirebaseFirestore.instance
                .collection('posts')
                .orderBy("date",descending: true)
                .get();
            // ドキュメント一覧を配列で格納
            setState(() {
              docList = snapshot.docs;
            });
          },
        ),
        // ドキュメント情報を表示
        Column(
          children: docList.map((document) {
            return Card(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    width: 300,
                    child: Text('${document['text']}\n' +  '${document['date'].substring(0,19).replaceFirst('T',' ')}'),
                  ),
                          Row(
                            children: <Widget>[
                              if(iconchange == false)
                                IconButton(
                                    onPressed: () async {
                                      _incrementCounter();
                                      await FirebaseFirestore.instance
                                          .collection('posts')
                                          .doc(document.id)
                                          .update({'isLike': _counter});
                                    },
                                    icon: Icon(Icons.favorite_border_outlined)
                                ),
                              if(iconchange == true)
                                IconButton(
                                    onPressed: () async {
                                      _incrementCounter();
                                      await FirebaseFirestore.instance
                                          .collection('posts')
                                          .doc(document.id)
                                          .update({'isLike': _counter});
                                    },
                                    icon: Icon(
                                      Icons.favorite, color: Colors.pink,)
                                ),
                              Text('${document['isLike']}'),
                            ],
                          ),

                          ElevatedButton(
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection('posts')
                                  .doc(document.id)
                                  .delete();
                            },
                            child: Text('Delete'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ]),
    ),
              // ドキュメント情報を表示
      ));
  }
}