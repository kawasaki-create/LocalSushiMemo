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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child:
                  profIcon == null
                    ? const Text('senntakuNot')
                     : Image.file(
                        profIcon!,
                        width: 200,
                        height: 200,
                        fit: BoxFit.fill,
                      ),
            ),
            Container(
              child: TextButton(
                onPressed: getImage,
                child: Text('画像を選択する'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
