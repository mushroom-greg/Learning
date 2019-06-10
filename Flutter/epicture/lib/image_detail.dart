import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:date_format/date_format.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share/share.dart';
import 'package:path/path.dart' as path;
import 'package:epicture/components/hero_photo_view_wrapper.dart';
import 'package:epicture/imgur_api/imgur_api.dart';

class ImageDetail extends StatefulWidget {
  static String tag = 'image-detail';
  final ImgurImage image;

  ImageDetail({
    this.image
  });

  @override
  State<StatefulWidget> createState() => ImageDetailState();
}

class ImageDetailState extends State<ImageDetail> {
  @override
  Widget build(BuildContext context) {
    var date = DateTime.fromMillisecondsSinceEpoch(widget.image.datetime * 1000);

    return Scaffold(
      appBar: AppBar(
        title: Text("Image : " + widget.image.title.toString())
      ),
      body: Center(
        child: ListView(
          shrinkWrap: false,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(height: 24.0),
            displayImage(),
            SizedBox(height: 12.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: downloadImageButton(),
                ),
                SizedBox(width: 24.0),
                Expanded(
                  child: shareImageButton(),
                ),
              ],
            ),
            SizedBox(height: 12.0),
            Text("Number of views : " + widget.image.views.toString()),
            SizedBox(height: 12.0),
            Text("Posted on " + formatDate(date,
              [DD, ' ', d, ' ', MM, ' ', yyyy, ' at ', HH, ':', mm, ':', ss]
            )),
            SizedBox(height: 24.0),
          ]
        )
      )
    );
  }

  Widget shareImageButton() {
    return RaisedButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.share),
          Text('Share'),
        ],
      ),
      color: Theme.of(context).accentColor,
      elevation: 4.0,
      onPressed: () {
        Share.share(
          widget.image.link
        );
      },
    );
  }

  Widget downloadImageButton() {
    return RaisedButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.file_download),
          Text('Download'),
        ],
      ),
      color: Theme.of(context).accentColor,
      elevation: 4.0,
      onPressed: () {
        saveImageFile();
      },
    );
  }

  Widget displayImage() {
    String extension = path.extension(widget.image.link)
        .replaceAll('.', '')
        .toUpperCase();

    return new GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => HeroPhotoViewWrapper(
            imageProvider: CachedNetworkImageProvider(widget.image.link),
            minScale: PhotoViewComputedScale.contained * 0.4,
            maxScale: PhotoViewComputedScale.covered * 10,
          ),
        ));
      },
      child: Container(
        color: Colors.white,
        child: Hero(
          tag: widget.image.link,
          child: Stack(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: widget.image.link,
                placeholder: Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(),
                    height: 32.0,
                    width: 32.0,
                  )
                ),
                errorWidget: Center(
                  child: SizedBox(
                    child: Icon(Icons.error),
                    height: 32.0,
                    width: 32.0,
                  ),
                ),
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width,
              ),
              Align(
                alignment: FractionalOffset.topRight,
                child: Chip(
                  label: Text(extension),
                  shape: BeveledRectangleBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveImageFile() async {
    String imageAppPath;

    // Get app directory
    if (Platform.isIOS) {
      final appDirectoryPath = await getApplicationDocumentsDirectory();
      imageAppPath = appDirectoryPath.path + '/Epicture';
    } else {
      final externalStoragePath = await getExternalStorageDirectory();
      imageAppPath = externalStoragePath.path + '/Pictures/Epicture';
    }

    // Get image file stored in cache
    var cacheManager = await CacheManager.getInstance();
    File file = await cacheManager.getFile(widget.image.link);

    // Format date
    String date = DateTime.now().toUtc().toIso8601String();

    // Get extension file of image
    String extension = path.extension(widget.image.link);

    // Create new file
    new File('$imageAppPath/$date$extension')
      ..writeAsBytesSync(file.readAsBytesSync());

    // Create toast notification
    Fluttertoast.showToast(
      msg: "File downloaded",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
    );
  }
}
