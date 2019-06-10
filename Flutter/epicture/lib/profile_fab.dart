import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:epicture/upload_info.dart';

class ProfileFab extends StatefulWidget {
  final Function() onPressed;
  final String tooltip;
  final IconData icon;

  ProfileFab({this.onPressed, this.tooltip, this.icon});

  @override
  _ProfileFabState createState() => _ProfileFabState();
}

class _ProfileFabState extends State<ProfileFab> with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  initState() {
    _animationController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  /*
   * Selection image methods
   */
  imageSelectorGallery() async {
    File file = await ImagePicker.pickImage(
      source: ImageSource.gallery
    );

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

    if (file != null) {
      Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) => new UploadInfo(file: file)
      ));
    }
  }

  Widget camera() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          imageSelectorCamera();
        },
        tooltip: 'Camera',
        child: Icon(Icons.camera),
      ),
    );
  }

  Widget gallery() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          imageSelectorGallery();
        },
        tooltip: 'Gallery',
        child: Icon(Icons.photo_album),
      ),
    );
  }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Toggle',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: camera(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: gallery(),
        ),
        toggle(),
      ],
    );
  }
}
