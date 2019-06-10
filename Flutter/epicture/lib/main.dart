import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:epicture/login.dart';
import 'package:epicture/logged_main.dart';
import 'package:epicture/search.dart';
import 'package:epicture/profile.dart';

void main() => runApp(new MaterialApp(
  title: 'Epicture',
  theme: new ThemeData(
    primarySwatch: Colors.blue
  ),
  debugShowCheckedModeBanner: false,
  home: new Epicture(),
  routes: <String, WidgetBuilder> {
    Login.tag: (context) => Login(),
    LoggedMain.tag: (context) => LoggedMain(),
    Search.tag: (context) => Search(),
    Profile.tag: (context) => Profile()
  }
));

class Epicture extends StatefulWidget {
  @override
  _EpictureState createState() => new _EpictureState();
}

class _EpictureState extends State<Epicture> {
  void createAppDirectory(String path) {
    print('Path of app image storage : ' + path);

    // Create directory for app
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      new Directory(path).create().then((dir) {
        print('Directory created');
        print(dir.path);
      }).catchError((onError) {
        print('Directory not created');
        print(onError.toString());
      });
    }
  }

  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    // Set up cache manager
    CacheManager.inBetweenCleans = new Duration(days: 7);
    CacheManager.maxAgeCacheObject = new Duration(days: 30);
    CacheManager.maxNrOfCacheObjects = 1000;

    // For iOS, save on another path
    if (Platform.isIOS) {
      final appDirectoryPath = getApplicationDocumentsDirectory();

      appDirectoryPath.then((appDirectory) {
        final path = appDirectory.path + '/Epicture';

        createAppDirectory(path);
      });
    } else {
      final externalStoragePath = getExternalStorageDirectory();

      externalStoragePath.then((externalStorage) {
        final path = externalStorage.path + '/Pictures/Epicture';

        createAppDirectory(path);
      });
    }

    return new Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            child: Image.asset(
              'assets/bg.png',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 3.0,
              sigmaY: 3.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.0)
              ),
            ),
          ),
          SplashScreen(
            seconds: 4,
            navigateAfterSeconds: new Login(),
            title: Text(
              'Epicture',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                color: Colors.white,
              ),
            ),
            image: Image.asset('assets/logo.png'),
            backgroundColor: Colors.transparent,
            styleTextUnderTheLoader: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.white,
            ),
            photoSize: 100.0,
            loaderColor: Colors.blueAccent,
          ),
        ],
      )
    );
  }
}
