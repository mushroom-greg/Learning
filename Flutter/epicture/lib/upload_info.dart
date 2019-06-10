import 'dart:io';
import 'package:flutter/material.dart';

class UploadInfo extends StatefulWidget {
  static String tag = 'upload';
  final File file;

  UploadInfo({
    this.file
  });

  @override
  State<StatefulWidget> createState() => UploadInfoState();
}

class UploadInfoState extends State<UploadInfo> {
  @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      initialValue: '',
      decoration: InputDecoration(
        hintText: 'Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0)
        )
      ),
    );

    final descField = TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      autofocus: false,
      initialValue: '',
      decoration: InputDecoration(
        hintText: 'Description',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0)
        )
      ),
    );

    final uploadButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          color: Colors.lightBlueAccent,
          onPressed: () {},
          child: Text(
            'Upload image',
            style: TextStyle(color: Colors.white)
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Upload image")
      ),
      body: Center(
        child: ListView(
          shrinkWrap: false,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(height: 24.0),
            displayImageFile(),
            SizedBox(height: 24.0),
            nameField,
            SizedBox(height: 12.0),
            descField,
            uploadButton
          ]
        )
      )
    );
  }

  Widget displayImageFile() {
    return new Container(
      child: new Image.file(
        widget.file,
        height: 350.0,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
