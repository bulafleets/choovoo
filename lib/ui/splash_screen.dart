import 'dart:async';

import 'package:choovoo/constants/common_params.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;
  double _height;
  double _width;
  AnimationController _controller;
  Animation<double> _animation;

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  Future<void> navigationPage() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    bool CheckValue = _prefs.containsKey('email');
    print(CheckValue);
    if (CheckValue) {
      name = _prefs.getString('name');
      email = _prefs.getString('email');
      user_id = _prefs.getString('user_id');
      phoneno = _prefs.getString('mobileno');
      profileimg = _prefs.getString('profileimg');
      AccountType = _prefs.getString('role');
      password = _prefs.getString('password');
      authorization = _prefs.getString('token');
      Navigator.of(context).pushReplacementNamed(FINAL_GET_START);
    } else {
      Navigator.of(context).pushReplacementNamed(SELECT_ACCOUNT);
    }
    // Navigator.of(context).pushReplacementNamed(SELECT_ACCOUNT);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        // fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/background.png',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: FadeTransition(
                  opacity: _animation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/logo.png",
                        height: 200,
                        width: 200,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
