import 'dart:async';
import 'dart:ffi';

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

  final  Stream<QuerySnapshot<Map<String, dynamic>>> snapshotStream =
    FirebaseFirestore.instance
      .collection('posts')
      .orderBy('date', descending: true)
      .snapshots();


  List<DocumentSnapshot> docList = []; //dbのドキュメントを入れるリストを用意する

  //ホームシュってやって更新するロジック
 Future<List>_loadData() async {
   final streams = await FirebaseFirestore.instance
      .collection('users')
      .orderBy('date', descending: true)
      .get();

    return  docList = streams.docs;
  }

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
    // _loadData();
    return Scaffold(
      appBar: AppBar(
        title: Text('つぶやき'),
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
      body: StreamBuilder(
        stream: snapshotStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // ドキュメント情報を表示
                    Column(
                      children: snapshot.data!.docs.map<Widget>((DocumentSnapshot document) {
                        //Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                        return Card(
                          child: Column(
                            children: <Widget>[
                              if(document['currentUser'] == FirebaseAuth.instance.currentUser?.uid)
                              Container(
                                margin: const EdgeInsets.all(10.0),
                                width: 300,
                                child: Text('${document['text']}'),
                              ),
                              if(document['currentUser'] == FirebaseAuth.instance.currentUser?.uid)
                             Container(
                               child: Text(document['date'].substring(0,19).replaceFirst('T',' '),
                                      style: TextStyle(
                                        fontSize: 10
                                        ),
                                      ),
                             ),
                             /* Row(
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

                              */
                              if(document['currentUser'] == FirebaseAuth.instance.currentUser?.uid)
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
          );
        },
      ),
    );
  }
}