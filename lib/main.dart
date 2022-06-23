import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'root.dart';


void main() async {
  // 初期化処理を追加
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(SushiMemo());
}

class SushiMemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        appBar: AppBar(),
        body: bodyContents(),
      ),
    );
  }
}

class bodyContents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text('ログインページへ移動'),
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(
              builder:(context) => LoginPage()
          ));
        },
      ),
    );
  }
}
