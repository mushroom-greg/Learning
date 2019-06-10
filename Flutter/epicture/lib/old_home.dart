import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:epicture/components/fab_bottom_app_bar.dart';
import 'package:epicture/components/fab_with_icons.dart';
import 'package:epicture/components/anchored_overlay.dart';
import 'package:epicture/upload_info.dart';
import 'package:epicture/profile.dart';

class Home extends StatefulWidget {
  static String tag = 'home';

  Home({Key key}) : super(key: key);

  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  String _lastSelected = 'TAB: 0';

  imageSelectorGallery() async {
    File file = await ImagePicker.pickImage(
      source: ImageSource.gallery
    );

    setState(() {});

    if (file != null) {
      Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) => new UploadInfo(file: file)
      ));
    }
  }

  // Display image selected from camera
  imageSelectorCamera() async {
    File file = await ImagePicker.pickImage(
      source: ImageSource.camera
    );

    setState(() {});

    if (file != null) {
      Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) => new UploadInfo(file: file)
      ));
    }
  }

  void _selectedTab(int index) {
    setState(() {
      _lastSelected = 'TAB: $index';
    });
  }

  void _selectedFab(int index) {
    if (index == 0) {
      imageSelectorCamera();
    } else {
      imageSelectorGallery();
    }

    setState(() {
      _lastSelected = 'FAB: $index';
    });
  }

  @override
  Widget build(BuildContext context) {
    final hero = Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircleAvatar(
            radius: 18.0,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/brandon-welsch.png')
        ),
      ),
    );

    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Hey Brandon',
        style: TextStyle(fontSize: 20.0, color: Colors.white)
      ),
    );

    final test = Center(
      child: Text(
        _lastSelected,
        style: TextStyle(fontSize: 32.0),
      ),
    );

    final body = Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(28.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.blue,
              Colors.lightBlueAccent
            ])
        ),
        child: Column(
          children: <Widget>[hero, welcome, test],
        )
    );

    return Scaffold(
      bottomNavigationBar: FABBottomAppBar(
        centerItemText: 'Upload',
        color: Colors.grey,
        selectedColor: Colors.blue,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: _selectedTab,
        items: [
          FABBottomAppBarItem(
            iconData: Icons.home,
            text: 'Home',
            onPressed: () {
              Navigator.of(context).pushNamed(Home.tag);
            }
          ),
          FABBottomAppBarItem(iconData: Icons.search, text: 'Search'),
          FABBottomAppBarItem(iconData: Icons.dashboard, text: 'Bottom'),
          FABBottomAppBarItem(
            iconData: Icons.account_circle,
            text: 'Profile',
            onPressed: () {
              Navigator.of(context).pushNamed(Profile.tag);
            }
          ),
        ]
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFab(context),
      body: body,
    );
  }

  Widget _buildFab(BuildContext context) {
    final icons = [ Icons.camera, Icons.photo_album  ];

    return AnchoredOverlay(
      showOverlay: true,
      overlayBuilder: (context, offset) {
        return CenterAbout(
          position: Offset(offset.dx, offset.dy - icons.length * 35.0),
          child: FabWithIcons(
            icons: icons,
            onIconTapped: _selectedFab,
          ),
        );
      },
      child: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Upload image',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
    );
  }
}
