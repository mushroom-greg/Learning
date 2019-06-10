import 'package:flutter/material.dart';
import 'package:epicture/image_detail.dart';
import 'package:epicture/profile_fab.dart';

class Profile extends StatefulWidget {
  static String tag = 'profile';

  @override
  State<StatefulWidget> createState() {
    return new ProfileState();
  }
}

class ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Profile'),
        )
      ),
      bottomNavigationBar: ProfileFab(),
      body: Builder(
        builder: (BuildContext context) {
          return ListView(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Colors.orange,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          // @todo replace null "file" variable with image get from Api request
                          builder: (BuildContext context) => new ImageDetail(
                            image: null
                          )
                        ));
                      },
                      child: FlutterLogo(
                        size: 128.0
                    ),
                    ),
                  ),
                  Container(
                    color: Colors.blue,
                    child: FlutterLogo(
                      size: 128.0
                    ),
                  ),
                  Container(
                    color: Colors.purple,
                    child: FlutterLogo(
                      size: 128.0
                    ),
                  )
                ]
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Colors.orange,
                    child: FlutterLogo(
                      size: 128.0
                    ),
                  ),
                  Container(
                    color: Colors.blue,
                    child: FlutterLogo(
                      size: 128.0
                    ),
                  ),
                  Container(
                    color: Colors.purple,
                    child: FlutterLogo(
                      size: 128.0
                    ),
                  )
                ]
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Colors.orange,
                    child: FlutterLogo(
                      size: 128.0
                    ),
                  ),
                  Container(
                    color: Colors.blue,
                    child: FlutterLogo(
                      size: 128.0
                    ),
                  ),
                  Container(
                    color: Colors.purple,
                    child: FlutterLogo(
                      size: 128.0
                    ),
                  )
                ]
              ),
            ],
          );
        },
      )
    );
  }
}
