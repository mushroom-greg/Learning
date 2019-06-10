import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:epicture/logged_main.dart';

class Login extends StatefulWidget {
  static String tag = 'login';

  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logoImage = Container(
      height: 200.0,
      child: Hero(
        tag: 'logo',
        child: Image.asset('assets/logo.png'),
      ),
    );

    final anonymousLabel = FlatButton(
      onPressed: () {},
      child: Text(
        'The connection system is not working at the moment, login anonymously ;)',
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      )
    );

    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
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
          Center(
            child: ListView(
              shrinkWrap: false,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                logoImage,
                SizedBox(height: 48.0),
                makeTextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  hintText: 'Email',
                ),
                SizedBox(height: 8.0),
                makeTextFormField(
                  controller: passwordController,
                  obscureText: true,
                  hintText: 'Password',
                ),
                SizedBox(height: 12.0),
                makeMaterialButton(
                  text: 'Log in',
                  toPage: LoggedMain.tag,
                ),
                anonymousLabel,
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget makeMaterialButton({
    String text = '',
    Color textColor = Colors.white,
    String toPage = ''
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        child: Text(
          text,
          style: TextStyle(color: textColor)
        ),
        color: Theme.of(context).accentColor,
        elevation: 0.0,
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(toPage);
        },
      ),
    );
  }

  Widget makeTextFormField({
    TextInputType keyboardType = TextInputType.text,
    TextEditingController controller,
    bool obscureText = false,
    String hintText = '',
  }) {
    return TextFormField(
      autofocus: false,
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(
        color: Colors.black
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0)
        )
      ),
    );
  }
}
