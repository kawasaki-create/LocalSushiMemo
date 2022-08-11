import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  File? profIcon;
  final picker = ImagePicker();

  Future getImage() async {
    //カメラロールから読み取る
    //final pickedFile = await picker.getImage(source: ImageSource.gallery);
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        profIcon = File(pickedFile.path);
      } else {
        print('画像が選択できませんでした。');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("プロフィール"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipOval(
                  child:
                  profIcon == null
                      ? const Text('')
                      : Image.file(
                    profIcon!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                   child: Container(
                      child: ElevatedButton(
                        onPressed: (){
                            showModalBottomSheet(
                              //モーダルの背景の色、透過
                              backgroundColor: Colors.transparent,
                              //ドラッグ可能にする（高さもハーフサイズからフルサイズになる様子）
                              isScrollControlled: true,
                              context: context,
                              builder: (BuildContext context){
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
                              //    child: Text('oo'),
                                );
                              },
                          );
                        },
                        child: Text('画像を選択する'),
                      ),
                    ),
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}
