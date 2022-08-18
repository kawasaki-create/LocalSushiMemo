import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:riverpod/riverpod.dart';

class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String userID = '';
  String accountName = '';
  String introduce = '';
  String lastAte = '';
  String lastAteOpen = '';
  int waitSecond = 0;
  late Image _img;

  final Stream<QuerySnapshot<Map<String, dynamic>>> _eventStream = FirebaseFirestore.instance
    .collection('users')
    .snapshots();

  final cuser = FirebaseAuth.instance.currentUser?.uid;

  File? profIcon;
  final picker = ImagePicker();

  Future getImage() async {
    //カメラロールから読み取る
    //final pickedFile = await picker.getImage(source: ImageSource.gallery);
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() async{
      if (pickedFile != null) {
        profIcon = File(pickedFile.path);

      } else {
        print('画像が選択できませんでした。');
      }
    });
  }
  /// ユーザIDの取得
  final userIDs = FirebaseAuth.instance.currentUser?.uid ?? '';

  void uploadPic() async {
    try {
      /// 画像を選択
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      File file = File(image!.path);

      /// Firebase Cloud Storageにアップロード
      String uploadName = 'image';
      final storageRef =
      FirebaseStorage.instance.ref().child('users/$userIDs/$uploadName');
      final task = await storageRef.putFile(file);
    } catch (e) {
      print(e);
    }
  }

  ///ファイルDL
  final imageStateProvider = StateProvider<Uint8List?>((ref) => null);

  /// 画像のダウンロード
   Uint8List? data;
   String nullcheck = 'getUserが取得できてない';

  Future getUser() async{
    await Future.delayed(Duration(seconds: waitSecond));
    //現在のユーザーを取得する
    final cUser = await FirebaseAuth.instance
        .currentUser;
    final uid = cUser?.uid;
    //現在のユーザーのIDで新規情報を設定or更新する
   final cget = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((snapshot){
          if(snapshot.exists){
            userID = snapshot.get('userID');
            accountName = snapshot.get('accountName');
            introduce = snapshot.get('introduce');
            lastAte = snapshot.get('lastAte');
          }
        });

    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef.child("users/$userIDs/image");

    try {
        nullcheck = 'GUは取れてる';
      const oneMegabyte = 10240 * 10240;
       data = await imageRef.getData(oneMegabyte);
      // Data for "images/island.jpg" is returned, use this as needed.
    } on FirebaseException catch (e) {
      // Handle any errors.
      print('NO DATA');
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("プロフィール"),
      ),
      body: FutureBuilder(
          future: getUser(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
              Column(
              children: [
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if(data != null)
                    ClipOval(
                      child:
                      data == null
                          ? Text(nullcheck)
                          : Image.memory(
                          data!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                    ),

                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      child: ElevatedButton(
                        onPressed: () async {
                          showModalBottomSheet(
                            //モーダルの背景の色、透過
                            backgroundColor: Colors.transparent,
                            //ドラッグ可能にする（高さもハーフサイズからフルサイズになる様子）
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                margin: EdgeInsets.only(top: 64),
                                decoration: BoxDecoration(
                                  //モーダル自体の色
                                  color: Colors.white,
                                  //角丸にする
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceEvenly,
                                      children: [
                                        Text('プロフィール画像：'),
                                        ElevatedButton(
                                            onPressed: () async{
                                              uploadPic();
                                            },
                                            child: Text('ライブラリから選択')
                                        ),
                                      ],
                                    ),
                                    Text('\n'),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceEvenly,
                                      children: [
                                        Text('ユーザーID：'),
                                        Expanded(
                                          child: TextFormField(
                                            maxLength: 15,
                                            decoration: InputDecoration(
                                                labelText: '英数字15字以内'),
                                            onChanged: (String value) {
                                              setState(() {
                                                userID = '@' + value;
                                                waitSecond = 1000;
                                              });
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z]'))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceEvenly,
                                      children: [
                                        Text('アカウント名：'),
                                        Expanded(
                                          child: TextFormField(
                                            onChanged: (String value) {
                                              setState(() {
                                                accountName = value;
                                                waitSecond = 1000;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceEvenly,
                                      children: [
                                        Text('自己紹介：'),
                                        Expanded(
                                          child: TextFormField(
                                            keyboardType: TextInputType
                                                .multiline,
                                            maxLines: null,
                                            onChanged: (String value) {
                                              setState(() {
                                                introduce = value;
                                                waitSecond = 1000;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text('\n\n'),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          //現在のユーザーを取得する
                                          final cUser = await FirebaseAuth
                                              .instance
                                              .currentUser;
                                          final uid = cUser?.uid;
                                          //現在のユーザーのIDで新規情報を設定or更新する
                                          await FirebaseFirestore
                                              .instance
                                              .collection('users')
                                              .doc(uid)
                                              .set({
                                            'userID': userID,
                                            'accountName': accountName,
                                            'introduce': introduce
                                          },
                                              SetOptions(merge: true)
                                          );
                                          setState(() {
                                            waitSecond = 1;
                                          });
                                          getUser();
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('更新'),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.pinkAccent
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Text('編集'),
                      ),
                    ),
                  ),
                ],
              ),
              Text(userID),
              Text(accountName),
              Text(introduce),
              Text('\n\n'),
             SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async{
                    setState(() {
                      if(lastAte != null){
                        setState(() {
                          lastAteOpen = lastAte;
                        });
                      }
                    });
                  },
                  child: Text('今までに食べたものリスト'),
                ),
              ),
                  Center(
                    child: Text(lastAteOpen),
                  ),
                ],
            )]
              )
                      );
  },
            ),
    );
  }
}