import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sushi_memo_sns/guestroulette.dart';
import 'VersionCheckService.dart';
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Noto Sans JP", // ここを追加
      ),
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        appBar: AppBar(
          title: Text('🍣すしめも！🍣'),
        ),
        body: bodyContents(),
      ),
    );
  }
}

class bodyContents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('🍣おすすめ🍣'),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 6),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              children: [
                Text('ログインして使う',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                ElevatedButton(
                  child: Text('ログインページへ移動'),
                  onPressed: (){
                    Updater(playStoreUrl: 'https://rinpos.com', appStoreUrl: 'https://kawasaki-create.com',);
                    Navigator.push(context,MaterialPageRoute(
                        builder:(context) => LoginPage()
                    ));
                  },
                ),
              ],
            ),
          ),
          Text('\n\n'),
          Text('ログインせずに使う'),
          SizedBox(
            child: ElevatedButton(
              child: Text('ゲストユーザ版へ移動'),
              onPressed: (){
                Updater(playStoreUrl: 'https://play.google.com/store/apps/details?id=com.sushi_memo_sns&hl=en-US&ah=uHAni3GfAGZjRZa7H6-3_zMAfPw', appStoreUrl: 'https://kawasaki-create.com',);
                Navigator.push(context,MaterialPageRoute(
                    builder:(context) => Guestroulette()
                ));
              },
            ),
          ),
          Text('\n\n'),
          Text('※登録すると結果を記録できます')
        ],
      ),

    );
  }
}
