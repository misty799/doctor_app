import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class UserPicture extends StatefulWidget {
  @override
  _UserPictureState createState() => _UserPictureState();
}

class _UserPictureState extends State<UserPicture> {
  File sampleImg;
  Future<void> getImage() async {
    var tempImg = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImg = tempImg;
    });
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Your picture has been uploaded'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('cancel')),
              FlatButton(
                  onPressed: () {
                    enableUpload();
                    Navigator.of(context).pop();
                  },
                  child: Text('done'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(children: <Widget>[
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white,
          child: ClipOval(
            child: new SizedBox(
              width: 160.0,
              height: 160.0,
              child: (sampleImg != null)
                  ? Image.file(
                      sampleImg,
                      fit: BoxFit.fill,
                    )
                  : Image.network(
                      "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                      fit: BoxFit.fill,
                    ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: IconButton(
            icon: Icon(
              FontAwesomeIcons.camera,
              size: 30.0,
              color: Colors.grey,
            ),
            onPressed: () {
              getImage();
            },
          ),
        )
      ])
    ]);
  }

  Future<void> enableUpload() async {
    final StorageReference ref =
        FirebaseStorage.instance.ref().child('Image.jpg');
    final StorageUploadTask task = ref.putFile(sampleImg);
    final StorageTaskSnapshot snap = await task.onComplete;
    final String url = await snap.ref.getDownloadURL();
    print('URL is $url');
  }
}
