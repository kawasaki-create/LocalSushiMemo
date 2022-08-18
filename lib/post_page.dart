import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sushi_memo_sns/routes/home_route.dart';

// 投稿画面用Widget
class AddPostPage extends StatefulWidget {
  // 引数からユーザー情報を受け取る
  AddPostPage(this.user);
  // ユーザー情報
  final User user;

  @override
  _AddPostPageState createState() => _AddPostPageState();
}


class _AddPostPageState extends State<AddPostPage>{
  // 入力した投稿メッセージ
  String messageText = '';
  get counter => Home();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('つぶやき'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // 投稿メッセージ入力
              TextFormField(
                decoration: InputDecoration(labelText: '投稿メッセージ'),
                // 複数行のテキスト入力
                keyboardType: TextInputType.multiline,
                maxLines: null,
                // 最大140字
                maxLength: 140,
                onChanged: (String value) {
                  setState(() {
                    messageText = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('投稿'),
                  onPressed: () async {
                    final date =
                    DateTime.now().toLocal().toIso8601String(); // 現在の日時
                    final email = widget.user.email; // AddPostPage のデータを参照
                    // 投稿メッセージ用ドキュメント作成
                    if(messageText != "") {
                      await FirebaseFirestore.instance
                          .collection('posts') // コレクションID指定
                          .doc() // ドキュメントID自動生成
                          .set({
                        'text': messageText,
                        'email': email,
                        'date': date,
                        'isLike': Home().counter,
                        'currentUser': widget.user.uid,
                      });
                    }
                    // 1つ前の画面に戻る
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class checkTxt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("入力エラー"),
      content: Text("入力してください"),
      actions: [
        ElevatedButton(onPressed: ()=>Navigator.pop(context), child: Text("OK"))
      ]
    );
  }
}

